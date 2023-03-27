# HDFS setup

## Setup HDFS in distributed mode

- Firstly, run `create_external_disks.sh` to create virtual disks
- Secondly, start HDFS machine(s) then run the following commands
- Finally, modify `hadoop/conf/hdfs-site.xml` or `hadoop/etc/hadoop/hdfs-site.xml`

```bash
mkdir /mnt/disk
```

```
mkfs.ext4 /dev/ext_disk_${i}
```

```bash
mount /dev/ext_disk_${i} /mnt/disk
```

The number of disks created with `create_external_disks.sh` is "i".

```bash
sudo parted -s -- /dev/ext_disk_${i} mklabel gpt
sudo parted -s -a optimal -- /dev/ext_disk_${i} mkpart primary 0% 100%
sudo parted -s -- /dev/ext_disk_${i} align-check optimal 1
sudo mkfs.ext4 /dev/ext_disk_${i}
sudo mkdir /storage
echo "/dev/ext_disk_${i} /storage ext4 defaults 0 0" | sudo tee -a /etc/fstab
sudo mount -a
sudo mkdir -p /storage/hdfs/{namenode,datanode}
```
