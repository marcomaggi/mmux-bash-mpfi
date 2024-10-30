/*
  Part of: MMUX Bash Mpfi
  Contents: private header file
  Date: Oct 28, 2024

  Abstract

	This header file is for internal definitions.  It must be included by all the
	source files in this package.

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

#ifndef MMUX_BASH_MPFI_INTERNALS_H
#define MMUX_BASH_MPFI_INTERNALS_H 1


/** --------------------------------------------------------------------
 ** Headers.
 ** ----------------------------------------------------------------- */

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#ifdef HAVE_ERRNO_H
#  include <errno.h>
#endif

#ifdef HAVE_STDIO_H
#  include <stdio.h>
#endif

#include <mmux-bash-mpfi.h>
#include <mpfi_io.h>


/** --------------------------------------------------------------------
 ** Constants and variables.
 ** ----------------------------------------------------------------- */



/** --------------------------------------------------------------------
 ** Function prototypes.
 ** ----------------------------------------------------------------- */


/** --------------------------------------------------------------------
 ** Done.
 ** ----------------------------------------------------------------- */

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* MMUX_BASH_MPFI_INTERNALS_H */

/* end of file */
