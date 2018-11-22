#!/bin/bash

echo "==> Create GPT partition table on ${DISK}"
sgdisk -og ${DISK}

echo "==> Creating /boot partition on ${DISK}"
sgdisk -n 1:0:+128M -c 1:"Linux boot partition" -t 1:8300 ${DISK}

echo "==> Creating GRUB partition on ${DISK}"
sgdisk -n 2:0:+32M -c 2:"Linux GRUB partition" -t 2:ef02 -A 2:set:2 ${DISK}

echo "==> Creating swap partition on ${DISK}"
sgdisk -n 3:0:+1G -c 3:"Linux swap partition" -t 3:8200 ${DISK}

echo "==> Creating /root partition on ${DISK}"
sgdisk -n 4:0:0 -c 4:"Linux root partition" -t 4:8300 ${DISK}

echo "==> Formating the partitions on ${DISK}"
sync
mkfs.ext2 ${DISK}1
mkswap ${DISK}3 && swapon ${DISK}3
mkfs.ext4 ${DISK}4
