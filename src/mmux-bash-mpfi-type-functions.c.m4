/*
  Part of: MMUX Bash MPFI
  Contents: MPFI type functions
  Date: Oct 29, 2024

  Abstract

	This module implements functions to interface MPFI specific types.

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

static void
mpfi_max (mpfi_ptr rop, mpfi_ptr op1, mpfi_ptr op2)
{
  mpfi_set(rop, (mpfi_cmp(op1, op2) >= 0)? op1 : op2);
}


/** --------------------------------------------------------------------
 ** Type parsers.
 ** ----------------------------------------------------------------- */

mmux_bash_rv_t
mmux_mpfi_ptr_parse (mpfi_ptr * p_value, char const * const s_value, char const * const who)
{
  return mmux_pointer_parse((void **)p_value, s_value, who);
}
mmux_bash_rv_t
mmux_mpfi_ptr_array_parse (mpfi_ptr ** p_value, char const * const s_value, char const * const who)
{
  return mmux_pointer_parse((void **)p_value, s_value, who);
}


/** --------------------------------------------------------------------
 ** Variable binders.
 ** ----------------------------------------------------------------- */

mmux_bash_rv_t
mmux_mpfi_ptr_bind_to_variable (char const * variable_name, mpfi_ptr value, char const * who)
{
  return mmux_pointer_bind_to_variable(variable_name, value, who);
}


/** --------------------------------------------------------------------
 ** Approximate comparison.
 ** ----------------------------------------------------------------- */

int
mmux_mpfi_equal_absmargin (mpfi_ptr op1, mpfi_ptr op2, mpfi_ptr margin)
{
  mpfi_t	diff, abs_diff, abs_margin;
  int		rv;

  mpfi_init(diff);
  mpfi_init(abs_diff);
  mpfi_init(abs_margin);
  {
    mpfi_sub(diff, op1, op2);
    mpfi_abs(abs_diff, diff);
    mpfi_abs(abs_margin, margin);
    rv = (mpfi_cmp(abs_diff, abs_margin) < 0)? 1 : 0;
  }
  mpfi_clear(abs_margin);
  mpfi_clear(abs_diff);
  mpfi_clear(diff);
  return rv;
}
mmux_bash_rv_t
mmux_bash_mpfi_set_absmargin_from_string (mpfi_ptr margin, char const * margin_string, char const * who)
{
  mmux_sint_t	base = 0;
  int		rv   = mpfi_set_str(margin, margin_string, base);

  if (0 == rv) {
    return MMUX_SUCCESS;
  } else {
    if (who) {
      fprintf(stderr, "%s: error: invalid absmargin shell value: %s='%s'\n", who, MMUX_BASH_MPFI_MARGIN_VARNAME, margin_string);
    }
    return MMUX_FAILURE;
  }
}

/* ------------------------------------------------------------------ */

int
mmux_mpfi_equal_relepsilon (mpfi_ptr op1, mpfi_ptr op2, mpfi_ptr epsilon)
{
  mpfi_t	diff, abs_diff, abs_epsilon, abs_op1, abs_op2, max_abs_op, abs_margin;
  int		rv;

  mpfi_init(diff);
  mpfi_init(abs_diff);
  mpfi_init(abs_epsilon);
  mpfi_init(abs_op1);
  mpfi_init(abs_op2);
  mpfi_init(max_abs_op);
  mpfi_init(abs_margin);
  {
    mpfi_sub(diff, op1, op2);
    mpfi_abs(abs_diff, diff);

    mpfi_abs(abs_epsilon, epsilon);
    mpfi_abs(abs_op1, op1);
    mpfi_abs(abs_op2, op2);

    mpfi_max(max_abs_op, abs_op1, abs_op2);
    mpfi_mul(abs_margin, abs_epsilon, max_abs_op);

    rv = (mpfi_cmp(abs_diff, abs_margin) < 0)? 1 : 0;
  }
  mpfi_clear(abs_margin);
  mpfi_clear(max_abs_op);
  mpfi_clear(abs_op2);
  mpfi_clear(abs_op1);
  mpfi_clear(abs_epsilon);
  mpfi_clear(abs_diff);
  mpfi_clear(diff);
  return rv;
}
mmux_bash_rv_t
mmux_bash_mpfi_set_relepsilon_from_string (mpfi_ptr epsilon, char const * epsilon_string, char const * who)
{
  mmux_sint_t	base = 0;
  int		rv   = mpfi_set_str(epsilon, epsilon_string, base);

  if (0 == rv) {
    return MMUX_SUCCESS;
  } else {
    if (who) {
      fprintf(stderr, "%s: error: invalid relepsilon shell value: %s='%s'\n", who, MMUX_BASH_MPFI_EPSILON_VARNAME, epsilon_string);
    }
    return MMUX_FAILURE;
  }
}

/* end of file */
