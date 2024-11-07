/*
  Part of: MMUX Bash MPFI
  Contents: library functions
  Date: Oct 28, 2024

  Abstract

	This module implements library initialisation and version numbers inspection.

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
 ** Version functions.
 ** ----------------------------------------------------------------- */

char const *
mmux_bash_mpfi_version_string (void)
{
  return mmux_bash_mpfi_VERSION_INTERFACE_STRING;
}
int
mmux_bash_mpfi_version_interface_current (void)
{
  return mmux_bash_mpfi_VERSION_INTERFACE_CURRENT;
}
int
mmux_bash_mpfi_version_interface_revision (void)
{
  return mmux_bash_mpfi_VERSION_INTERFACE_REVISION;
}
int
mmux_bash_mpfi_version_interface_age (void)
{
  return mmux_bash_mpfi_VERSION_INTERFACE_AGE;
}


/** --------------------------------------------------------------------
 ** Helpers.
 ** ----------------------------------------------------------------- */

mmux_bash_rv_t
mmux_bash_mpfi_set_MPFI_RV (int value, char const * const caller_name)
{
  return mmux_sint_bind_to_bash_variable("MPFI_RV", value, caller_name);
}

mmux_bash_rv_t
mpfi_just_printit_dammit (mpfi_ptr op)
{
  mpfr_ptr	left  = &(op->left);
  mpfr_ptr	right = &(op->right);

  printf("[");
  mpfr_just_printit_dammit(left);
  printf(", ");
  mpfr_just_printit_dammit(right);
  printf("]");
  return MMUX_SUCCESS;
}


/** --------------------------------------------------------------------
 ** Library initialisation.
 ** ----------------------------------------------------------------- */

m4_define([[[MMUX_DEFINE_MPFI_CONSTANT_VARIABLE]]],[[[
#if ((defined MMUX_HAVE_$1) && (1 == MMUX_HAVE_$1))
  mmux_bash_create_global_sint_variable("$1",	$1,	MMUX_BASH_BUILTIN_STRING_NAME);
#endif
]]])

m4_define([[[MMUX_DEFINE_MPFI_PREC_CONSTANT_VARIABLE]]],[[[{
  mmux_mpfi_prec_bind_to_bash_variable("$1", $1, MMUX_BASH_BUILTIN_STRING_NAME);
}]]])

MMUX_BASH_BUILTIN_MAIN([[[mmux_bash_mpfi_library_init]]])
{
  {
    mmux_string_bind_to_bash_global_variable("MPFI_VERSION",		MPFI_VERSION_STRING,	MMUX_BASH_BUILTIN_STRING_NAME);
    mmux_bash_create_global_sint_variable("MPFI_VERSION_MAJOR",		MPFI_VERSION_MAJOR,	MMUX_BASH_BUILTIN_STRING_NAME);
    mmux_bash_create_global_sint_variable("MPFI_VERSION_MINOR",		MPFI_VERSION_MINOR,	MMUX_BASH_BUILTIN_STRING_NAME);
    mmux_bash_create_global_sint_variable("MPFI_VERSION_PATCHLEVEL",	MPFI_VERSION_PATCHLEVEL,MMUX_BASH_BUILTIN_STRING_NAME);
  }
  {
    mmux_bash_create_global_sint_variable("mpfi_SIZEOF",	sizeof(__mpfi_struct),	MMUX_BASH_BUILTIN_STRING_NAME);
  }
  {
    MMUX_DEFINE_MPFI_CONSTANT_VARIABLE([[[MPFI_FLAGS_BOTH_ENDPOINTS_EXACT]]])
    MMUX_DEFINE_MPFI_CONSTANT_VARIABLE([[[MPFI_FLAGS_LEFT_ENDPOINT_INEXACT]]])
    MMUX_DEFINE_MPFI_CONSTANT_VARIABLE([[[MPFI_FLAGS_RIGHT_ENDPOINT_INEXACT]]])
    MMUX_DEFINE_MPFI_CONSTANT_VARIABLE([[[MPFI_FLAGS_BOTH_ENDPOINTS_INEXACT]]])
  }
  return MMUX_SUCCESS;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[mmux_bash_mpfi_library_init]]],
    [[[(1 == argc)]]],
    [[["mmux_bash_mpfi_library_init"]]],
    [[["Initialise the library."]]])

/* end of file */
