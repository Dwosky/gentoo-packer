#!/bin/bash

echo "==> Emerging the latest kernel sources & genkernel"

echo "sys-apps/util-linux static-libs" >> ${BASE_DIR}/etc/portage/package.use/genkernel
echo "sys-kernel/gentoo-sources symlink" >> ${BASE_DIR}/etc/portage/package.use/genkernel
echo "sys-kernel/linux-firmware linux-fw-redistributable no-source-code" >> ${BASE_DIR}/etc/portage/package.license
chroot ${BASE_DIR} /bin/bash << 'EOF'
    emerge -q sys-kernel/gentoo-sources sys-kernel/genkernel
EOF

echo "==> Configure and build the kernel with genkernel"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    genkernel --install --no-dmraid --no-zfs --no-btrfs --no-nfs all
EOF
