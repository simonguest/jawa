FROM jawa/base:latest

# Install JDK8
RUN apk add --no-cache openjdk8 && \
    rm /usr/bin/javac && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    rm -rf /usr/share/fonts

# Copy and precompile the JDK nailgun compiler
RUN mkdir /root/compiler
COPY ./RuntimeCompiler/* /root/compiler/
RUN cd /root/compiler && javac RuntimeCompiler.java