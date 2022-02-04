FROM i386/alpine:3.15
RUN apk update && \
    apk add openrc mkinitfs

# Install JDK8
RUN apk add --no-cache openjdk8 && \
    rm /usr/bin/javac && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    rm -rf /usr/share/fonts

# Install custom kernel
COPY ./abuild.tar .
COPY ./packages.tar .
RUN tar xvf /packages.tar && \
    tar xvf /abuild.tar && \
    cp /.abuild/*.pub /etc/apk/keys && \
    echo "/packages/main" > /etc/apk/repositories && \
    apk update && \
    apk add linux-virt && \
    echo "root:root" | chpasswd
 
# Clean up packages
RUN rm -rf /packages && \
    rm /packages.tar && \
    rm /abuild.tar

# Clean up other areas of the distro
# RUN rm -rf /usr/share/fonts

# Remount root as rw on boot
COPY ./remount /usr/bin/remount
RUN chmod +x /usr/bin/remount

# Copy init.d scripts
COPY ./init.d/* /etc/init.d/
RUN chmod +x /etc/init.d/remount

# Setup services
RUN rc-update add remount default


# Enable/disable services to default runlevel
RUN rc-update add networking default
#TODO

# Set hostname
RUN echo "wasm" > /etc/hostname

# Remove motd and issue
RUN rm /etc/motd && rm /etc/issue

# Enable Getty on ttys0 for webpage interaction
#TODO



# Clean up unused parts of the JRE to save space
# RUN rm /usr/lib/jvm/java-1.8-openjdk/jre/lib/ext/nashorn.jar

# Copy the JDK nailgun compiler
RUN mkdir /root/compiler
COPY ./RuntimeCompiler/* /root/compiler/