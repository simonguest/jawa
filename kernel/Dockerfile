FROM i386/debian:11.2
RUN apt update
RUN apt install -y curl xz-utils git fakeroot build-essential ncurses-dev libssl-dev bc flex libelf-dev bison
#RUN apk update
#RUN apk add curl git fakeroot ncurses-dev flex bison
RUN curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.16.4.tar.xz
RUN tar -xvf linux-5.16.4.tar.xz
RUN cd linux-5.16.4
RUN make tinyconfig
RUN make -j16




