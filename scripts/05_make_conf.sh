#!/bin/bash

MAKE_CONF=${BASE_DIR}/etc/portage/make.conf
MAKE_OPS="-j$(( ${N_CPU} + 1 ))"

echo "==> Update $MAKE_CONF with base configuration for the Box"
sed -i "s/COMMON_FLAGS=.*/COMMON_FLAGS=\"-march=native -O2 -pipe\"/g" $MAKE_CONF
echo "MAKEOPS=\"${MAKE_OPS}\"" >> $MAKE_CONF

echo "==> Selecting the best mirrors in $MAKE_CONF"
mirrorselect -s3 --region ${REGION} -D -o >> $MAKE_CONF

echo "==> Setup ebuild repository"
mkdir --parents ${BASE_DIR}/etc/portage/repos.conf
cp ${BASE_DIR}/usr/share/portage/config/repos.conf ${BASE_DIR}/etc/portage/repos.conf/gentoo.conf
mkdir --parents ${BASE_DIR}/var/db/repos/gentoo
