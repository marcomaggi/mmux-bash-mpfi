#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for setter builtins
#!# Date: Oct 31, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/assignment.test ; less tests/assignment.log
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


#### setters: slong

function mpfi-set-slong-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_si WW(OP) '123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}
function mpfi-set-slong-1.2 () {
    declare -r EXPECTED_RESULT='-0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_si WW(OP) '-123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: ulong

function mpfi-set-ulong-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_ui WW(OP) '123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: sintmax

function mpfi-set-sintmax-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_sj WW(OP) '123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}
function mpfi-set-sintmax-1.2 () {
    declare -r EXPECTED_RESULT='-0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_sj WW(OP) '-123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: uintmax

function mpfi-set-uintmax-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    dotest-unset-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_uj WW(OP) '123'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: float

function mpfi-set-float-1.1 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare OP RESULT

    #dotest-set-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_flt WW(OP) '123.4567890'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: double

function mpfi-set-double-1.1 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare OP RESULT

    #dotest-set-debug
    dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug OP=WW(OP)

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_d WW(OP) '123.4567890'
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(RESULT)
    }
    mbfl_location_leave
    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
}


#### setters: ldouble

function mpfi-set-ldouble-1.1 () {
    if mmux_bash_pointers_builtin_p 'mpfi_set_ld'
    then
	declare -r INITVAL='123' EXPECTED_RESULT='0.123000e3'
	declare OP RESULT

	dotest-set-debug
	dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

	mbfl_location_enter
	{
	    if mpfi_alloc_and_init OP
	    then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    dotest-debug OP=WW(OP)

	    if ! mpfi_set_ld WW(OP) WW(INITVAL)
	    then mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)
	    dotest-debug WW(RESULT)
	}
	mbfl_location_leave
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    else dotest-skipped
    fi
}


#### setters: float128

function mpfi-set-float128-1.1 () {
    if mmux_bash_pointers_builtin_p 'mpfi_set_float128'
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	#dotest-set-debug
	dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    dotest-debug OP=WW(OP)

	    if mpfi_init WW(OP)
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if ! mpfi_set_float128 WW(OP) '123.4567890'
	    then mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)
	    dotest-debug WW(RESULT)
	}
	mbfl_location_leave
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    else dotest-skipped
    fi
}


#### setters: decimal64

function mpfi-set-decimal64-1.1 () {
    if mmux_bash_pointers_builtin_p 'mpfi_set_decimal64'
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	#dotest-set-debug
	dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    dotest-debug OP=WW(OP)

	    if mpfi_init WW(OP)
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if ! mpfi_set_decimal64 WW(OP) '123.4567890'
	    then mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)
	    dotest-debug WW(RESULT)
	}
	mbfl_location_leave
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    else dotest-skipped
    fi
}


#### setters: decimal128

function mpfi-set-decimal128-1.1 () {
    if mmux_bash_pointers_builtin_p 'mpfi_set_decimal128'
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	#dotest-set-debug
	dotest-debug mpfi_SIZEOF=WW(mpfi_SIZEOF)

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    dotest-debug OP=WW(OP)

	    if mpfi_init WW(OP)
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if ! mpfi_set_decimal128 WW(OP) '123.4567890'
	    then mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)
	    dotest-debug WW(RESULT)
	}
	mbfl_location_leave
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    else dotest-skipped
    fi
}


#### setters: mpfi

