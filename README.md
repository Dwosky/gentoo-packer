# gentoo-packer
This repo contains a configurable Packer template to build a Gentoo Virtualbox image.

## Configure

The base configuration of the template its on the `variables` section of `gentoo-base.json`


## Usage

1. Build the base Gentoo VirtualBox image using [Packer](packer.io):
```
> ./packer.exe build -force gentoo-base.json
```
2. Add the box to [Vagrant](https://www.vagrantup.com/) or [VirtualBox](https://www.virtualbox.org/) directly:
```
> ./vagrant.exe box add output/gentoo-amd64-stage3-virtualbox.box --name Gentoo --force
```
