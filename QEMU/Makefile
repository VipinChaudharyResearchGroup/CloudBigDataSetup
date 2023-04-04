


VMNAME := deb
qemu-create: #Creating a disk
		qemu-img create -f qcow2 "$(VMNAME).qcow2" 20G

#		f: format


qemu-install: #Createing a VM
		qemu-system-x86_64 -hda "$(VMNAME).qcow2" -m 6G -smp 2 -cdrom /path/to/images/debian-11.4.0-amd64-netinst.iso -boot d


  
qemu-run: #Run the created VM
		qemu-system-x86_64 -hda "$(VMNAME).qcow2" -m 2G -smp 2

path := /home/mohsen/virtspace/deb_qem2.qcow2

qemu-run-net:
		qemu-system-x86_64 -hda "$(path)" -m 2G -smp 2 
#qemu-run-net:
#		qemu-system-x86_64 -had "$(path)" -m 2G -smp 2 -netdev user,id=net0 -device virtio-net,netdev=net0
#-netdev user,id=mynet0,net=192.168.76.0/24,dhqu	cpstart=192.168.76.9


sudo ip link add br0 type bridge
sudo ip link set br0 up