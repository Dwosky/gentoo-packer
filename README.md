# gentoo-packer
This repo contains a configurable Packer template to build a Gentoo Virtualbox or Gentoo QEMU image.

## Configure

The base configuration of the template its on the `variables` section of `gentoo-vbox.json` or `gentoo-qemu.json` files.


## Usage

### Generate image for VirtualBox

1. Build the base Gentoo VirtualBox image using [Packer](packer.io):
```
> ./packer.exe build -force gentoo-vbox.json
```
2. Add the box to [Vagrant](https://www.vagrantup.com/) or [VirtualBox](https://www.virtualbox.org/) directly:
```
> ./vagrant.exe box add output/gentoo-amd64-stage3-virtualbox.box --name Gentoo --force
```

### Generate image for QEMU

1. Build the base Gentoo VirtualBox image using [Packer](packer.io):
```
$ packer build gentoo-qemu.json
```

2. Run the box in [QEMU](https://www.qemu.org/) or your favourite virtualization suite:
```
$ qemu-system-x86_64 -drive file=output-qemu/Gentoo_Vagrant.qcow2 [extra QEMU args]
```