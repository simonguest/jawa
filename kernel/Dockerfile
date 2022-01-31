FROM i386/alpine:3.15
RUN apk update
RUN apk add alpine-sdk sudo ncurses-dev flex bison
RUN git clone -b v3.15.0 --single-branch https://gitlab.alpinelinux.org/alpine/aports
RUN mkdir -p /var/cache/distfiles
COPY ./menuconfig.sh /menuconfig.sh
COPY ./build.sh /build.sh

#RUN cd /aports/main/linux-lts

#RUN abuild-keygen -a -i -n

# TODO: Copy the .config and overwrite the config-virt.x86 file
#RUN abuild checksum

#RUN abuild -FrK




