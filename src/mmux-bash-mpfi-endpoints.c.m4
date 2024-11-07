/*
  Part of: MMUX Bash MPFI
  Contents: implementation of endpoint operations builtins
  Date: Oct 30, 2024

  Abstract

	This module implements endpoint operations builtins.

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
 ** Endpoint operations.
 ** ----------------------------------------------------------------- */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_get_left]]])
{
  mpfr_ptr	rop;
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    int		rv = mpfi_get_left(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_ROP MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_ROP, MPFI_OP)."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_get_right]]])
{
  mpfr_ptr	rop;
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    int		rv = mpfi_get_right(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_ROP MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_ROP, MPFI_OP)."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_left]]])
{
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    mpfr_ptr	left  = &(op->left);
    return mmux_mpfr_ptr_bind_to_bash_variable(argv[1], left, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_PTRVAR MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_PTRVAR, MPFI_OP)."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_right]]])
{
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    mpfr_ptr	right  = &(op->right);
    return mmux_mpfr_ptr_bind_to_bash_variable(argv[1], right, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_PTRVAR MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(MPFR_PTRVAR, MPFI_OP)."]]])


/** --------------------------------------------------------------------
 ** Endpoint exactness.
 ** ----------------------------------------------------------------- */

m4_define([[[DEFINE_ENDPOINT_EXACTNESS_BUILTIN]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mmux_sint_t	flag;

  MMUX_BASH_PARSE_BUILTIN_ARG_SINT([[[flag]]],	[[[argv[1]]]]);
  {
    int		rv = ($1(flag))? 1 : 0;
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER SINT_FLAG"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER(SINT_FLAG)."]]])
]]])

DEFINE_ENDPOINT_EXACTNESS_BUILTIN([[[MPFI_BOTH_ARE_EXACT]]])
DEFINE_ENDPOINT_EXACTNESS_BUILTIN([[[MPFI_LEFT_IS_INEXACT]]])
DEFINE_ENDPOINT_EXACTNESS_BUILTIN([[[MPFI_RIGHT_IS_INEXACT]]])
DEFINE_ENDPOINT_EXACTNESS_BUILTIN([[[MPFI_BOTH_ARE_INEXACT]]])

/* end of file */
