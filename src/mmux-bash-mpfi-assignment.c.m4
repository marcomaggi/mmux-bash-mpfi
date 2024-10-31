/*
  Part of: MMUX Bash MPFI
  Contents: implementation of assignment builtins
  Date: Oct 30, 2024

  Abstract

	This module implements assignment builtins.

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
 ** Basic setting.
 ** ----------------------------------------------------------------- */

m4_define([[[MMUX_BASH_DEFINE_MPFI_SETTER]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$5]]],[[[
MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  $2		op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  $4([[[op]]],						[[[argv[2]]]]);
  {
    int		rv = $1(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP $3"]]],
    [[["Set an already initialised number MPFI_ROP to the given operand $3."]]])
]]])]]])

MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_si]]], [[[mmux_slong_t]]],  [[[SLONG]]],   [[[MMUX_BASH_PARSE_BUILTIN_ARG_SLONG]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_ui]]],	[[[mmux_ulong_t]]],  [[[ULONG]]],   [[[MMUX_BASH_PARSE_BUILTIN_ARG_ULONG]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_flt]]],[[[mmux_float_t]]],  [[[FLOAT]]],   [[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_d]]],	[[[mmux_double_t]]], [[[DOUBLE]]],  [[[MMUX_BASH_PARSE_BUILTIN_ARG_DOUBLE]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_ld]]],	[[[mmux_ldouble_t]]],[[[LDOUBLE]]], [[[MMUX_BASH_PARSE_BUILTIN_ARG_LDOUBLE]]],
			     [[[MMUX_BASH_MPFI_HAVE_CC_TYPE_LDOUBLE]]])

MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_z]]],	[[[mpz_ptr]]],	[[[MPZ_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPZ_PTR]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_q]]],	[[[mpq_ptr]]],	[[[MPQ_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPQ_PTR]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set_fr]]],	[[[mpfr_ptr]]],	[[[MPFR_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR]]])
MMUX_BASH_DEFINE_MPFI_SETTER([[[mpfi_set]]],	[[[mpfi_ptr]]],	[[[MPFI_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR]]])


/** --------------------------------------------------------------------
 ** Initialisation and assignment.
 ** ----------------------------------------------------------------- */

m4_define([[[DEFINE_MPFI_INIT_AND_SET]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$5]]],[[[
MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  $2		op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  $4([[[op]]],						[[[argv[2]]]]);
  {
    int		rv = $1(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP $3"]]],
    [[["Initialise then set a MPFI number to the given operand $3."]]])
]]])]]])

DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_si]]],[[[mmux_slong_t]]],  [[[SLONG]]],   [[[MMUX_BASH_PARSE_BUILTIN_ARG_SLONG]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_ui]]],[[[mmux_ulong_t]]],  [[[ULONG]]],   [[[MMUX_BASH_PARSE_BUILTIN_ARG_ULONG]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_d]]],	[[[mmux_double_t]]], [[[DOUBLE]]],  [[[MMUX_BASH_PARSE_BUILTIN_ARG_DOUBLE]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_ld]]],[[[mmux_ldouble_t]]],[[[LDOUBLE]]], [[[MMUX_BASH_PARSE_BUILTIN_ARG_LDOUBLE]]],
			 [[[MMUX_BASH_MPFI_HAVE_CC_TYPE_LDOUBLE]]])

DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_z]]],	[[[mpz_ptr]]],	[[[MPZ_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPZ_PTR]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_q]]],	[[[mpq_ptr]]],	[[[MPQ_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPQ_PTR]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set_fr]]],[[[mpfr_ptr]]],	[[[MPFR_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PTR]]])
DEFINE_MPFI_INIT_AND_SET([[[mpfi_init_set]]],	[[[mpfi_ptr]]],	[[[MPFI_PTR]]],	[[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR]]])


/** --------------------------------------------------------------------
 ** Miscellaneous setters.
 ** ----------------------------------------------------------------- */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_set_str]]])
{
  mpfi_ptr	rop;
  char const *	str;
  int		base;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ASCIIZ_PTR([[[str]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SINT([[[base]]],		[[[argv[3]]]]);
  {
      int	rv = mpfi_set_str(rop, str, base);
      return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP STRING BASE"]]],
    [[["Set an already initialised MPFI number to the given string."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_init_set_str]]])
{
  mpfi_ptr	rop;
  char const *	str;
  int		base;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ASCIIZ_PTR([[[str]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SINT([[[base]]],		[[[argv[3]]]]);
  {
      int	rv = mpfi_init_set_str(rop, str, base);
      return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP STRING BASE"]]],
    [[["Initialise and set an MPFI number to the given string."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_set_nan]]])
{
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  {
    mpfr_ptr	left  = &(op->left);
    mpfr_ptr	right = &(op->right);

    mpfr_set_nan(left);
    mpfr_set_nan(right);
    return MMUX_SUCCESS;
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_OP"]]],
    [[["Set to not-a-number a MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_set_inf]]])
{
  mpfi_ptr	op;
  int		sign;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SINT([[[sign]]],		[[[argv[2]]]]);
  {
    mpfr_ptr	left  = &(op->left);
    mpfr_ptr	right = &(op->right);

    mpfr_set_inf(left,  sign);
    mpfr_set_inf(right, sign);
    return MMUX_SUCCESS;
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_OP SIGN"]]],
    [[["Set to not-a-number a MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_set_zero]]])
{
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  {
    int		rv = mpfi_set_si(op, 0);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_OP"]]],
    [[["Set to zero a MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_swap]]])
{
  mpfi_ptr	op1, op2;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op2]]],	[[[argv[2]]]]);
  {
    mpfi_swap(op1, op2);
    return MMUX_SUCCESS;
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_OP1 MPFI_OP2"]]],
    [[["Swap values between two already initialised MPFI numbers."]]])

/* end of file */
