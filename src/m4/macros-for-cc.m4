m4_divert(-1)m4_dnl
m4_dnl
m4_dnl Part of: MMUX Bash Builtins Macros
m4_dnl Contents: macros to define builtins
m4_dnl Date: Sep  9, 2024
m4_dnl
m4_dnl Abstract
m4_dnl
m4_dnl		This library  defines macros to  automatically generate C language
m4_dnl		functions for GNU Bash builtings implementation.
m4_dnl
m4_dnl Copyright (C) 2024 Marco Maggi <mrc.mgg@gmail.com>
m4_dnl
m4_dnl This program is free  software: you can redistribute it and/or  modify it under the
m4_dnl terms  of  the  GNU General  Public  License  as  published  by the  Free  Software
m4_dnl Foundation, either version 3 of the License, or (at your option) any later version.
m4_dnl
m4_dnl This program  is distributed in the  hope that it  will be useful, but  WITHOUT ANY
m4_dnl WARRANTY; without  even the implied  warranty of  MERCHANTABILITY or FITNESS  FOR A
m4_dnl PARTICULAR PURPOSE.  See the GNU General Public License for more details.
m4_dnl
m4_dnl You should have received  a copy of the GNU General Public  License along with this
m4_dnl program.  If not, see <http://www.gnu.org/licenses/>.
m4_dnl


m4_dnl preamble

m4_changequote(`[[[', `]]]')
m4_changecom([[[/*]]],[[[*/]]])


m4_dnl helpers

m4_define([[[MMUX_M4_TOUPPER]]],[[[m4_translit([[[$1]]],[[[abcdefghijklmnopqrstuvwxyz]]],[[[ABCDEFGHIJKLMNOPQRSTUVWXYZ]]])]]])
m4_define([[[MMUX_M4_TOLOWER]]],[[[m4_translit([[[$1]]],[[[ABCDEFGHIJKLMNOPQRSTUVWXYZ]]],[[[abcdefghijklmnopqrstuvwxyz]]])]]])

m4_define([[[QQ]]],[[["${$1}"]]])
m4_define([[[WW]]],[[["${$1:?}"]]])
m4_define([[[RR]]],[[[${$1:?}]]])


m4_dnl function definitions

m4_dnl $1 - bulitin identifier
m4_dnl $2 - C language expression, between parentheses, about "argc": if true the number of argumets is correct
m4_define([[[MMUX_BASH_DEFINE_BUILTIN_FUNCTION_NO_OPTIONS]]],[[[m4_dnl
static bool
[[[]]]$1[[[]]]_validate_argc (int argc)
{
  return ($2)? true : false;
}
static mmux_bash_rv_t
[[[]]]$1[[[]]]_builtin (mmux_bash_word_list_t word_list)
{
  return (int)mmux_bash_builtin_implementation_function_no_options(word_list, [[[]]]$1[[[]]]_validate_argc, [[[]]]$1[[[]]]_main);
}
]]])

m4_dnl $1 - bulitin identifier
m4_dnl $2 - C language expression, between parentheses, about "argc": if true the number of argumets is correct
m4_define([[[MMUX_BASH_DEFINE_BUILTIN_FUNCTION]]],[[[m4_dnl
static bool
[[[]]]$1[[[]]]_validate_argc (int argc)
{
  return ($2)? true : false;
}
static mmux_bash_rv_t
[[[]]]$1[[[]]]_builtin (mmux_bash_word_list_t word_list)
{
  return (int) mmux_bash_builtin_implementation_function(word_list, [[[]]]$1[[[]]]_validate_argc, [[[]]]$1[[[]]]_main);
}
]]])

m4_dnl $1 - builtin and implementation-function name
m4_define([[[MMUX_BASH_BUILTIN_MAIN]]],[[[static mmux_bash_rv_t
[[[]]]$1[[[]]]_main (int argc MMUX_BASH_POINTERS_UNUSED, char const * const argv[] MMUX_BASH_POINTERS_UNUSED)
#undef  MMUX_BASH_BUILTIN_STRING_NAME
#define MMUX_BASH_BUILTIN_STRING_NAME	"$1"
m4_define([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],[[[$1]]])m4_dnl
]]])


m4_dnl data structures

