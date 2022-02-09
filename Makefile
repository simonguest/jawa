.DEFAULT_TARGET: all

all: build base jdk image

build:
	mkdir -p $@
	touch $@

.PHONY: base
base:
	cp ./kernel/build/*.apk ./build
	docker build --no-cache base/. -t jawa/base:latest
	docker run -v `pwd`/build:/build:rw --privileged jawa/base:latest /bin/sh /install-kernel.sh
	docker commit `docker ps -a | awk 'NR > 1 {print $$1}' | head -n 1` jawa/base:latest

base-interactive:
	docker run -ti jawa/base:latest /bin/sh

.PHONY: jdk
jdk:
	docker build jdk/. -t jawa/jdk:latest

jdk-interactive:
	docker run -ti -v `pwd`/jdk:/jdk:rw jawa/jdk:latest /bin/sh

.PHONY: image
image:
	docker export -o build/filesystem.tar `docker run -d jawa/jdk:latest`
	docker build image/. -t jawa/image-builder:latest
	docker run -v `pwd`/build:/build:rw --privileged jawa/image-builder:latest bash /build.sh

test:
	qemu-system-x86_64 -drive file=build/jawa.img,index=0,media=disk,format=raw -m 4096

run:
	python -m SimpleHTTPServer

.PHONY: kernel
kernel:
	docker build kernel/. -t jawa/kernel:latest
	docker run -ti -v `pwd`/kernel:/source:rw jawa/kernel:latest sh /build.sh

kernel-configure:
	docker build kernel/. -t jawa/kernel:latest
	docker run -ti -v `pwd`/kernel:/source:rw jawa/kernel:latest sh /menuconfig.sh

.PHONY: nailgun
nailgun:
	docker build nailgun/. -t jawa/nailgun:latest
	docker run -ti -v `pwd`/nailgun:/output:rw jawa/nailgun:latest sh /build.sh

.PHONY: clean
clean:
	rm -rf ./build
	docker rmi -f jawa/base:latest
	docker rmi -f jawa/jdk:latest
	docker rmi -f jawa/image-builder:latest