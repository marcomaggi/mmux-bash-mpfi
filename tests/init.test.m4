#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for initialisation and finalisation builtins
#!# Date: Oct 28, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/init.test ; less tests/init.log
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


#### basic initialisation and finalisation

function mpfi-init-1.1 () {
    # We print an initialised but unset number.
    declare -r EXPECTED_RESULT='[@NaN@, @NaN@]'
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

	RESULT=$(mpfi_just_printit_dammit WW(OP))
	dotest-equal QQ(EXPECTED_RESULT) QQ(RESULT)
    }
    mbfl_location_leave
}

function mpfi-init-1.2 () {
    # We print an initialised but unset number.
    declare -r EXPECTED_RESULT='[0.200000e1, 0.200000e1]'
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

	mpfi_set_d WW(OP) '2.0'

	RESULT=$(mpfi_just_printit_dammit WW(OP))
	dotest-equal QQ(EXPECTED_RESULT) QQ(RESULT)
    }
    mbfl_location_leave
}


#### compount allocation and initialisation

function mpfi-alloc-and-init-1.1 () {
    declare -r EXPECTED_RESULT='[0.123000e3, 0.123000e3]'
    declare OP

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_set_si WW(OP) 123
	then mbfl_location_leave_then_return_failure
	fi

	RESULT=$(mpfi_just_printit_dammit WW(OP))
	dotest-equal QQ(EXPECTED_RESULT) QQ(RESULT)
    }
    mbfl_location_leave
}


#### mpfi_init2

function mpfi-init2-1.1 () {
    # We print an initialised but unset number.
    declare -r PREC=123 EXPECTED_RESULT='[@NaN@, @NaN@]'
    declare OP RESULT

    mbfl_location_enter
    {
	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init2 WW(OP) WW(PREC)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	RESULT=$(mpfi_just_printit_dammit WW(OP))
    }
    mbfl_location_leave
    dotest-equal QQ(EXPECTED_RESULT) QQ(RESULT)
}



#### mpfi_inits, mpfi_clears

function mpfi-inits-1.1 () {
    declare -ra EXPECTED_RESULTS=('[0.000000e0, 0.000000e0]' '[0.100000e1, 0.100000e1]' '[0.200000e1, 0.200000e1]' '[0.300000e1, 0.300000e1]' '[0.400000e1, 0.400000e1]')
    declare -r OPNUM=mbfl_slots_number(EXPECTED_RESULTS)
    declare -a OPS
    declare -i IDX
    declare -a RESULTS

    dotest-unset-debug

    mbfl_location_enter
    {
	if mmux_libc_calloc mbfl_slot_spec(OPS,0) WW(OPNUM) WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free mbfl_slot_ref(OPS,0)"
	else mbfl_location_leave_then_return_failure
	fi

	for ((IDX=1; IDX < OPNUM; ++IDX))
	do mmux_pointer_add mbfl_slot_spec(OPS,WW(IDX)) WW(OPS,0) $(( IDX * mpfi_SIZEOF ))
	done

	{
	    declare CLEAR_HANDLER='mpfi_clears'

	    for ((IDX=0; IDX < OPNUM; ++IDX))
	    do CLEAR_HANDLER+=" mbfl_slot_ref(OPS,$IDX)"
	    done

	    dotest-debug CLEAR_HANDLER=WW(CLEAR_HANDLER)

	    if mpfi_inits mbfl_slots_values(OPS)
	    then mbfl_location_handler WW(CLEAR_HANDLER)
	    else mbfl_location_leave_then_return_failure
	    fi
	}

	dotest-debug setting

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do mpfi_set_si WW(OPS,WW(IDX)) WW(IDX)
	done

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do
	    RESULT=$(mpfi_just_printit_dammit WW(OPS,WW(IDX)))
	    mbfl_slot_set(RESULTS,WW(IDX),$RESULT)
	done

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do
	    dotest-debug check WW(EXPECTED_RESULTS,WW(IDX)) WW(RESULTS,WW(IDX))
	    if ! dotest-equal WW(EXPECTED_RESULTS,WW(IDX)) WW(RESULTS,WW(IDX))
	    then mbfl_location_leave_then_return_failure
	    fi
	done
    }
    mbfl_location_leave
}


#### mpfi_inits2, mpfi_clears

function mpfi-inits2-1.1 () {
    declare -ra EXPECTED_RESULTS=('[0.000000e0, 0.000000e0]' '[0.100000e1, 0.100000e1]' '[0.200000e1, 0.200000e1]' '[0.300000e1, 0.300000e1]' '[0.400000e1, 0.400000e1]')
    declare -r PREC=123 OPNUM=mbfl_slots_number(EXPECTED_RESULTS)
    declare -a OPS
    declare -i IDX
    declare -a RESULTS

    dotest-unset-debug

    mbfl_location_enter
    {
	if mmux_libc_calloc mbfl_slot_spec(OPS,0) WW(OPNUM) WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free mbfl_slot_ref(OPS,0)"
	else mbfl_location_leave_then_return_failure
	fi

	for ((IDX=1; IDX < OPNUM; ++IDX))
	do mmux_pointer_add mbfl_slot_spec(OPS,WW(IDX)) WW(OPS,0) $(( IDX * mpfi_SIZEOF ))
	done

	{
	    declare CLEAR_HANDLER='mpfi_clears'

	    for ((IDX=0; IDX < OPNUM; ++IDX))
	    do CLEAR_HANDLER+=" mbfl_slot_ref(OPS,$IDX)"
	    done

	    dotest-debug CLEAR_HANDLER=WW(CLEAR_HANDLER)

	    if mpfi_inits2 WW(PREC) mbfl_slots_values(OPS)
	    then mbfl_location_handler WW(CLEAR_HANDLER)
	    else mbfl_location_leave_then_return_failure
	    fi
	}

	dotest-debug setting

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do mpfi_set_si WW(OPS,WW(IDX)) WW(IDX)
	done

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do
	    RESULT=$(mpfi_just_printit_dammit WW(OPS,WW(IDX)))
	    mbfl_slot_set(RESULTS,WW(IDX),$RESULT)
	done

	for ((IDX=0; IDX < OPNUM; ++IDX))
	do
	    dotest-debug check WW(EXPECTED_RESULTS,WW(IDX)) WW(RESULTS,WW(IDX))
	    if ! dotest-equal WW(EXPECTED_RESULTS,WW(IDX)) WW(RESULTS,WW(IDX))
	    then mbfl_location_leave_then_return_failure
	    fi
	done
    }
    mbfl_location_leave
}


