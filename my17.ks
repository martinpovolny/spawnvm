# Kickstart file automatically generated by anaconda.

#version=DEVEL
install
lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --noipv6 --hostname vladivostok
timezone --utc Europe/Prague
#rootpw  --iscrypted $6$aAifaAc/4/nkK8zl$48lsl8sozakTM7TBBQnJMDNcjA6JKngsSj6mauikkIO38nSkQet9WG8CUD634ox0HX2n5UZ2s0sjQexfroyRD1
rootpw  test
selinux --enforcing
skipx
authconfig --enableshadow --passalgo=sha512
firewall --service=ssh
# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
clearpart --all --initlabel --drives=vda

part pv.252003 --grow --size=500
volgroup vg_vladivostok --pesize=32768 pv.252003
logvol swap --name=lv_swap --vgname=vg_vladivostok --grow --size=1008 --maxsize=2016
logvol / --fstype=ext4 --name=lv_root --vgname=vg_vladivostok --grow --size=1024 --maxsize=51200
part /boot --fstype=ext4 --size=500
part biosboot --fstype=biosboot --size=1

bootloader --location=mbr --timeout=5 --append="rhgb quiet"

repo --name="Fedora 17 - x86_64"  --baseurl="http://download.fedoraproject.org/pub/fedora/linux/releases/17/Everything/x86_64/os/" --cost=1000
repo --name="Fedora 17 - x86_64 - Updates"  --baseurl="http://download.fedoraproject.org/pub/fedora/linux/updates/17/x86_64/" --cost=1000
#repo --name="Fedora - Aeolus - Testing"  --baseurl="http://repos.fedorapeople.org/repos/aeolus/conductor/testing/fedora-$releasever/$basearch/" --cost=1000
repo --name="Fedora - Aeolus - Nightly"  --baseurl="http://virtlab30.virt.bos.redhat.com/aeolus-nightly/fedora-17/x86_64/" --cost=1000


reboot

%packages
@core
@online-docs
@development-tools
#@development-libraries
vim-enhanced
aeolus-all
aeolus-conductor-devel
bash-completion
git-all
wget
%end

%post --log=/root/post-log
echo "Running post install config"
echo "Running aeolus-configure"
/usr/sbin/aeolus-configure -p mock,ec2
#echo "Adding nfs mount"
#echo 192.168.122.1:/home/mzatko/work/tasks /mnt nfs4 defaults 0 0 >> /etc/fstab

echo "Adding user"
/usr/sbin/useradd test
echo test | /usr/bin/passwd --stdin test

#cp /usr/local/bin/srcfetch

echo "done"
%end

