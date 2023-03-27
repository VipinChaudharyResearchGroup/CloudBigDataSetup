.PHONY: bin

include .env
export


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

