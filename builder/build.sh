# Create a partitioned base image - not sure why this doesn't work in container
qemu-img create image/output/jawa.img 256M
parted -s image/output/jawa.img \
    'mklabel msdos' \
    'mkpart primary ext4 2048s 100%' \
    'set 1 boot on'

# Format the partition with ext4
losetup -D
LOOPDEVICE=$(losetup -f)
echo -e "\n[Using ${LOOPDEVICE} loop device]"
losetup -o $(expr 512 \* 2048) ${LOOPDEVICE} /image/output/jawa.img
mkfs.ext4 ${LOOPDEVICE}

# Extract and copy contents of tar file to image
mkdir /tmp/fs
tar -xvf image/fs.tar -C /tmp/fs
mkdir -p /mnt/image
mount -t auto ${LOOPDEVICE} /mnt/image
cp -R /tmp/fs/. /mnt/image

# Setup networking
cp /image/interfaces /mnt/image/etc/network/

# Setup extlinux and write syslinux MBR
extlinux --install /mnt/image/boot
cp /image/syslinux.cfg /mnt/image/boot/.
dd if=/usr/lib/syslinux/mbr/mbr.bin of=/image/output/jawa.img bs=440 count=1 conv=notrunc

# Change permissions so that host can launch
chmod 777 /image/output/jawa.img

# Clean up
losetup -D
umount /mnt/image