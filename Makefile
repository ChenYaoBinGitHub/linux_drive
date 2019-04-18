ifneq ($(KERNELRELEASE),)
MODULE_NAME = hellomodule
$(MODULE_NAME)-objs := hello.o
obj-m := $(MODULE_NAME).o
else
KERNEL_DIR = /lib/modules/`uname -r`/build
MODULEDIR := $(shell pwd)

.PHONY: modules
default: modules

modules:
	make -C $(KERNEL_DIR) M=$(MODULEDIR) modules
	insmod hellomodule.ko	#add drive node file hellomodule  
	mknod /dev/hellodev c 231 0	#creat node to /dev for user to use

clean distclean:
	rm -f *.o *.mod.c .*.*.cmd *.ko
	rmmod hellomodule	#delete drive node
endif
