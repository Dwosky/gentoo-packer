#!/bin/bash

echo "==> Mounting the created filesystems"
mount ${DISK}4 ${BASE_DIR}
mkdir ${BASE_DIR}/boot
mount ${DISK}1 ${BASE_DIR}/boot