#### initialise shell array

# Let's do this in a format that can be copied in the documentation.
#
function mpfi-init-shell-array-1.1 () {
    declare -a OPS
    declare -i NUM=5

    mpfi_alloc_shell_array OPS $NUM
    {
	mpfi_init_shell_array OPS
	{
	    for ((IDX=0; IDX < ${#OPS[@]}; ++IDX))
	    do
		mpfi_set_si WW(OPS,WW(IDX)) WW(IDX) $MPFI_RNDN
		mpfi_just_printit_dammit WW(OPS,WW(IDX))
	    done

            declare -n ROP=OPS[0] OP1=OPS[1] OP2=OPS[2]

	    mpfi_just_printit_dammit WW(ROP)
	    mpfi_just_printit_dammit WW(OP1)
	    mpfi_just_printit_dammit WW(OP2)
	}
	mpfi_clear_shell_array OPS
    }
    mpfi_free_shell_array OPS
}

function mpfi-init-shell-array-1.2 () {
    declare -a OPS
    declare -i NUM=5
    declare -i PREC=17

    mpfi_alloc_shell_array OPS $NUM
    {
	mpfi_init_shell_array OPS $PREC
	{
	    for ((IDX=0; IDX < ${#OPS[@]}; ++IDX))
	    do
		mpfi_set_si ${OPS[WW(IDX)]} WW(IDX) $MPFI_RNDN
		mpfi_just_printit_dammit ${OPS[WW(IDX)]}
	    done

            declare -n ROP=OPS[0] OP1=OPS[1] OP2=OPS[2]

	    mpfi_just_printit_dammit WW(ROP)
	    mpfi_just_printit_dammit WW(OP1)
	    mpfi_just_printit_dammit WW(OP2)
	}
	mpfi_clear_shell_array OPS
    }
    mpfi_free_shell_array OPS
}

function mpfi-init-shell-array-1.3 () {
    declare -a OPS
    declare -i NUM=5

    mpfi_alloc_and_init_shell_array OPS $NUM
    {
	for ((IDX=0; IDX < ${#OPS[@]}; ++IDX))
	do
	    mpfi_set_si ${OPS[WW(IDX)]} WW(IDX) $MPFI_RNDN
	    mpfi_just_printit_dammit ${OPS[WW(IDX)]}
	done

        declare -n ROP=OPS[0] OP1=OPS[1] OP2=OPS[2]

	mpfi_just_printit_dammit WW(ROP)
	mpfi_just_printit_dammit WW(OP1)
	mpfi_just_printit_dammit WW(OP2)
    }
    mpfi_clear_and_free_shell_array OPS
}
function mpfi-init-shell-array-1.4 () {
    declare -a OPS
    declare -i NUM=5
    declare -i PREC=17

    mpfi_alloc_and_init_shell_array OPS $NUM $PREC
    {
	for ((IDX=0; IDX < ${#OPS[@]}; ++IDX))
	do
	    mpfi_set_si ${OPS[WW(IDX)]} WW(IDX) $MPFI_RNDN
	    mpfi_just_printit_dammit ${OPS[WW(IDX)]}
	done

        declare -n ROP=OPS[0] OP1=OPS[1] OP2=OPS[2]

	mpfi_just_printit_dammit WW(ROP)
	mpfi_just_printit_dammit WW(OP1)
	mpfi_just_printit_dammit WW(OP2)
    }
    mpfi_clear_and_free_shell_array OPS
}


#### mpfi_set_prec, mpfi_get_prec

function mpfi-set-prec-1.1 () {
    declare OP PREC EXPECTED_PREC

    mbfl_location_enter
    {
	if ! mpfr_get_default_prec EXPECTED_PREC
	then mbfl_location_leave_then_return_failure
	fi

	if mmux_libc_calloc OP 1 WW(mpfi_SIZEOF)
	then mbfl_location_handler "mmux_libc_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if mpfi_init WW(OP)
	then mbfl_location_handler "mpfi_clear RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_get_prec PREC $OP
	then mbfl_location_leave_then_return_failure
	fi
    }
    mbfl_location_leave
    dotest-equal QQ(EXPECTED_PREC) QQ(PREC)
}
function mpfi-set-prec-1.2 () {
    declare -r NEW_PREC=17 EXPECTED_PREC=17
    declare OP PREC

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

	if ! mpfi_set_prec $OP $NEW_PREC
	then mbfl_location_leave_then_return_failure
	fi

	if ! mpfi_get_prec PREC $OP
	then mbfl_location_leave_then_return_failure
	fi
    }
    mbfl_location_leave
    dotest-equal QQ(EXPECTED_PREC) QQ(PREC)
}


#### let's go

dotest mpfi-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
