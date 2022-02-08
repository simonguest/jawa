# Create a partitioned base image
qemu-img create build/jawa.img 164M
parted -s build/jawa.img \
    'mklabel msdos' \
    'mkpart primary ext4 2048s 100%' \
    'set 1 boot on'

# Format the partition with ext4
losetup -D
LOOPDEVICE=$(losetup -f)
echo -e "\n[Using ${LOOPDEVICE} loop device]"
losetup -o $(expr 512 \* 2048) ${LOOPDEVICE} /build/jawa.img
mkfs.ext4 ${LOOPDEVICE}

# Extract and copy contents of filesystem to image
mkdir /tmp/fs
tar -xvf build/filesystem.tar -C /tmp/fs
mkdir -p /mnt/image
mount -t auto ${LOOPDEVICE} /mnt/image
cp -R /tmp/fs/. /mnt/image

# Setup extlinux and write syslinux MBR
extlinux --install /mnt/image/boot
cp /syslinux.cfg /mnt/image/boot/.
dd if=/usr/lib/syslinux/mbr/mbr.bin of=/build/jawa.img bs=440 count=1 conv=notrunc

# Change permissions so that host can launch
chmod 777 /build/jawa.img

# Clean up
losetup -D
umount /mnt/image