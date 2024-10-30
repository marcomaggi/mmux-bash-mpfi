#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for MMUX Bash MPFI packages
#!# Date: Oct 28, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/packages.test ; less tests/packages.log
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
mmux_package_option_enable_debug_mode
mmux_package_option_enable_verbose_mode
mmux_package_option_disable_load_when_provide
mbfl_linker_source_library_by_stem(mmux-bash-mpfi)


#### unloading

function packages-unload-library-1.0 () {
    {
	mmux_package_descriptor_is_registered_as_provided MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi package is provided'
    } && {
	mmux_package_descriptor_is_registered_as_provided MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi is registered as provided'
    } && {
	type -t 'mmux_bash_mpfi_library_after_loading_hook' | \
	    dotest-output 'function' 'expected the after loading hook to exists'
    } && {
	type -t 'mmux_bash_mpfi_library_before_unloading_hook' | \
	    dotest-output 'function' 'expected the before unloading hook to exists'
    } && {
	mmux_package_load_by_descriptor MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi loaded successfully'
    } && {
	mmux_package_descriptor_is_registered_as_loaded MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi is registered as loaded'
    } && {
	mmux_package_unload_by_descriptor MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi unloaded successfully'
    } && {
	mmux_package_descriptor_is_registered_as_provided MMUX_BASH_MPFI_PACKAGE
	dotest-equal 0 $? 'mmux-bash-mpfi is registered as provided'
    } && {
	type -t 'mmux_bash_mpfi_library_after_loading_hook' | \
	    dotest-output '' 'expected the after-loading hook NOT to exists after unloading package'
    } && {
	type -t 'mmux_bash_mpfi_library_before_unloading_hook' | \
	    dotest-output '' 'expected the before-unloading hook NOT to exists after unloadeing package'
    }
}


#### let's go

dotest packages-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
