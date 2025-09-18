#!/bin/sh
# Copyright 2025 Simon McVittie
# SPDX-License-Identifier: MIT

glib_version=$(dpkg-query -W -f '${Version}' "libglib2.0-dev:$DEB_HOST_ARCH")

if dpkg --compare-versions "$glib_version" ge 2.86; then
    echo "local:Depends=gir1.2-glib-2.0 (>= 2.86.0)"
else
    echo "local:Depends=gir1.2-glib-2.0 (<< 2.86.0)"
fi
