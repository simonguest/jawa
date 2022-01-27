FROM i386/alpine:latest
RUN apk update
RUN apk add openrc linux-virt
RUN echo "root:root" | chpasswd
RUN apk add openjdk8
RUN rm /usr/bin/javac && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac
COPY ./HelloWorld.java /root/HelloWorld.java