m4_dnl $1 - bulitin identifier
m4_dnl $2 - C language string representing the short documentation
m4_define([[[MMUX_BASH_DEFINE_BUILTIN_STRUCT]]],[[[m4_dnl
/* Bash will search for this struct  building the name "[[[]]]$1[[[]]]_struct" from the command
   line argument "[[[]]]$1[[[]]]" we have given to the "enable" builtin. */
mmux_bash_struct_builtin_t [[[]]]$1[[[]]]_struct = {
  .name		= "[[[]]]$1[[[]]]",		/* Builtin name */
  .function	= [[[]]]$1[[[]]]_builtin,	/* Function implementing the builtin */
  .flags	= MMUX_BASH_BUILTIN_ENABLED,	/* Initial flags for builtin */
  .long_doc	= [[[]]]$1[[[]]]_doc,		/* Array of long documentation strings. */
  .short_doc	= $2,				/* Usage synopsis; becomes short_doc */
  .reserved0	= NULL				/* Reserved for Bash. */
};
]]])

m4_dnl $1 - bulitin identifier
m4_dnl $2 - C language string representing a single-line long documentation
m4_define([[[MMUX_BASH_DEFINE_BUILTIN_LONG_DOC_SINGLE_LINE]]],[[[m4_dnl
/* A NULL-terminated array of ASCIIZ strings representing the lines of the
   builtin long documentation. */
static char * [[[]]]$1[[[]]]_doc[] = {
  $2,
  (char *)NULL
};
]]])


m4_dnl usages

m4_dnl $1 - bulitin identifier
m4_dnl $2 - C language expression about "argc": if true the number of argumets is wrong
m4_dnl $3 - C language string representing the short documentation
m4_dnl $4 - C language string representing the long documentation, a single-line
m4_define([[[MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION]]],[[[m4_dnl
m4_dnl Here we do not use the NO_OPTION  version of the implementation function: with that
m4_dnl version an argument  like "-1.2" is interpreted  as an option, and  an error raised
m4_dnl because there  are no  options allowed.   Here we  want such  arguments to  just go
m4_dnl through any validation and come to us as they are.
MMUX_BASH_DEFINE_BUILTIN_FUNCTION([[[$1]]],[[[$2]]])
MMUX_BASH_DEFINE_BUILTIN_LONG_DOC_SINGLE_LINE([[[$1]]],[[[$4]]])
MMUX_BASH_DEFINE_BUILTIN_STRUCT([[[$1]]],[[[$3]]])
]]])

m4_dnl m4_dnlif 0
m4_dnl /* Called when  the builtin is  enabled and loaded from  the shared object.   If this
m4_dnl    function returns 0, the load fails. */
m4_dnl int
m4_dnl add_builtin_load (char *name MMUX_BASH_POINTERS_UNUSED)
m4_dnl {
m4_dnl   return (1);
m4_dnl }
m4_dnl /* Called when `add' is disabled. */
m4_dnl void
m4_dnl add_builtin_unload (char *name)
m4_dnl {
m4_dnl }
m4_dnl #endif


m4_dnl helpers

m4_dnl $1 - Preprocessor symbol: if defined, include the body of code; otherwise include the alternative body.
m4_dnl $2 - The body of code.
m4_dnl $3 - The alternative of code.
m4_define([[[MMUX_BASH_CONDITIONAL_CODE]]],[[[m4_ifelse([[[$1]]],,[[[$2]]],[[[m4_dnl
#if ((defined $1) && (1 == $1))
$2
m4_ifelse([[[$3]]],,,[[[m4_dnl
#else
$3
]]])
#endif
]]])]]])


#### parsing arguments

# Put this at the end of a function that uses the parser macros.
#
# static int
# my_builtin_main (int argc, char const * char argv[])
# {
#   void *	arg;
#
#   MMUX_BASH_PARSE_BUILTIN_ARG_MPF_PTR([[[arg]]], [[[argv[1]]]]);
#   ...
#   return MMUX_SUCCESS;
#   MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
# }
#
m4_define([[[MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH]]],[[[
 mmux_error_parsing_builtin_argument:
  mmux_bash_pointers_set_ERRNO(EINVAL, MMUX_BASH_BUILTIN_STRING_NAME);
  return MMUX_FAILURE;
]]])

# --------------------------------------------------------------------

