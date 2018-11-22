#!/bin/bash

echo "==> Cleaning news items"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    eselect news read --quiet
EOF

echo "==> Cleaning Linux sources"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    cd /usr/src/linux && make clean
EOF

echo "==> Clearing temporal folders"
rm -rf ${BASE_DIR}/tmp/*
rm -rf ${BASE_DIR}/var/log/*
rm -rf ${BASE_DIR}/var/tmp/*

echo "==> Consolidating free space"
ZEROFREE="zerofree-1.1.1"
chroot ${BASE_DIR} /bin/bash << EOF
    wget -q http://frippery.org/uml/${ZEROFREE}.tgz
    tar xf ${ZEROFREE}.tgz
    cd ${ZEROFREE} && make
EOF
mv ${BASE_DIR}/${ZEROFREE} /tmp/zerofree
rm ${BASE_DIR}/${ZEROFREE}.tgz
mount -o remount,ro /mnt/gentoo
/tmp/zerofree/zerofree ${DISK}4
swapoff ${DISK}3
dd if=/dev/zero of=${DISK}3
mkswap ${DISK}3

echo "==> Unmounting the filesystems"
umount -l /mnt/gentoo{/dev,/proc,/sys}
umount -R /mnt/gentoo
