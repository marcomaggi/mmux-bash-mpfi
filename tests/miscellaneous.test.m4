#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for miscellaneous builtins
#!# Date:Nov  5, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/miscellaneous.test ; less tests/miscellaneous.log
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


#### mpfi_diam_abs

function miscellaneous-mpfi_diam_abs-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.800000e1'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_diam_abs WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_diam_rel

function miscellaneous-mpfi_diam_rel-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.645161e-1'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_diam_rel WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_diam

function miscellaneous-mpfi_diam-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.645161e-1'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_diam WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_mag

function miscellaneous-mpfi_mag-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.128000e3'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_mag WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_mig

function miscellaneous-mpfi_mig-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.120000e3'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_mig WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_mid

function miscellaneous-mpfi_mid-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.120000e3, 0.128000e3]' EXPECTED_RESULT='0.124000e3'
    declare -r PREC='4' INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_prec WW(OP) WW(PREC) )
	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_mid WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_alea

function miscellaneous-mpfi_alea-1.0 () {
    declare -r EXPECTED_MPFI_STR='[0.123000e3, 0.123000e3]' EXPECTED_RESULT='0.123000e3'
    declare -r INITVAL='123'
    declare OP ROP RESULT MPFI_STR

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

	mbfl_location_leave_when_failure( mpfi_set_si   WW(OP) WW(INITVAL) )
	mpfi_just_printit_dammit -v MPFI_STR WW(OP)

	mbfl_location_leave_when_failure( mpfi_alea WW(ROP) WW(OP) )
	mpfr_just_printit_dammit -v RESULT WW(ROP)

	dotest-equal WW(EXPECTED_MPFI_STR) WW(MPFI_STR) 'mpfi string rep' &&
	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### let's go

dotest miscellaneous-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
