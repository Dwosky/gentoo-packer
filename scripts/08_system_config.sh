#!/bin/bash

echo "==> Configure hostname"
sed -i 's/hostname=.*/hostname=\"gentoo-box\"//g' ${BASE_DIR}/etc/conf.d/hostname

echo "==> Configure networking"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    ln -s /etc/init.d/net.lo /etc/init.d/net.eth0
    echo 'config_eth0=( "dhcp" )' >> /etc/conf.d/net
    rc-update add net.eth0 default
EOF

echo "==> Configure GRUB bootloader"
echo "GRUB_PLATFORMS=\"pc\"" >> ${BASE_DIR}/etc/portage/make.conf
chroot ${BASE_DIR} /bin/bash << 'EOF'
    emerge -q sys-boot/grub:2
    sed -i 's/^#\s*GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0"/' /etc/default/grub
    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
EOF

echo "==> Installing Virtual Box guest additions"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    emerge -q app-emulation/virtualbox-guest-additions
EOF

echo "==> Configuring SSH daemon to autostart"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    rc-update add sshd default
EOF
