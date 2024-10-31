#
# Part of: MMUX Bash MPFI
# Contents: core library
# Date: Oct 28, 2024
#
# Abstract
#
#	This library  must be  sourced from an  interactive shell  or from a  script.  It  loads the
#	shared library and enables the implemented builtins.
#
#	The Bash builtin "enable" will search the shared library file in the usual places, including
#	the directories from "LD_LIBRARY_PATH".
#
# Copyright (C) 2024 Marco Maggi <mrc.mgg@gmail.com>
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU
# General Public  License as  published by  the Free Software  Foundation, either  version 3  of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that  it will be useful, but WITHOUT ANY WARRANTY; without
# even the  implied warranty of MERCHANTABILITY  or FITNESS FOR  A PARTICULAR PURPOSE.  See  the GNU
# General Public License for more details.
#
# You should  have received a copy  of the GNU General  Public License along with  this program.  If
# not, see <http://www.gnu.org/licenses/>.
#

#page
#### package

mmux_package_require_by_descriptor MMUX_BASH_PACKAGES_PACKAGE 0
mmux_package_require_by_descriptor MMUX_BASH_POINTERS_PACKAGE 0
mmux_package_require_by_descriptor MMUX_BASH_MPFR_PACKAGE     0

declare -gA MMUX_BASH_MPFI_PACKAGE=([PACKAGING_VERSION]='0'
				    [PACKAGE_NAME]='MMUX Bash MPFI'
				    [SEMANTIC_VERSION]='mmux_bash_mpfi_SEMANTIC_VERSION'
				    [INTERFACE_VERSION_CURRENT]='mmux_bash_mpfi_VERSION_INTERFACE_CURRENT'
				    [INTERFACE_VERSION_REVISION]='mmux_bash_mpfi_VERSION_INTERFACE_REVISION'
				    [INTERFACE_VERSION_AGE]='mmux_bash_mpfi_VERSION_INTERFACE_AGE'
				    [SHARED_LIBRARY]='libmmux-bash-mpfi.so'
				    [SHELL_LIBRARY]='libmmux-bash-mpfi.bash'
				    [PACKAGE_AFTER_LOADING_HOOK]='mmux_bash_mpfi_library_after_loading_hook'
				    [PACKAGE_BEFORE_UNLOADING_HOOK]='mmux_bash_mpfi_library_before_unloading_hook')

m4_include([[[mmux-bash-mpfi-builtin-definitions.bash]]])

#page
#### after loading hook: begin

