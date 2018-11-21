#!/bin/bash

echo "==> Downloading the Stage3 tarball to ${BASE_DIR}"
cd ${BASE_DIR}
wget -q ${MIRROR_URL}/${TARBALL}
echo "==> Unpacking the tarball ${TARBALL}"
tar xpf ${TARBALL} --xattrs-include='*.*' --numeric-owner
echo "==> Removing the tarball ${TARBALL}"
rm ${TARBALL}
