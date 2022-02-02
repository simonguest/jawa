FROM i386/alpine:3.8
RUN apk update
RUN apk add --no-cache openjdk8 && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    rm -rf /usr/share/fonts
RUN apk add git alpine-sdk maven
RUN git clone https://github.com/facebook/nailgun
COPY ./build.sh /build.sh








