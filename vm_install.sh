#!/bin/usr/bash

echo "Number of cores:"
egrep -c '(vmx|svm)' /proc/cpuinfo

echo "KVM acceleration"
CHK=$(kvm-ok | grep "can be used")
if [[ $CHK=="KVM acceleration can be used" ]]; then
    echo "Checked."
else
    echo "KVM doesn't work."
    exit 1
fi

PKG="qemu-kvm libvirt-daemon-system libvirt-clients virtinst bridge-utils"

sudo apt update
sudo apt upgrade
sudo apt install -y $PKG
