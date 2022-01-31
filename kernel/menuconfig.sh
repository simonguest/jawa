cd /aports/main/linux-lts
abuild -F unpack
cd src/linux-5.15
cp /source/config-virt.x86 .config
TERM=xterm make menuconfig
cp .config /source/config-virt.x86