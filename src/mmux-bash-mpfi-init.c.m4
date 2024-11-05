/*
  Part of: MMUX Bash MPFI
  Contents: implementation of initialisation and finalisation builtins
  Date: Oct 28, 2024

  Abstract

	This module implements initialisation and finalisation builtins.

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
 ** Basic initialisation and finalisation.
 ** ----------------------------------------------------------------- */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_init]]])
{
  mpfi_ptr	ptr;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]], [[[argv[1]]]]);

  mpfi_init(ptr);
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR"]]],
    [[["Initialise an already allocated MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_clear]]])
{
  mpfi_ptr	ptr;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]], [[[argv[1]]]]);

  mpfi_clear(ptr);
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR"]]],
    [[["Finalise a MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_init2]]])
{
  mpfi_ptr	ptr;
  mpfr_prec_t	prec;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PREC([[[prec]]],	[[[argv[2]]]]);

  mpfi_init2(ptr, prec);
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR MPFR_PREC"]]],
    [[["Initialise an already allocated MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_inits]]])
{
  mpfi_ptr	ptr;

  for (int i=1; i<argc; ++i) {
    MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]], [[[argv[i]]]]);
    mpfi_init(ptr);
  }
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 <= argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR0 MPFI_PTR ..."]]],
    [[["Initialise already allocated MPFI numbers."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_inits2]]])
{
  mpfr_prec_t	prec;
  mpfi_ptr	ptr;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PREC([[[prec]]],	[[[argv[1]]]]);
  for (int i=2; i<argc; ++i) {
    MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]],	[[[argv[i]]]]);
    mpfi_init2(ptr, prec);
  }
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 <= argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_PREC MPFI_PTR0 MPFI_PTR ..."]]],
    [[["Initialise already allocated MPFI numbers."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_clears]]])
{
  mpfi_ptr	ptr;

  for (int i=1; i<argc; ++i) {
    MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[ptr]]], [[[argv[i]]]]);
    mpfi_clear(ptr);
  }
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 <= argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR0 MPFI_PTR ..."]]],
    [[["Finalise already allocated MPFI numbers."]]])


/** --------------------------------------------------------------------
 ** Precision functions.
 ** ----------------------------------------------------------------- */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_set_prec]]])
{
  mpfi_ptr	op;
  mpfr_prec_t	prec;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PREC([[[prec]]],	[[[argv[2]]]]);

  mpfi_set_prec(op, prec);
  return MMUX_SUCCESS;

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR MPFR_PREC"]]],
    [[["Set the precision of an MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_get_prec]]])
{
  mpfi_ptr	op;
  mpfr_prec_t	prec;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);

  prec = mpfi_get_prec(op);
  return mmux_mpfr_prec_bind_to_bash_variable(argv[1], prec, MMUX_BUILTIN_NAME_STR);

  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFR_PREC_VAR MPFI_PTR"]]],
    [[["Retrieve the precision of an MPFI number."]]])

/* ------------------------------------------------------------------ */

MMUX_BASH_BUILTIN_MAIN([[[mpfi_round_prec]]])
{
  mpfi_ptr	op;
  mpfr_prec_t	prec;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_PREC([[[prec]]],	[[[argv[2]]]]);
  {
    int		rv = mpfi_round_prec(op, prec);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BUILTIN_NAME_STR);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_PTR MPFR_PREC"]]],
    [[["Round a number with the specified precision."]]])

/* end of file */
