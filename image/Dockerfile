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


# Clean up unused parts of the JRE to save space
# RUN rm /usr/lib/jvm/java-1.8-openjdk/jre/lib/ext/nashorn.jar

# Copy the JDK nailgun compiler
RUN mkdir /root/compiler
COPY ./RuntimeCompiler/* /root/compiler/