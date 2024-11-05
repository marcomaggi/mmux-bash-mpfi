#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for conversion builtins
#!# Date:Nov  5, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/conversion.test ; less tests/conversion.log
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


#### setup

mbfl_embed_library(__LIBMBFL_LINKER__)
mbfl_linker_source_library_by_stem(core)
mbfl_linker_source_library_by_stem(tests)
mbfl_linker_source_library_by_stem(mmux-bash-packages)
mbfl_linker_source_library_by_stem(mmux-bash-pointers)
mbfl_linker_source_library_by_stem(mmux-bash-mpfr)
mbfl_linker_source_library_by_stem(mmux-bash-mpfi)


#### mpfi_get_d

function conversion-mpfi_get_d-1.0 () {
    declare -r EXPECTED_RESULT='1.234568e+02'
    declare -r INITVAL='123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_get_d RESULT WW(OP) )

	mmux_double_reformat RESULT '%e' WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_get_fr

function conversion-mpfi_get_fr-1.0 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare -r INITVAL='123.4567890'
    declare OP ROP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfr_alloc_and_init ROP
	then mbfl_location_handler "mpfr_clear_and_free RR(ROP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_get_fr WW(ROP) WW(OP) )

	mpfr_just_printit_dammit -v RESULT -- WW(ROP)

	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### let's go

dotest conversion-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