function mmux_bash_mpfi_library_after_loading_hook () {
    mmux_bash_mpfi_library_init

#page
#### additional functions: printing

# When actually  printing number's string  representation: let's try to  return the return  value of
# "printf".
#
function mpfi_just_printit_dammit () {
    declare -i BASE=10 NDIGITS=6 MPFI_RV MPFR_RV
    declare JUST_PRINTIT_FLAGS PRINTF_FLAGS

    {
	declare OPTNAME OPTARG OPTIND=1 OPTERR=0

	while getopts ':n:b:v:' OPTNAME
	do
	    case WW(OPTNAME) in
		n)
		    if test '--' = QQ(OPTARG)
		    then
			printf '%s: option "-n" requires an argument, but the end-of-options marker was found: "--"\n' WW(FUNCNAME) >&2
			return 1
		    elif mpfi_p_string_is_ndigits_argument QQ(OPTARG)
		    then
			NDIGITS=RR(OPTARG)
			JUST_PRINTIT_FLAGS+=" -n RR(NDIGITS)"
		    else
			printf '%s: invalid ndigits argument, expected non-negative exact integer got: "%s"\n' \
			       WW(FUNCNAME) WW(OPTARG) >&2
			return 1
		    fi
		    NDIGITS=RR(OPTARG)
		    ;;
		b)
		    if test '--' = QQ(OPTARG)
		    then
			printf '%s: option "-b" requires an argument, but the end-of-options marker was found: "--"\n' WW(FUNCNAME) >&2
			return 1
		    elif mpfi_p_string_is_base_argument QQ(OPTARG)
		    then
			BASE=RR(OPTARG)
			JUST_PRINTIT_FLAGS+=" -b RR(BASE)"
		    else
			printf '%s: invalid base argument, expected exact integer in the range [-36, -2] U [+2, +36] got: "%s"\n' \
			       WW(FUNCNAME) WW(OPTARG) >&2
			return 1
		    fi
		    ;;
		v)
		    if test '--' = QQ(OPTARG)
		    then
			printf '%s: option "-v" requires an argument, but the end-of-options marker was found: "--"\n' WW(FUNCNAME) >&2
			return 1
		    elif mpfi_p_string_is_variable_name QQ(OPTARG)
		    then PRINTF_FLAGS+=" -v RR(OPTARG)"
		    else
			printf '%s: invalid variable name argument: "%s"\n' WW(FUNCNAME) WW(OPTARG) >&2
			return 1
		    fi
		    ;;
		*)
		    # We requested  silent mode of "getopts"  by both starting the  OPTSTRING with a
		    # colon and setting OPTERR to zero.  So we expect the name of the invalid option
		    # to be in OPTARG.
		    #
		    # Notice that we end  up here also when an option requiring  an argument is used
		    # without an argument,  specifically when there are no more  arguments after the
		    # option on the command line, as in:
		    #
		    #    mpfi_just_printit_dammit -b
		    #
		    case WW(OPTARG) in
			b|n|v)
			    printf '%s: option "-%s" requires an argument, but there are no more arguments on the command line\n' \
				   WW(FUNCNAME) WW(OPTARG) >&2
			    ;;
			*)
			    printf '%s: invalid option, should be one among "-b", "-n", "v" got: ""\n' WW(FUNCNAME) WW(OPTARG) >&2
			    ;;
		    esac
		    return 1
		    ;;
	    esac
	done
	shift $((OPTIND-1))
    }

    if test -z QQ(1)
    then
	printf '%s: expected pointer to MPFI number as argument, but none was found\n' WW(FUNCNAME) >&2
	return 1
    elif ! mmux_string_is_pointer WW(1)
    then
	printf '%s: expected raw memory pointer as argument, got: "%s" found\n' WW(FUNCNAME) WW(1) >&2
	return 1
    fi
    declare OP=PP(1,MPFI_PTR)

    #echo $FUNCNAME BASE="$BASE" NDIGITS="$NDIGITS" OP="$OP" >&2

    {
	declare MPFR_PTR_LEFT MPFR_PTR_RIGHT MPFR_LEFT_STRING MPFR_RIGHT_STRING RETVAL=0

	if mpfi_left MPFR_PTR_LEFT WW(OP)
	then
	    if mpfi_right MPFR_PTR_RIGHT WW(OP)
	    then
		if mpfr_just_printit_dammit -v MPFR_LEFT_STRING $JUST_PRINTIT_FLAGS WW(MPFR_PTR_LEFT)
		then
		    if mpfr_just_printit_dammit -v MPFR_RIGHT_STRING $JUST_PRINTIT_FLAGS WW(MPFR_PTR_RIGHT)
		    then
			printf $PRINTF_FLAGS '[%s, %s]' WW(MPFR_LEFT_STRING) WW(MPFR_RIGHT_STRING)
			RETVAL=$?
		    else RETVAL=$?
		    fi
		else RETVAL=$?
		fi
	    else RETVAL=$?
	    fi
	else RETVAL=$?
	fi
	return $RETVAL
    }
}

