# @configure_input@
#

AC_PREREQ([2.72])
MMUX_PKG_VERSIONS([0],[1],[0],[devel.0])
AC_INIT([MMUX Bash MPFI],[MMUX_PACKAGE_VERSION],
  [mrc.mgg@gmail.com],
  [mmux-bash-mpfi],[http://github.com/marcomaggi/mmux-bash-mpfi])
MMUX_INIT
MMUX_LIBTOOL_LIBRARY_VERSIONS([mmux_bash_mpfi],0,0,0)
AC_REVISION([0.1])
AC_COPYRIGHT([Copyright (c) 2024 Marco Maggi <mrc.mgg@gmail.com>

This program is free software: you  can redistribute it and/or modify it
under the  terms of the GNU  General Public License as  published by the
Free Software Foundation,  either version 3 of the License,  or (at your
option) any later version.

This program  is distributed  in the  hope that it  will be  useful, but
WITHOUT   ANY   WARRANTY;  without   even   the   implied  warranty   of
MERCHANTABILITY  or  FITNESS FOR  A  PARTICULAR  PURPOSE.  See  the  GNU
General Public License for more details.

You should have received a copy  of the GNU General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
])

AC_CONFIG_SRCDIR([src/])
AC_CONFIG_MACRO_DIR([meta/autotools])
AC_CONFIG_AUX_DIR([meta/autotools])
AC_USE_SYSTEM_EXTENSIONS
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([1.17 foreign subdir-objects])
AM_MAINTAINER_MODE

AM_PROG_AR
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P

LT_PREREQ([2.4.7])
LT_INIT([disable-static])


#### basic system inspection

MMUX_CHECK_TARGET_OS
AX_IS_RELEASE([git-directory])

AC_LANG([C])
MMUX_LANG_C11

AM_PROG_AS
AM_PROG_CC_C_O
AC_PATH_PROG([M4_PROGRAM],[m4])
AC_PATH_PROG([BASH_PROGRAM],[/bin/bash],[/bin/bash],[:])

AC_CACHE_SAVE


#### external libraries

PKG_PREREQ([0.29])
PKG_INSTALLDIR
MMUX_CHECK_PKG_CONFIG_MACROS
PKG_CHECK_MODULES([BASH],[bash],,[AC_MSG_WARN([package GNU Bash not found])])

AC_SEARCH_LIBS(cos, m,, [AC_MSG_ERROR([Cannot find libm])])

MMUX_AUTOCONF_SAVE_SHELL_VARIABLE_WHILE_APPENDING([CFLAGS],[""],
  [MMUX_AUTOCONF_SAVE_SHELL_VARIABLE_WHILE_APPENDING([LIBS],[""],
     [AC_CHECK_HEADERS([mpfi.h],,[AC_MSG_FAILURE([missing mpfi.h header],[2])])
      AC_CHECK_LIB([mpfi],[mpfi_init],,[AC_MSG_FAILURE([missing or unusable MPFI library],[2])])])])

AS_VAR_SET([MPFI_CFLAGS])
AS_VAR_SET([MPFI_LIBS])
AS_IF([mmux_test_variable_is_yes([ac_cv_lib_mpfi_mpfi_init])],
  [AS_VAR_SET([MPFI_LIBS],[-lmpfi])])
AC_SUBST([MPFI_CFLAGS])
AC_SUBST([MPFI_LIBS])

PKG_CHECK_MODULES([MMUX_BASH_MPFR],[mmux-bash-mpfr >= 0.1.0],
   [AS_VAR_SET([mmux_bash_mpfi_MMUX_BASH_MPFR_DATADIR],[$("$PKG_CONFIG" mmux-bash-mpfr --variable=datadir)])
    AS_VAR_SET([mmux_bash_mpfi_MMUX_BASH_MPFR_LIBRARY],[$mmux_bash_mpfi_MMUX_BASH_MPFR_DATADIR/bash/libmmux-bash-mpfr.bash])])
AC_SUBST([mmux_bash_mpfi_MMUX_BASH_MPFR_DATADIR])
AC_SUBST([mmux_bash_mpfi_MMUX_BASH_MPFR_LIBRARY])

MBFL_SETUP_FOR_TESTING([v3.0.0])

AC_CACHE_SAVE


#### inspecting

m4_define([MMUX_BASH_MPFI_INCLUDES],[
MMUX_CC_COMMON_INCLUDES_FOR_TESTS
#ifdef HAVE_MPFI_H
#  include <mpfi.h>
#endif
])

AC_DEFUN([MMUX_MPFI_CONSTANT_TEST],[MMUX_CC_DETERMINE_VALUEOF([$1],[$1],[MMUX_BASH_MPFI_INCLUDES])])
AC_DEFUN([MMUX_MPFI_CONSTANT_TESTS],[m4_map_args_w($1,[MMUX_MPFI_CONSTANT_TEST(],[)])])

MMUX_AUTOCONF_SAVE_SHELL_VARIABLE_WHILE_APPENDING([CFLAGS],[" $MPFI_CFLAGS"],
  [MMUX_AUTOCONF_SAVE_SHELL_VARIABLE_WHILE_APPENDING([LIBS],[" $MPFI_LIBS"],
     [MMUX_MPFI_CONSTANT_TESTS([MPFI_FLAGS_BOTH_ENDPOINTS_EXACT
                                MPFI_FLAGS_LEFT_ENDPOINT_INEXACT
                                MPFI_FLAGS_RIGHT_ENDPOINT_INEXACT
                                MPFI_FLAGS_BOTH_ENDPOINTS_INEXACT])
      AC_CHECK_FUNCS([mpfi_set_ld])])])

MMUX_DEFINE_OMNIBUS_CONFIG_VARIABLE([MMUX_BASH_MPFI_HAVE_CC_TYPE_LDOUBLE],
  [Defined and set to 1 if support for 'long double' is enabled in MPFI.],
  [AS_IF([mmux_test_variable_is_yes([ac_cv_func_mpfi_set_ld])],
         [AS_VAR_SET([MMUX_BASH_MPFI_HAVE_CC_TYPE_LDOUBLE],[1])])])
AC_MSG_CHECKING([for MMUX Bash MPFI supporting 'long double'])
AS_IF([mmux_test_variable_is_one([MMUX_BASH_MPFI_HAVE_CC_TYPE_LDOUBLE])],
      [AC_MSG_RESULT([yes])],
      [AC_MSG_RESULT([no])])

AC_CACHE_SAVE


#### finish

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile]
  [src/m4/mmux-bash-mpfi-config.m4]
  [src/mmux-bash-mpfi-config.h]
  [doc/mmux-version.texi]
  [meta/scripts/mmux-bash-mpfi.pc]
  [meta/slackware/slack-desc])
MMUX_OUTPUT
AC_OUTPUT

### end of file
