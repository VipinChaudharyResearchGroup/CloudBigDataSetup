.PHONY: bin
include .env
export

PATH := $(SPARK_HOME)/sbin:$(SPARK_HOME)/bin:$(PATH)

%: # https://www.gnu.org/software/make/manual/make.html#Automatic-Variables 
		@:

start:
		sudo systemctl start libvirtd

net-def:
		virsh net-define $(NETWORK).xml
	
net-start:
		virsh net-start $(NETWORK)

vm-define: start
		virt-install \
			--name $(VM) \
			--os-variant debian11  \
			--memory 2048 \
			--vcpus 2 \
			--network bridge:$(NETWORK) \
			--disk path=$(STORAGE)/$(VMTA).qcow2,size=20 \
			--cdrom $(ISO)/debian-11.6.0-amd64-netinst.iso"

spark-check:
		ss -tunelp | grep 8080
		ss -tunelp | grep 7077
		ps aux | grep spark

spark-start-master:
		start-master.sh

spark-stop-master:
		stop-master.sh

spark-start-worker:
		start-worker.sh spark://localhost:7077

spark-stop-worker:
		stop-worker.sh

spark-stop-all:
		stop-all.sh
