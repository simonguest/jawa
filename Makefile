config-kernel:
	docker build kernel/. -t jawa/kernel:latest
	docker run -ti -v `pwd`/kernel:/source:rw jawa/kernel:latest sh /menuconfig.sh

build-kernel:
	docker build kernel/. -t jawa/kernel:latest
	docker run -ti -v `pwd`/kernel:/source:rw jawa/kernel:latest sh /build.sh

create-fs:
	docker build image/. -t jawa/fs:latest
	docker export -o image/fs.tar `docker run -d jawa/fs:latest`

build:
	docker build builder/. -t jawa/builder:latest
	docker run -v `pwd`/image:/image:rw --privileged jawa/builder:latest bash /build.sh

build-interactive:
	docker run -ti -v `pwd`/image:/image:rw --privileged jawa/builder:latest bash

test:
	qemu-system-x86_64 -drive file=image/output/jawa.img,index=0,media=disk,format=raw -m 4096

run:
	python -m SimpleHTTPServer

clean:
	rm -f image/base.img
	rm -f image/output/jawa.img
	rm -f image/fs.tar
	docker rmi -f jawa/builder:latest
	docker rmi -f jawa/fs:latest