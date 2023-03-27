#!/usr/bin/bash
# CREATING VIRTULA DISKS WITH QEMU AND ATTATCH BY KVM's VIRTIO

SIZE="10G"
HDFS_MACHINE="deb_hdfs"
DISK_PATH=/path/to/storages

# Emulate virtual disks
for i in {1..3}; do
    qemu-img create -f qcow2  "$DISK_PATH/disk_${i}.qcow2" $SIZE
done

# Attatch them to VM (HDFS machine or machines)
for i in {1..3}; do
    virsh attach-disk $HDFS_MACHINE "$DISK_PATH/disk_${i}.qcow2" "ext_disk_${i}" --targetbus virtio --subdriver qcow2 --config --live
done


