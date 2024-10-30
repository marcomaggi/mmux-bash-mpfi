/*
  Part of: MMUX Bash Mpfi
  Contents: public header file
  Date: Oct 28, 2024

  Abstract

	This is the public  header file of the library, defining  the public API.  It
	must be included in all the code that uses the library.

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

#ifndef MMUX_BASH_MPFI_H
#define MMUX_BASH_MPFI_H 1


/** --------------------------------------------------------------------
 ** Preliminary definitions.
 ** ----------------------------------------------------------------- */

#ifdef __cplusplus
extern "C" {
#endif

/* The macro  MMUX_BASH_MPFI_UNUSED indicates that  a function, function  argument or
   variable may potentially be unused. Usage examples:

   static int unused_function (char arg) MMUX_BASH_MPFI_UNUSED;
   int foo (char unused_argument MMUX_BASH_MPFI_UNUSED);
   int unused_variable MMUX_BASH_MPFI_UNUSED;
*/
#ifdef __GNUC__
#  define MMUX_BASH_MPFI_UNUSED		__attribute__((__unused__))
#else
#  define MMUX_BASH_MPFI_UNUSED		/* empty */
#endif

#ifndef __GNUC__
#  define __attribute__(...)	/* empty */
#endif

#ifndef __GNUC__
#  define __builtin_expect(...)	/* empty */
#endif

#if defined _WIN32 || defined __CYGWIN__
#  ifdef BUILDING_DLL
#    ifdef __GNUC__
#      define mmux_bash_mpfi_decl		__attribute__((__dllexport__)) extern
#    else
#      define mmux_bash_mpfi_decl		__declspec(dllexport) extern
#    endif
#  else
#    ifdef __GNUC__
#      define mmux_bash_mpfi_decl		__attribute__((__dllimport__)) extern
#    else
#      define mmux_bash_mpfi_decl		__declspec(dllimport) extern
#    endif
#  endif
#  define mmux_bash_mpfi_private_decl	extern
#else
#  if __GNUC__ >= 4
#    define mmux_bash_mpfi_decl		__attribute__((__visibility__("default"))) extern
#    define mmux_bash_mpfi_private_decl	__attribute__((__visibility__("hidden")))  extern
#  else
#    define mmux_bash_mpfi_decl		extern
#    define mmux_bash_mpfi_private_decl	extern
#  endif
#endif


/** --------------------------------------------------------------------
 ** Headers.
 ** ----------------------------------------------------------------- */

#include <mmux-bash-pointers.h>
#include <mmux-bash-mpfi-config.h>
#include <mmux-bash-mpfr.h>
#include <mpfi.h>


/** --------------------------------------------------------------------
 ** Constants and preprocessor macros.
 ** ----------------------------------------------------------------- */

#undef  MMUX_BASH_MPFI_MARGIN_VARNAME
#define MMUX_BASH_MPFI_MARGIN_VARNAME	"ABSOLUTE_MARGIN_MPFI"

#undef  MMUX_BASH_MPFI_DEFAULT_COMPARISON_ABSOLUTE_MARGIN
#define MMUX_BASH_MPFI_DEFAULT_COMPARISON_ABSOLUTE_MARGIN	1e-6

#undef  MMUX_BASH_MPFI_EPSILON_VARNAME
#define MMUX_BASH_MPFI_EPSILON_VARNAME	"RELATIVE_EPSILON_MPFI"

#undef  MMUX_BASH_MPFI_DEFAULT_COMPARISON_RELATIVE_EPSILON
#define MMUX_BASH_MPFI_DEFAULT_COMPARISON_RELATIVE_EPSILON	1e-6


/** --------------------------------------------------------------------
 ** Version functions.
 ** ----------------------------------------------------------------- */

mmux_bash_mpfi_decl char const *mmux_bash_mpfi_version_string			(void);
mmux_bash_mpfi_decl int		mmux_bash_mpfi_version_interface_current	(void);
mmux_bash_mpfi_decl int		mmux_bash_mpfi_version_interface_revision	(void);
mmux_bash_mpfi_decl int		mmux_bash_mpfi_version_interface_age		(void);


/** --------------------------------------------------------------------
 ** Type functions.
 ** ----------------------------------------------------------------- */

mmux_bash_mpfi_decl mmux_bash_rv_t mmux_mpfi_ptr_parse (mpfi_ptr   * p_value, char const * const s_value, char const * const who)
  __attribute__((__nonnull__(1,2)));

mmux_bash_mpfi_decl mmux_bash_rv_t mmux_mpfi_ptr_bind_to_variable  (char const * variable_name, mpfi_ptr    value, char const * who)
  __attribute__((__nonnull__(1)));

mmux_bash_mpfi_decl int mmux_mpfi_equal_absmargin (mpfi_ptr op1, mpfi_ptr op2, mpfi_ptr margin);
mmux_bash_mpfi_decl mmux_bash_rv_t mmux_bash_mpfi_set_absmargin_from_string (mpfi_ptr margin, char const * margin_string, char const * who);

mmux_bash_mpfi_decl int mmux_mpfi_equal_relepsilon (mpfi_ptr op1, mpfi_ptr op2, mpfi_ptr epsilon);
mmux_bash_mpfi_decl mmux_bash_rv_t mmux_bash_mpfi_set_relepsilon_from_string (mpfi_ptr epsilon, char const * epsilon_string, char const * who);


/** --------------------------------------------------------------------
 ** Misc functions.
 ** ----------------------------------------------------------------- */

mmux_bash_mpfi_decl mmux_bash_rv_t mmux_bash_mpfi_set_MPFI_RV (int value, char const * const who);

mmux_bash_mpfi_decl mmux_bash_rv_t mpfi_just_printit_dammit (mpfi_ptr op);


/** --------------------------------------------------------------------
 ** Done.
 ** ----------------------------------------------------------------- */

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* MMUX_BASH_MPFI_H */

/* end of file */