# $1 - type stem
# $2 - name of the target variable
# $3 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM]]],[[[{
  bool mmux_retval = mmux_$1_parse(&($2), $3, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_POINTER]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[pointer]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_ASCIIZ_PTR]]],[[[{ $1 = $2; }]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SCHAR]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[schar]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UCHAR]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[uchar]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SSHORT]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[sshort]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_USHORT]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[ushort]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINT]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[sint]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINT]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[uint]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SLONG]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[slong]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_ULONG]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[ulong]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SLLONG]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[sllong]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_ULLONG]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[ullong]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINT8]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[sint8]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINT8]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[uint8]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINT16]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[sint16]]],[[[$1]]],[[[$2]]])]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINT16]]],[[[MMUX_BASH_PARSE_BUILTIN_ARG_STEM([[[uint16]]],[[[$1]]],[[[$2]]])]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINT32]]],[[[{
  bool mmux_retval = mmux_sint32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINT32]]],[[[{
  bool mmux_retval = mmux_uint32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINT64]]],[[[{
  bool mmux_retval = mmux_sint64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINT64]]],[[[{
  bool mmux_retval = mmux_uint64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT]]],[[[{
  bool mmux_retval = mmux_float_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_DOUBLE]]],[[[{
  bool mmux_retval = mmux_double_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_LDOUBLE]]],[[[{
  bool mmux_retval = mmux_ldouble_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT32]]],[[[{
  bool mmux_retval = mmux_float32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT64]]],[[[{
  bool mmux_retval = mmux_float64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT128]]],[[[{
  bool mmux_retval = mmux_float128_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT32X]]],[[[{
  bool mmux_retval = mmux_float32x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT64X]]],[[[{
  bool mmux_retval = mmux_float64x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_FLOAT128X]]],[[[{
  bool mmux_retval = mmux_float128x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_DECIMAL32]]],[[[{
  bool mmux_retval = mmux_decimal32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_DECIMAL64]]],[[[{
  bool mmux_retval = mmux_decimal64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_DECIMAL128]]],[[[{
  bool mmux_retval = mmux_decimal128_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF]]],[[[{
  bool mmux_retval = mmux_complexf_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXD]]],[[[{
  bool mmux_retval = mmux_complexd_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXLD]]],[[[{
  bool mmux_retval = mmux_complexld_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF32]]],[[[{
  bool mmux_retval = mmux_complexf32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])
# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF64]]],[[[{
  bool mmux_retval = mmux_complexf64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF128]]],[[[{
  bool mmux_retval = mmux_complexf128_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF32X]]],[[[{
  bool mmux_retval = mmux_complexf32x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])
# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF64X]]],[[[{
  bool mmux_retval = mmux_complexf64x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXF128X]]],[[[{
  bool mmux_retval = mmux_complexf128x_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXD32]]],[[[{
  bool mmux_retval = mmux_complexd32_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXD64]]],[[[{
  bool mmux_retval = mmux_complexd64_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_COMPLEXD128]]],[[[{
  bool mmux_retval = mmux_complexd128_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_MODE]]],[[[{
  bool mmux_retval = mmux_mode_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SSIZE]]],[[[{
  bool mmux_retval = mmux_ssize_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_USIZE]]],[[[{
  bool mmux_retval = mmux_usize_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINTMAX]]],[[[{
  bool mmux_retval = mmux_sintmax_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINTMAX]]],[[[{
  bool mmux_retval = mmux_uintmax_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_SINTPTR]]],[[[{
  bool mmux_retval = mmux_sintptr_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UINTPTR]]],[[[{
  bool mmux_retval = mmux_uintptr_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# --------------------------------------------------------------------

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_PTRDIFF]]],[[[{
  bool mmux_retval = mmux_ptrdiff_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_OFF]]],[[[{
  bool mmux_retval = mmux_off_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_PID]]],[[[{
  bool mmux_retval = mmux_pid_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_UID]]],[[[{
  bool mmux_retval = mmux_uid_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_GID]]],[[[{
  bool mmux_retval = mmux_gid_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_WCHAR]]],[[[{
  bool mmux_retval = mmux_wchar_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_WINT]]],[[[{
  bool mmux_retval = mmux_wint_parse(&($1), $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (true == mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])


m4_dnl let's go

m4_dnl end of file
m4_dnl Local Variables:
m4_dnl mode: m4
m4_dnl End:
m4_divert(0)m4_dnl
