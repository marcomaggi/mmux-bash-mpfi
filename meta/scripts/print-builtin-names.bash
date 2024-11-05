#!/bin/bash
#
# Part of: MMUX Bash MPFI
# Contents: meta script
# Date: Oct 28, 2024
#
# Abstract
#
#	Run this script to output a list of builtin names.
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

declare -ga BUILTINS=(mmux_bash_mpfi_library_init

		      mpfi_init
		      mpfi_clear
		      mpfi_init2
		      mpfi_inits
		      mpfi_inits2
		      mpfi_clears
		      mpfi_get_prec
		      mpfi_set_prec
		      mpfi_round_prec

		      mpfi_set_si
		      mpfi_set_ui
		      mpfi_set_flt
		      mpfi_set_d
		      mpfi_set_ld
		      mpfi_set_fr
		      mpfi_set
		      mpfi_set_z
		      mpfi_set_q
		      mpfi_init_set_si
		      mpfi_init_set_ui
		      mpfi_init_set_d
		      mpfi_init_set_ld
		      mpfi_init_set_z
		      mpfi_init_set_q
		      mpfi_init_set_fr
		      mpfi_init_set
		      mpfi_init_set_str
		      mpfi_set_str
		      mpfi_set_nan
		      mpfi_set_inf
		      mpfi_set_zero
		      mpfi_swap

		      MPFI_BOTH_ARE_EXACT
		      MPFI_LEFT_IS_INEXACT
		      MPFI_RIGHT_IS_INEXACT
		      MPFI_BOTH_ARE_INEXACT
		      mpfi_left
		      mpfi_right
		      mpfi_get_left
		      mpfi_get_right

		      mpfi_diam_abs
		      mpfi_diam_rel
		      mpfi_diam
		      mpfi_mag
		      mpfi_mig
		      mpfi_mid
		      mpfi_alea

		     )

### ------------------------------------------------------------------------

declare -i IDX=

function print_builtin_name () {
    declare NAME=${1:?"missing parameter 1 name of bulitin in call to '$FUNCNAME'"}

    printf 'MMUX_BASH_MPFI_PACKAGE[BUILTIN_%d]=%s\n' ${IDX:?} "${NAME:?}"
    let ++IDX
}

declare NAME

for NAME in "${BUILTINS[@]}"
do
    print_builtin_name "$NAME"
done


### end of file
# Local Variables:
# mode: sh
# End:
