#
# Copyright 2024 Gaël PORTAY
#           2024 Rtone
#
# SPDX-License-Identifier: LGPL-2.1-or-later
#

PREFIX ?= /usr/local

.PHONY: all
all: check

.PHONY: install
install:
	generatordir=$${SYSTEMDSYSTEMGENERATORDIR:-$$(pkg-config --define-variable=prefix=$(PREFIX) \
								 --variable=systemdsystemgeneratordir \
								 systemd 2>/dev/null)}; \
	if [ -n "$$generatordir" ]; then \
		install -D -m 755 raspberrypi-firmware-generator $(DESTDIR)$$generatordir/raspberrypi-firmware-generator; \
	fi

.PHONY: uninstall
uninstall:
	generatordir=$${SYSTEMDSYSTEMGENERATORDIR:-$$(pkg-config --define-variable=prefix=$(PREFIX) \
								 --variable=systemdsystemgeneratordir \
								 systemd 2>/dev/null)}; \
	if [ -n "$$generatordir" ]; then \
		rm -f $(DESTDIR)$$generatordir/raspberrypi-firmware-generator; \
	fi

.PHONY: check
check: raspberrypi-firmware-generator
	shellcheck $^