function mpfi_p_string_is_base_argument () {
    declare STRING=$1

    if test -z QQ(STRING)
    then return 1
    elif ! mpfi_p_string_is_exact_integer_number WW(STRING)
    then return 1
    elif (( (2 <= STRING && STRING <= 36) || (-36 <= STRING && STRING <= -2) ))
    then return 0
    else return 1
    fi
}
function mpfi_p_string_is_ndigits_argument () {
    declare STRING=$1

    if test -z QQ(STRING)
    then return 1
    elif ! mpfi_p_string_is_exact_integer_number WW(STRING)
    then return 1
    elif (( 0 <= STRING ))
    then return 0
    else return 1
    fi
}
function mpfi_p_string_is_exact_integer_number () {
    declare -r STRING=$1 REX='^[+-]?[0-9]+$'
    # Let's make it local.
    declare -a BASH_REMATCH

    [[ WW(STRING) =~ $REX ]]
}
function mpfi_p_string_is_variable_name () {
    declare -r STRING=$1 REX='^[a-zA-Z_][a-zA-Z0-9_]+$'
    # Let's make it local.
    declare -a BASH_REMATCH

    if test -z QQ(STRING)
    then return 1
    else [[ WW(STRING) =~ $REX ]]
    fi
}

#page
#### compound allocation and initialisation

function mpfi_alloc_and_init () {
    declare -n mpfi_p_PTR=PP(1,MPFI_PTR)
    declare -r mpfi_p_PREC=$2

    if mmux_libc_calloc mpfi_p_PTR 1 WW(mpfi_SIZEOF)
    then
	if ! {
		if test -z QQ(mpfi_p_PREC) -o QQ(mpfi_p_PREC) = '0'
		then mpfi_init  WW(mpfi_p_PTR)
		else mpfi_init2 WW(mpfi_p_PTR) WW(mpfi_p_PREC)
		fi
	    }
	then mmux_libc_free WW(mpfi_p_PTR)
	fi
    else return 1
    fi
}
function mpfi_clear_and_free () {
    declare -r mpfi_p_PTR=PP(1,MPFI_PTR)

    if mpfi_clear WW(mpfi_p_PTR)
    then mmux_libc_free WW(mpfi_p_PTR)
    else return 1
    fi
}

#page
#### shell index arrays

function mpfi_alloc_shell_array () {
    declare -n mpfi_SHELL_ARRY=${1:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}
    declare -i mpfi_ADIM=${2:?"missing parameter 2 shell array dimension in call to '$FUNCNAME'"}
    declare -i mpfi_IDX mpfi_JDX

    if ! mmux_libc_calloc 'mpfi_SHELL_ARRY[0]' ${mpfi_ADIM:?} ${mpfi_SIZEOF:?}
    then return 1
    fi

    for ((mpfi_IDX=0, mpfi_JDX=1; mpfi_JDX < mpfi_ADIM; ++mpfi_IDX, ++mpfi_JDX))
    do
	if ! mmux_pointer_add "mpfi_SHELL_ARRY[${mpfi_JDX:?}]" "${mpfi_SHELL_ARRY[${mpfi_IDX:?}]:?}" ${mpfi_SIZEOF:?}
	then
	    mmux_libc_free "${mpfi_SHELL_ARRY[0]:?}"
	    return 1
	fi
    done
    return 0
}
function mpfi_free_shell_array () {
    declare -n mpfi_SHELL_ARRY=${1:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}

    mmux_libc_free "${mpfi_SHELL_ARRY[0]:?}"
}

