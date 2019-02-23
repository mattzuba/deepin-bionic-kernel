## Bionic Kernel Updates in Deepin

Deepin Linux uses an Ubuntu Bionic kernel (`apt changelog linux-image-unsigned-4.15.0-29deepin-generic`), but unfortunately they don't keep it updated.  In a nutshell, these scripts will add the `bionic-security` repo to Deepin, pin it with a -1 priority as to not disturb Deepin packages, pin kernel images, modules and headers at 1, and pin microcode at 500.

It then adds a daily cron script which will check if there are any updates to the Ubuntu Bionic kernel version and create some new meta packages to keep the kernel updated.

## Installation

```shell
$ git clone https://github.com/mattzuba/deepin-bionic-kernel`
$ cd deepin-bionic-kernel
$ sudo ./install.sh
$ sudo /etc/cron.daily/bionic-kernel
```

## Usage

There is support for upgrading to the latest Bionic Kernel, or using the HWE kernel.  To use the latest Bionic Kernel:

`sudo apt install linux-image-generic linux-headers-generic`

To use the latest HWE kernel

`sudo apt install linux-image-generic-hwe-18.04 linux-headers-generic-hwe-18.04`
