FROM i386/alpine:3.15
RUN apk update && \
    apk add openrc mkinitfs util-linux

# Install custom kernel and set root pw
# COPY ./*.apk /tmp/
#RUN touch repo.list && apk add --repositories-file=repo.list --allow-untrusted --no-network --no-cache /tmp/linux-virt-5.15.4-r0.apk && \
COPY ./install-kernel.sh /
RUN echo "root:root" | chpasswd

# Remount root as rw on boot
COPY ./remount /usr/bin/remount
RUN chmod +x /usr/bin/remount

# Script to configure networking and bring the loopback interface up
COPY ./interfaces /etc/network/
COPY ./loopback /usr/bin/loopback
RUN chmod +x /usr/bin/loopback

# Script to set the hostname correctly
COPY ./hostname /usr/bin/hostname
RUN chmod +x /usr/bin/hostname

# Copy init.d scripts
COPY ./init.d/* /etc/init.d/
RUN chmod +x /etc/init.d/remount
RUN chmod +x /etc/init.d/loopback
RUN chmod +x /etc/init.d/hostname

# Setup services
RUN rc-update add remount default
RUN rc-update add loopback default
RUN rc-update add networking default
RUN rc-update add hostname default

# Set hostname
RUN echo "127.0.0.1  localhost  wasm" > /etc/hosts

# Remove motd and issue
RUN rm /etc/motd && rm /etc/issue

# Enable Getty on ttys0 for webpage interaction
RUN echo "ttyS0::respawn:/sbin/agetty --autologin root -L ttyS0 115200 vt100" >> /etc/inittab