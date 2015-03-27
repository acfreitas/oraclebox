set -e
set -x

if [ grep -ic "64GB" /sizeDisk]
then
   echo "Disk already added so exiting!"
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1

																																																																																				
t
8e
w
EOF

sudo pvcreate /dev/sdb1
sudo vgextend VolGroup /dev/sdb1
sudo lvextend -L64GB /dev/VolGroup/lv_root																																																																																																					
sudo resize2fs /dev/VolGroup/lv_root

df -h &> /sizeDisk																																																									