#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for version numbers
#!# Date: Oct 28, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/version.test ; less tests/version.log
#!#
#!#	that will select these tests.
#!#
#!# Copyright (c) 2024 Marco Maggi
#!# <mrc.mgg@gmail.com>
#!#
#!# This program is free  software: you can redistribute it and/or modify it  under the terms of the
#!# GNU General Public License as published by the Free Software Foundation, either version 3 of the
#!# License, or (at your option) any later version.
#!#
#!# This program  is distributed  in the  hope that  it will  be useful,  but WITHOUT  ANY WARRANTY;
#!# without even the implied  warranty of MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See
#!# the GNU General Public License for more details.
#!#
#!# You should have received  a copy of the GNU General Public License  along with this program.  If
#!# not, see <http://www.gnu.org/licenses/>.
#!#


#### macros

MBFL_DEFINE_SPECIAL_MACROS
MBFL_DEFINE_UNDERSCORE_MACRO


#### setup

mbfl_embed_library(__LIBMBFL_LINKER__)
mbfl_linker_source_library_by_stem(core)
mbfl_linker_source_library_by_stem(tests)
mbfl_linker_source_library_by_stem(mmux-bash-packages)
mbfl_linker_source_library_by_stem(mmux-bash-pointers)
mbfl_linker_source_library_by_stem(mmux-bash-mpfr)
mbfl_linker_source_library_by_stem(mmux-bash-mpfi)


#### version numbers

function version-1.1 () {
    mbfl_string_is_digit QQ(MMUX_BASH_MPFI_PACKAGE,INTERFACE_VERSION_CURRENT)
}
function version-1.2 () {
    mbfl_string_is_digit QQ(MMUX_BASH_MPFI_PACKAGE,INTERFACE_VERSION_REVISION)
}
function version-1.3 () {
    mbfl_string_is_digit QQ(MMUX_BASH_MPFI_PACKAGE,INTERFACE_VERSION_AGE)
}

function version-2.1 () {
    printf 'MPFI_VERSION=%s\n' QQ(MPFI_VERSION)
    mbfl_string_is_not_empty QQ(MPFI_VERSION)
}
function version-2.2 () {
    printf 'MPFI_VERSION_MAJOR=%s\n' QQ(MPFI_VERSION_MAJOR)
    mbfl_string_is_digit QQ(MPFI_VERSION_MAJOR)
}
function version-2.3 () {
    printf 'MPFI_VERSION_MINOR=%s\n' QQ(MPFI_VERSION_MINOR)
    mbfl_string_is_digit QQ(MPFI_VERSION_MINOR)
}
function version-2.4 () {
    printf 'MPFI_VERSION_PATCHLEVEL=%s\n' QQ(MPFI_VERSION_PATCHLEVEL)
    mbfl_string_is_digit QQ(MPFI_VERSION_PATCHLEVEL)
}


#### let's go

dotest version-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
