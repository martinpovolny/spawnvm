#!/usr/bin/bash

VERSION=18
IMG=f${VERSION}_$(date +%F-%H-%M)
IMG_PATH='/home/vm'

echo $IMG

virt-install --connect qemu:///system \
  -l http://ftp.linux.cz/pub/linux/fedora-releases/18/fedora/x86_64/os/ \
  -n $IMG \
  --ram 1024 \
  --disk path=${IMG_PATH}/$IMG,size=10 \
  --initrd-inject=my${VERSION}.ks \
  --extra-args "ks=file:/my${VERSION}.ks" \
  --virt-type kvm \
  --os-type linux \
  --os-variant fedora$VERSION \
  --graphics type=vnc \
  -w network=default
