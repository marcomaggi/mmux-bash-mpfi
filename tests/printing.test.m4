#!#
#!# Part of: MMUX Bash MPFI
#!# Contents: tests for printing builtins and functions
#!# Date: Oct 30, 2024
#!#
#!# Abstract
#!#
#!#	This file must be executed with one among:
#!#
#!#		$ make all check TESTS=tests/printing.test ; less tests/printing.log
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


#### just printing

function mpfi-just-printit-dammit-1.1 () {
    declare -r EXPECTED_RESULT='[0.123457e3, 0.123457e3]' INITVAL='123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-1.2 () {
    declare -r EXPECTED_RESULT='[-0.123457e3, -0.123457e3]' INITVAL='-123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-1.3 () {
    declare -r EXPECTED_RESULT='[0.000000e0, 0.000000e0]' INITVAL='0'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

function mpfi-just-printit-dammit-2.1 () {
    declare -r EXPECTED_RESULT='[@NaN@, @NaN@]' INITVAL='NaN'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-2.2 () {
    declare -r EXPECTED_RESULT='[@NaN@, @NaN@]' INITVAL='-NaN'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

function mpfi-just-printit-dammit-3.1 () {
    declare -r EXPECTED_RESULT='[+@Inf@, +@Inf@]' INITVAL='Inf'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-3.2 () {
    declare -r EXPECTED_RESULT='[-@Inf@, -@Inf@]' INITVAL='-Inf'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-3.3 () {
    declare -r EXPECTED_RESULT='[+@Inf@, +@Inf@]' INITVAL='+Inf'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )

	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

# Correct use of the end-of-options marker "--" on the command line.
#
function sub-mpfi-just-printit-dammit-4.1 () {
    declare -r EXPECTED_RESULT='+@Inf@' INITVAL='+Inf'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( RESULT=$(mpfi_just_printit_dammit -- WW(OP)) )
	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

# Print the result into an output variable.
#
function mpfi-just-printit-dammit-5.1 () {
    declare -r EXPECTED_RESULT='[0.123457e3, 0.123457e3]' INITVAL='123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v RESULT WW(OP) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

# Select base 2.
#
function mpfi-just-printit-dammit-6.1 () {
    declare -r EXPECTED_RESULT='[0.100000e2, 0.100000e2]' INITVAL='2'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v RESULT -b 2 WW(OP) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
# Select base 16.
#
function mpfi-just-printit-dammit-6.2 () {
    declare -r EXPECTED_RESULT='[0.f00000e1, 0.f00000e1]' INITVAL='15'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v RESULT -b 16 WW(OP) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}
# Select base -16.
#
function mpfi-just-printit-dammit-6.3 () {
    declare -r EXPECTED_RESULT='[0.F00000E1, 0.F00000E1]' INITVAL='15'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v RESULT -b -16 WW(OP) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------

# Select ndigits 3.
#
function mpfi-just-printit-dammit-7.1 () {
    declare -r EXPECTED_RESULT='[0.123e3, 0.123e3]' INITVAL='123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v RESULT -n 3 WW(OP) )

	dotest-debug WW(EXPECTED_RESULT) WW(RESULT)
	dotest-equal WW(EXPECTED_RESULT) WW(RESULT)
    }
    mbfl_location_leave
}

### ------------------------------------------------------------------------
### errors

# Invalid output variable name.
#
function sub-mpfi-just-printit-dammit-999.001 () {
    declare -r EXPECTED_RESULT='[0.123457e3, 0.123457e3]' INITVAL='123.4567890'
    declare OP RESULT

    dotest-unset-debug

    mbfl_location_enter
    {
	if mpfi_alloc_and_init OP
	then mbfl_location_handler "mpfi_clear_and_free RR(OP)"
	else mbfl_location_leave_then_return_failure
	fi

	mbfl_location_leave_when_failure( mpfi_set_d WW(OP) WW(INITVAL) )
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v '123' WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.001 () {
    ! sub-mpfi-just-printit-dammit-999.001
}

### ------------------------------------------------------------------------

# Invalid base: not an exact integer.
#
function sub-mpfi-just-printit-dammit-999.002 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -b 'ciao' WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.002 () {
    ! sub-mpfi-just-printit-dammit-999.002
}

### ------------------------------------------------------------------------

# Invalid base: not in range.
#
function sub-mpfi-just-printit-dammit-999.003 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -b '999' WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.003 () {
    ! sub-mpfi-just-printit-dammit-999.003
}

### ------------------------------------------------------------------------

# Invalid ndigits: not an exact integer.
#
function sub-mpfi-just-printit-dammit-999.004 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -n 'ciao' WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.004 () {
    ! sub-mpfi-just-printit-dammit-999.004
}

### ------------------------------------------------------------------------

# Invalid ndigits: not in range.
#
function sub-mpfi-just-printit-dammit-999.005 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -n '-999' WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.005 () {
    ! sub-mpfi-just-printit-dammit-999.005
}

### ------------------------------------------------------------------------

# Invalid command line option to getopts.
#
function sub-mpfi-just-printit-dammit-999.006 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -Z WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.006 () {
    ! sub-mpfi-just-printit-dammit-999.006
}

### ------------------------------------------------------------------------

# Command line option to getopts "-b" requires an argument.
#
function sub-mpfi-just-printit-dammit-999.007 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -b )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.007 () {
    ! sub-mpfi-just-printit-dammit-999.007
}

### ------------------------------------------------------------------------

# Command line option to getopts "-b" requires an argument, but the end-of-options marker was found.
#
function sub-mpfi-just-printit-dammit-999.008 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -b -- WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.008 () {
    ! sub-mpfi-just-printit-dammit-999.008
}

### ------------------------------------------------------------------------

# Command line option to getopts "-n" requires an argument.
#
function sub-mpfi-just-printit-dammit-999.009 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -n )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.009 () {
    ! sub-mpfi-just-printit-dammit-999.009
}

### ------------------------------------------------------------------------

# Command line option to getopts "-n" requires an argument, but the end-of-options marker was found.
#
function sub-mpfi-just-printit-dammit-999.010 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -n -- WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.010 () {
    ! sub-mpfi-just-printit-dammit-999.010
}

### ------------------------------------------------------------------------

# Command line option to getopts "-v" requires an argument.
#
function sub-mpfi-just-printit-dammit-999.011 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.011 () {
    ! sub-mpfi-just-printit-dammit-999.011
}

### ------------------------------------------------------------------------

# Command line option to getopts "-v" requires an argument, but the end-of-options marker was found.
#
function sub-mpfi-just-printit-dammit-999.012 () {
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
	mbfl_location_leave_when_failure( mpfi_just_printit_dammit -v -- WW(OP) )
    }
    mbfl_location_leave
}
function mpfi-just-printit-dammit-999.012 () {
    ! sub-mpfi-just-printit-dammit-999.012
}

### ------------------------------------------------------------------------

# Missing pointer to MPFI argument.
#
function mpfi-just-printit-dammit-999.013 () {
    ! mpfi_just_printit_dammit
}

### ------------------------------------------------------------------------

# Argument is not a pointer.
#
function mpfi-just-printit-dammit-999.014 () {
    ! mpfi_just_printit_dammit 'ciao'
}


#### let's go

dotest mpfi-
dotest-final-report

### end of file
# Local Variables:
# mode: sh
# End:
