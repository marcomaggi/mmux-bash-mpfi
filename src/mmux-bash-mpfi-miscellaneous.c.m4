/*
  Part of: MMUX Bash MPFI
  Contents: implementation of miscellaneous builtins
  Date: Nov  5, 2024

  Abstract

	This module implements miscellaneous builtins.

  Copyright (C) 2024 Marco Maggi <mrc.mgg@gmail.com>

  This program is free  software: you can redistribute it and/or  modify it under the
  terms  of  the  GNU General  Public  License  as  published  by the  Free  Software
  Foundation, either version 3 of the License, or (at your option) any later version.

  This program  is distributed in the  hope that it  will be useful, but  WITHOUT ANY
  WARRANTY; without  even the implied  warranty of  MERCHANTABILITY or FITNESS  FOR A
  PARTICULAR PURPOSE.  See the GNU General Public License for more details.

  You should have received  a copy of the GNU General Public  License along with this
  program.  If not, see <http://www.gnu.org/licenses/>.
*/


/** --------------------------------------------------------------------
 ** Headers.
 ** ----------------------------------------------------------------- */

#include "mmux-bash-mpfi-internals.h"


/** --------------------------------------------------------------------
 ** Builtins with MPFR result.
 ** ----------------------------------------------------------------- */

m4_define([[[DEFINE_BUILTIN_WITH_MPFR_RESULT]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfr_ptr	rop;
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    int		rv = $1(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_ROP MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_ROP,MPFI_OP)"]]])
]]])

DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_diam_abs]]])
DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_diam_rel]]])
DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_diam]]])
DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_mag]]])
DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_mig]]])
DEFINE_BUILTIN_WITH_MPFR_RESULT([[[mpfi_mid]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_alea]]])
{
  mpfr_ptr	rop;
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    mpfi_alea(rop, op);
    return MMUX_SUCCESS;
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_ROP MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_ROP,MPFI_OP)"]]])

/* end of file */
