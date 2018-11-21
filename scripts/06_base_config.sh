#!/bin/bash

echo "==> Copy resolv.conf to base directory ${BASE_DIR}"
cp --dereference /etc/resolv.conf ${BASE_DIR}/etc/

echo "==> Updating portage tree"
chroot ${BASE_DIR} /bin/bash << 'EOF'
    if [ ! -d /usr/portage ]; then
        mkdir /usr/portage
    fi
    emerge-webrsync
EOF

echo "==> Setting the timezone to UTC"
echo "UTC" > ${BASE_DIR}/etc/timezone
chroot ${BASE_DIR} /bin/bash << 'EOF'
    emerge --config sys-libs/timezone-data
EOF

echo "==> Setting /etc/fstab entries"
echo "# <fs>    <mount>	<type>	<opts>		<dump/pass>" >> $BASE_DIR/etc/fstab
echo "/dev/sda1	/boot	ext2	noauto,noatime	1 2" >> $BASE_DIR/etc/fstab
echo "/dev/sda4	/	    ext4	noatime		    0 1" >> $BASE_DIR/etc/fstab
echo "/dev/sda3	none	swap	sw		        0 0" >> $BASE_DIR/etc/fstab
