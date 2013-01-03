#!/usr/bin/bash

VERSION=17
IMG=f${VERSION}_$(date +%F-%H-%M)
IMG_PATH='/home/vm'

echo $IMG

virt-install --connect qemu:///system \
  -l http://download.fedoraproject.org/pub/fedora/linux/releases/$VERSION/Fedora/x86_64/os/ \
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
