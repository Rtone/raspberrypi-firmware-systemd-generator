# raspberrypi-firmware-systemd-generator

A systemd-generator for mounting the bootloader partitions of the Raspberry Pi
firmware.

## DESCRIPTION

The Raspberry Pi firmware supports A/B booting thanks to the optional
configuration file [autoboot.txt].

In short, the firmware loads the file [autoboot.txt] located in the first VFAT
partition; that file specifies the partition on which the bootloader files are
located ([config.txt], kernel image...). The bootloader mounts that secondary
VFAT partition and reads its files to complete its booting task.

In all, the firmware mounts two partitions if booting via the configuration
file [autoboot.txt]:
 - the first partition holds the file [autoboot.txt]
 - the other partition holds the bootloader files ([config.txt], `kernel` image
   and `cmdline`, bootloader blobs if needed...)

[raspberrypi-firmware-generator(1)] is a [systemd.generator(7)] for mounting
the bootloader partitions of the Raspberry Pi firmware.

It generates a [systemd.mount(5)] unit for the booted partition set by the
firmware to the device-tree blob node `/chosen/bootloader/partition`.

That secondary `boot_partition` is mounted to `/boot/firmware` as per the new
[bookworm] specifications of the [Raspberry Pi OS]. It is mounted after the
first partition; that has to be mounted first to `/boot`. It could be mounted
either by an entry in the [fstab(5)] and the [systemd-fstab-generator(8)] or by
the [systemd-gpt-auto-generator(8)] if the partition table is GPT and if the
root device is on the same device.

## REQUIREMENTS

### BASH

The [Bourne Again shell] since the systemd generator is a shell script using
the compound command `[[` bashism.

_Important_: [raspberrypi-firmware-generator(1)] is written in pure [bash(1)].

### FDTGET

The device-tree compiler [fdtget] utility to read the bootloader values from
the device-tree.

## INSTALL

Run the following command to install *raspberrypi-firmware-generator(1)*

	$ sudo make install

Traditional variables *DESTDIR* and *PREFIX* can be overridden

	$ sudo make install PREFIX=/opt/raspberrypi-firmware-systemd-generator

Or

	$ make install DESTDIR=$PWD/pkg PREFIX=/usr

## EMBEDDED BUILD SYSTEMS

A [Buildroot package] is available in the br2-external [rtone-br2-external] and
a [Bitbake recipe] is available in the layer [meta-downstream].

## PATCHES

Submit patches at <https://github.com/Rtone/raspberrypi-firmware-systemd-generator/pulls>

## BUGS

Report bugs at <https://github.com/Rtone/raspberrypi-firmware-systemd-generator/issues>

## AUTHOR

Written by Gaël PORTAY *gael.portay@rtone.fr*

## COPYRIGHT

Copyright 2024-2025 Gaël PORTAY

Copyright 2024-2025 Rtone

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation, either version 2.1 of the License, or (at your option) any
later version.

## SEE ALSO

[fdtget], [systemd-fstab-generator(8)], [systemd-gpt-auto-generator(8)],
[systemd.generator(7)]

[Bitbake recipe]: https://github.com/gportay/meta-downstream/blob/master/meta-rauc-raspberrypi-firmware/recipes-bsp/raspberrypi-firmware-systemd-generator/raspberrypi-firmware-systemd-generator_git.bb
[Bourne Again shell]: https://www.gnu.org/software/bash/
[Buildroot package]: https://github.com/Rtone/rtone-br2-external/tree/main/package/raspberrypi-firmware-systemd-generator
[Raspberry Pi OS]: https://www.raspberrypi.com/software/
[autoboot.txt]: https://www.raspberrypi.com/documentation/computers/config_txt.html#autoboot-txt
[bash(1)]: https://linux.die.net/man/1/bash
[bookworm]: https://www.raspberrypi.com/documentation/computers/config_txt.html#what-is-config-txt
[config.txt]: https://www.raspberrypi.com/documentation/computers/config_txt.html
[fdtget]: https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/fdtget.c
[fstab(5)]: https://linux.die.net/man/5/fstab
[meta-downstream]: https://www.portay.io/meta-downstream
[meta-rauc-raspberrypi-firmware]: https://github.com/gportay/meta-downstream/blob/master/meta-rauc-raspberrypi-firmware
[raspberrypi-firmware-generator(1)]: raspberrypi-firmware-generator
[rtone-br2-external]: https://rtone.github.io/rtone-br2-external
[sh(1)]: https://linux.die.net/man/1/sh
[systemd-fstab-generator(8)]: https://www.freedesktop.org/software/systemd/man/latest/systemd-fstab-generator.html
[systemd-gpt-auto-generator(8)]: https://www.freedesktop.org/software/systemd/man/latest/systemd-gpt-auto-generator.html
[systemd.generator(7)]: https://www.freedesktop.org/software/systemd/man/latest/systemd.generator.html
[systemd.mount(5)]: https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html
[tryboot]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#fail-safe-os-updates-tryboot