function mpfi_init_shell_array () {
    declare -n mpfi_SHELL_ARRY=${1:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}
    declare    mpfi_p_PREC=$2
    declare -i mpfi_ADIM=${#mpfi_SHELL_ARRY[@]}
    declare -i mpfi_IDX

    if test -z QQ(mpfi_p_PREC) -o  QQ(mpfi_p_PREC) = '0'
    then
	for ((mpfi_IDX=0; mpfi_IDX < mpfi_ADIM; ++mpfi_IDX))
	do mpfi_init WW(mpfi_SHELL_ARRY, $mpfi_IDX)
	done
    else
	for ((mpfi_IDX=0; mpfi_IDX < mpfi_ADIM; ++mpfi_IDX))
	do mpfi_init2 WW(mpfi_SHELL_ARRY, $mpfi_IDX) WW(mpfi_p_PREC)
	done
    fi
}
function mpfi_clear_shell_array () {
    declare -n mpfi_SHELL_ARRY=${1:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}
    declare -i mpfi_ADIM=${#mpfi_SHELL_ARRY[@]}
    declare -i mpfi_IDX

    for ((mpfi_IDX=0; mpfi_IDX < mpfi_ADIM; ++mpfi_IDX))
    do mpfi_clear WW(mpfi_SHELL_ARRY, $mpfi_IDX)
    done
}

function mpfi_alloc_and_init_shell_array () {
    declare -n mpfi_SHELL_SUBARRY=PP(1, shell array name)
    declare -i mpfi_ADIM=PP(2, shell array dimension)
    declare    mpfi_p_PREC=$3

    if mpfi_alloc_shell_array mpfi_SHELL_SUBARRY ${mpfi_ADIM:?}
    then mpfi_init_shell_array mpfi_SHELL_SUBARRY ${mpfi_p_PREC}
    else return 1
    fi
}
function mpfi_clear_and_free_shell_array () {
    declare -n mpfi_SHELL_SUBARRY=${1:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}

    if mpfi_clear_shell_array mpfi_SHELL_SUBARRY
    then mpfi_free_shell_array mpfi_SHELL_SUBARRY
    else return 1
    fi
}

#page
#### raw memory arrays of pointers

function mpfi_alloc_and_init_pointers_array () {
    declare -n mpfi_POINTERS=${1:?"missing parameter 3 name of pointer to pointers array in call to '$FUNCNAME'"}
    declare -n mpfi_SHELL_ARRY=${2:?"missing parameter 1 shell array name in call to '$FUNCNAME'"}

    if ! mmux_libc_calloc 'mpfi_POINTERS' ${#mpfi_SHELL_ARRY[@]} ${mmux_pointer_SIZEOF:?}
    then return 1
    fi

    {
	declare -i mpfi_IDX

	for ((mpfi_IDX=0; mpfi_IDX < ${#mpfi_SHELL_ARRY[@]}; ++mpfi_IDX))
	do
	    if ! mmux_pointer_array_set ${mpfi_POINTERS:?} ${mpfi_IDX:?} "${mpfi_SHELL_ARRY[${mpfi_IDX:?}]:?}"
	    then
		mmux_libc_free ${mpfi_POINTERS:?}
		return 1
	    fi
	done
    }
    return 0
}

#page
#### after loading hook: end

}

#page
#### before unloading hook

function mmux_bash_mpfi_library_before_unloading_hook () {
    unset -f \
	  mpfi_just_printit_dammit				\
	  mpfi_alloc_and_init					\
	  mpfi_clear_and_free					\
	  mpfi_alloc_shell_array				\
	  mpfi_free_shell_array					\
	  mpfi_init_shell_array					\
	  mpfi_clear_shell_array				\
	  mpfi_alloc_and_init_shell_array			\
	  mpfi_clear_and_free_shell_array			\
	  mpfi_alloc_and_init_pointers_array			\
	  mmux_bash_mpfi_library_after_loading_hook		\
	  mmux_bash_mpfi_library_before_unloading_hook

    unset -v \
	  MPFI_VERSION						\
	  MPFI_VERSION_MAJOR					\
	  MPFI_VERSION_MINOR					\
	  MPFI_VERSION_PATCHLEVEL				\
	  mpfi_SIZEOF						\
	  MPFI_FLAGS_BOTH_ENDPOINTS_EXACT			\
	  MPFI_FLAGS_LEFT_ENDPOINT_INEXACT			\
	  MPFI_FLAGS_RIGHT_ENDPOINT_INEXACT			\
	  MPFI_FLAGS_BOTH_ENDPOINTS_INEXACT
}

#page
#### let's go

mmux_package_provide_by_descriptor MMUX_BASH_MPFI_PACKAGE

### end of file
# Local Variables:
# mode: sh
# End:
