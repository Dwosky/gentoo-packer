#!/bin/bash

echo "==> Installing sudo"
echo "app-admin/sudo -sendmail" >> ${BASE_DIR}/etc/portage/package.use/sudo
chroot ${BASE_DIR} /bin/bash << 'EOF'
    emerge -q app-admin/sudo
EOF

echo "==> Configuring vagrant user and keys"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    useradd --comment 'Vagrant User' --create-home --user-group vagrant -s /bin/bash
    echo 'vagrant:vagrant' | chpasswd
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
    install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
    curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
    chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
    chmod 0600 /home/vagrant/.ssh/authorized_keys
EOF