function mpfi-set-1.1 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare OP1 OP2 RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP1 2 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free WW(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	mmux_pointer_add OP2 WW(OP1) WW(mpfi_SIZEOF)

	if mpfi_init WW(OP1)
	then mbfl_location_handler "mpfi_clear RR(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP2)
	then mbfl_location_handler "mpfi_clear RR(OP2)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_d WW(OP1) '123.4567890'
	then mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set WW(OP2) WW(OP1)
	then mbfl_location_leave_then_return_failure
	fi

	RESULT=$(mpfi_just_printit_dammit WW(OP2))
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### setters: mpfi_set_str

function mpfi-set-str-1.1 () {
    declare -r STR='1234567890' BASE='10' EXPECTED_RESULT='0.123457e10'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug WW(OP) WW(STR) WW(BASE)

	if ! mpfi_set_str WW(OP) WW(STR) WW(BASE)
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-set-str-1.2 () {
    declare -r STR='-1234567890' BASE='10' EXPECTED_RESULT='-0.123457e10'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	dotest-debug WW(OP) WW(STR) WW(BASE)

	if ! mpfi_set_str WW(OP) WW(STR) WW(BASE)
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

function mpfi-set-str-1.3 () {
    declare -r STR='1234567890' BASE='10' EXPECTED_RESULT='0.123457e10'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_str WW(OP) WW(STR) WW(BASE)
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### setters: mpfi_set_nan

function mpfi-set-nan-1.1 () {
    declare -r EXPECTED_RESULT='@NaN@'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_nan WW(OP)
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### setters: mpfi_set_inf

function mpfi-set-inf-1.1 () {
    declare -r EXPECTED_RESULT='+@Inf@'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_inf WW(OP) 1
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-set-inf-1.2 () {
    declare -r EXPECTED_RESULT='-@Inf@'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_inf WW(OP) -1
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-set-inf-1.3 () {
    declare -r EXPECTED_RESULT='+@Inf@'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_inf WW(OP) 0
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### setters: mpfi_set_zero

function mpfi-set-zero-1.1 () {
    declare -r EXPECTED_RESULT='0.000000e0'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_zero WW(OP) 1
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-set-zero-1.2 () {
    declare -r EXPECTED_RESULT='-0.000000e0'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_zero WW(OP) -1
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-set-zero-1.3 () {
    declare -r EXPECTED_RESULT='0.000000e0'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_zero WW(OP) 0
	then mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### setters: mpfi_swap

function mpfi-swap-1.1 () {
    declare -r EXPECTED_RESULT1='0.456000e3' EXPECTED_RESULT2='0.123000e3'
    declare OP1 OP2 RESULT1 RESULT2

    mbfl_location_enter
    {
	if mmux_libc_calloc OP1 2 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free WW(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	mmux_pointer_add OP2 WW(OP1) WW(mpfi_SIZEOF)

	if mpfi_init WW(OP1)
	then mbfl_location_handler "mpfi_clear RR(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP2)
	then mbfl_location_handler "mpfi_clear RR(OP2)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_si WW(OP1) '123'
	then mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_si WW(OP2) '456'
	then mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_swap WW(OP1) WW(OP2)
	then mbfl_location_leave_then_return_failure
	fi

	RESULT1=$(mpfi_just_printit_dammit WW(OP1))
	RESULT2=$(mpfi_just_printit_dammit WW(OP2))

	dotest-equal     WW(EXPECTED_RESULT1) WW(RESULT1) &&
	    dotest-equal WW(EXPECTED_RESULT2) WW(RESULT2)
    }
    mbfl_location_leave
}


#### mpfi_init_set_si

function mpfi-init-set-si-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init_set_si WW(OP) '123'
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)

	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_init_set_ui

function mpfi-init-set-ui-1.1 () {
    declare -r EXPECTED_RESULT='0.123000e3'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init_set_ui WW(OP) '123'
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)

	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_init_set_d

function mpfi-init-set-d-1.1 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init_set_d WW(OP) '123.4567890'
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mpfi_just_printit_dammit -v RESULT -- WW(OP)

	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_init_set_ld

function mpfi-init-set-ld-1.1 () {
    if mmux_bash_pointers_builtin_p 'mpfi_init_set_ld'
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if mpfi_init_set_ld WW(OP) '123.4567890'
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)

	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
	}
	mbfl_location_leave
    else dotest-skipped
    fi
}


#### mpfi_init_set_z

function mpfi-init-set-z-1.1 () {
    if false
    then
	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if mpfi_init_set_z WW(OP) '123.4567890'
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)

	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
	}
	mbfl_location_leave
    else dotest-skipped
    fi
}


#### mpfi_init_set_q

function mpfi-init-set-q-1.1 () {
    if false
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if mpfi_init_set_q WW(OP) '123.4567890'
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)

	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
	}
	mbfl_location_leave
    else dotest-skipped
    fi
}


#### mpfi_init_set_f

function mpfi-init-set-f-1.1 () {
    if false
    then

	declare -r EXPECTED_RESULT='0.123457e3'
	declare OP RESULT

	mbfl_location_enter
	{
	    if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	    then mbfl_location_handler "mmux_libc_free RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    if mpfi_init_set_f WW(OP) '123.4567890'
	    then mbfl_location_handler "mpfi_clear RR(OP)"
	    else mbfl_location_leave_then_return_failure
	    fi

	    mpfi_just_printit_dammit -v RESULT -- WW(OP)

	    dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
	}
	mbfl_location_leave
    else dotest-skipped
    fi
}


#### mpfi_init_set

function mpfi-init-set-1.1 () {
    declare -r EXPECTED_RESULT='0.123457e3'
    declare OP1 OP2 RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP1 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free WW(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	if mmux_libc_calloc OP2 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free WW(OP2)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init_set_d WW(OP1) '123.4567890'
	then mbfl_location_handler "mpfi_clear RR(OP1)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init_set WW(OP2) WW(OP1)
	then mbfl_location_handler "mpfi_clear RR(OP2)"
	else mbfl_location_leave_then_return_failure
	fi

	RESULT=$(mpfi_just_printit_dammit WW(OP2))

	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}


#### let's go

dotest mpfi-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
