#!/usr/bin/make -f

#
#  Copyright 2007-2023 Alex Vesev
#
#  This file is part of Sync Tools.
#
#  Sync Tools is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Sync Tools is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Sync Tools. If not, see <https://www.gnu.org/licenses/>.
#
##

DIR_ORIGIN = .

all: install

install:
	bash setup.sh --install --dir-origin "${DIR_ORIGIN}" --dir-destination $(DESTDIR)

deb:
	fakeroot dpkg-buildpackage -b -us -uc # XXX - GPG sign?

clean:
	echo "INFO:${0}:pid=${$}: Nothing to be done for cleanup after this DEB package build."
