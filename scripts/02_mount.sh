#!/bin/bash

echo "==> Mounting the created filesystems"
mount ${DISK}4 ${BASE_DIR}
mkdir ${BASE_DIR}/boot
mount ${DISK}1 ${BASE_DIR}/boot

echo "==> Binding the needed filesystems"
mount --types proc /proc ${BASE_DIR}/proc
mount --rbind /sys ${BASE_DIR}/sys
mount --make-rslave ${BASE_DIR}/sys
mount --rbind /dev ${BASE_DIR}/dev
mount --make-rslave ${BASE_DIR}/dev 
