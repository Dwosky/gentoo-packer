#!/bin/bash

echo "==> Binding the needed filesystems"
if [ ! -d ${BASE_DIR}/proc ]; then mkdir -p ${BASE_DIR}/proc; fi
mount --types proc /proc ${BASE_DIR}/proc
if [ ! -d ${BASE_DIR}/sys ]; then mkdir -p ${BASE_DIR}/sys; fi
mount --rbind /sys ${BASE_DIR}/sys
mount --make-rslave ${BASE_DIR}/sys
if [ ! -d ${BASE_DIR}/dev ]; then mkdir -p ${BASE_DIR}/dev; fi
mount --rbind /dev ${BASE_DIR}/dev
mount --make-rslave ${BASE_DIR}/dev 
