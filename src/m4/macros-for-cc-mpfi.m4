m4_divert(-1)m4_dnl
#
# Part of: MMUX Bash MPFI
# Contents: macros to define builtins specialised to MPFI
# Date: Oct 28, 2024
#
# Abstract
#
#	This library  defines macros to  automatically generate C  language functions
#	for GNU Bash builtins implementation.
#
# Copyright (C) 2024 Marco Maggi <mrc.mgg@gmail.com>
#
# This program is free  software: you can redistribute it and/or  modify it under the
# terms  of  the  GNU General  Public  License  as  published  by the  Free  Software
# Foundation, either version 3 of the License, or (at your option) any later version.
#
# This program  is distributed in the  hope that it  will be useful, but  WITHOUT ANY
# WARRANTY; without  even the implied  warranty of  MERCHANTABILITY or FITNESS  FOR A
# PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received  a copy of the GNU General Public  License along with this
# program.  If not, see <http://www.gnu.org/licenses/>.
#


#### parsing arguments

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR]]],[[[{
  int  mmux_retval = mmux_mpfi_ptr_parse(&$1, $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (MMUX_SUCCESS != mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])

# $1 - name of the target variable
# $2 - expression evaluating to the string to parse
m4_define([[[MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR_ARRAY]]],[[[{
  int  mmux_retval = mmux_mpfi_ptr_array_parse(&$1, $2, MMUX_BASH_BUILTIN_STRING_NAME);
  if (MMUX_SUCCESS != mmux_retval) { goto mmux_error_parsing_builtin_argument; }
}]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_NULLARY_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[2]]]]);
  {
    int		rv = $1(rop, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[3]]]]);
  {
    int		rv = $1(rop, op, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_BUILTIN_NORND]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[2]]]]);
  {
    int		rv = $1(rop, op);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(3 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_SI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  mmux_slong_t	op;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SLONG([[[op]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[3]]]]);
  {
    int		rv = $1(rop, op, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP SLONG_OP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,SLONG_OP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_UI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  mmux_ulong_t	op;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[3]]]]);
  {
    int		rv = $1(rop, op, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP ULONG_OP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_SJ_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr		rop;
  mmux_sintmax_t	op;
  mpfi_rnd_t		rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SINTMAX([[[op]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[3]]]]);
  {
    int		rv = $1(rop, op, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP SINTMAX_OP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UNARY_UJ_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr		rop;
  mmux_uintmax_t	op;
  mpfi_rnd_t		rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_UINTMAX([[[op]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[3]]]]);
  {
    int		rv = $1(rop, op, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(4 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP UINTMAX_OP MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op1, op2;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 MPFI_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_SI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op1;
  mmux_slong_t	op2;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SLONG([[[op2]]],		[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 SLONG_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_UI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op1;
  mmux_ulong_t	op2;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op2]]],		[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 ULONG_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_SJ_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr		rop, op1;
  mmux_sintmax_t	op2;
  mpfi_rnd_t		rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SINTMAX([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 SINTMAX_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_UJ_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr		rop, op1;
  mmux_uintmax_t	op2;
  mpfi_rnd_t		rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_UINTMAX([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 UINTMAX_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_BINARY_Z_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op1;
  mpz_ptr	op2;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPZ_PTR([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 MPZ_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UI_BINARY_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op2;
  mmux_ulong_t	op1;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op1]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP ULONG_OP1 MPFI_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_SI_BINARY_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op2;
  mmux_slong_t	op1;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_SLONG([[[op1]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP SLONG_OP1 MPFI_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_UI_BINARY_UI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop;
  mmux_ulong_t	op1;
  mmux_ulong_t	op2;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op1]]],		[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op2]]],		[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[4]]]]);
  {
    int		rv = $1(rop, op1, op2, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(5 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP ULONG_OP1 ULONG_OP2 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,RND)."]]])
]]])]]])


m4_dnl $1 - function identifier
m4_dnl $2 - C preprocessor symbol for conditional code
m4_define([[[DEFINE_TERNARY_UI_BUILTIN]]],[[[MMUX_BASH_CONDITIONAL_CODE([[[$2]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	rop, op1, op2;
  mmux_ulong_t	op3;
  mpfi_rnd_t	rnd;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[rop]]],	[[[argv[1]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op1]]],	[[[argv[2]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op2]]],	[[[argv[3]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_ULONG([[[op3]]],		[[[argv[4]]]]);
  MMUX_BASH_PARSE_BUILTIN_ARG_MPFR_RND([[[rnd]]],	[[[argv[5]]]]);
  {
    int		rv = $1(rop, op1, op2, op3, rnd);
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(6 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_ROP MPFI_OP1 MPFI_OP2 ULONG_OP3 MPFR_RND"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]](ROP,OP1,OP2,OP3,RND)."]]])
]]])]]])


m4_dnl $1 - the predicate function
m4_dnl $2 - argument description for the short doc
m4_define([[[DEFINE_PREDICATE_BUILTIN]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  mpfi_ptr	op;

  MMUX_BASH_PARSE_BUILTIN_ARG_MPFI_PTR([[[op]]],	[[[argv[1]]]]);
  {
    int		rv = $1(op);
    /* This is true if the predicate is satisfied. */
    rv = (rv)? 1 : 0;
    return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
  }
  MMUX_BASH_BUILTIN_ARG_PARSER_ERROR_BRANCH;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(2 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER MPFI_OP"]]],
    [[["Store 1 in MPFI_RV if OP is a representation of $2; otherwise store 0."]]])
]]])


m4_define([[[DEFINE_VOID_VOID_BUILTIN]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  $1();
  return MMUX_SUCCESS;
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(1 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]]()."]]])
]]])


m4_define([[[DEFINE_INT_VOID_BUILTIN]]],[[[MMUX_BASH_BUILTIN_MAIN([[[$1]]])
{
  int	rv = $1();
  return mmux_bash_mpfi_set_MPFI_RV(rv, MMUX_BASH_BUILTIN_STRING_NAME);
}
MMUX_BASH_DEFINE_TYPICAL_BUILTIN_FUNCTION([[[MMUX_BASH_BUILTIN_IDENTIFIER]]],
    [[[(1 == argc)]]],
    [[["MMUX_BASH_BUILTIN_IDENTIFIER"]]],
    [[["Compute MMUX_BASH_BUILTIN_IDENTIFIER[[[]]]()."]]])
]]])


# let's go

# end of file
# Local Variables:
# mode: m4
# End:
m4_divert(0)m4_dnl
