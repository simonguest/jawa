apk add xz
cd /aports/main/linux-lts
cp /source/config-virt.x86 .
cp config-virt.x86 config-lts.x86
abuild -F checksum
abuild-keygen -a -i -n
abuild -FrK
cd ~/pagkages
cp linux-virt*.apk /source/build

