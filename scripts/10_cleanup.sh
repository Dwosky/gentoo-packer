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
chroot ${BASE_DIR} /bin/bash << 'EOF'
    wget -q http://frippery.org/uml/zerofree-1.1.1.tgz
    tar xf zerofree-1.1.1.tgz
    cd zerofree-1.1.1 && make
EOF
mv ${BASE_DIR}/zerofree-1.1.1 /tmp/zerofree
mount -o remount,ro /mnt/gentoo
/tmp/zerofree/zerofree ${DISK}4
swapoff ${DISK}3
dd if=/dev/zero of=${DISK}3
mkswap ${DISK}3

echo "==> Unmounting the filesystems"
umount -l /mnt/gentoo/dev{/shm,/pts,/proc,/sys}
umount -R /mnt/gentoo
