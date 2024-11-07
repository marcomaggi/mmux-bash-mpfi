m4_divert(-1)m4_dnl
#
# Part of: MMUX Bash Builtins Macros
# Contents: macros to define builtins
# Date: Oct 14, 2024
#
# Abstract
#
#	This  library defines  macros  to automatically  generate  GNU bash  language
#	stuff.
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

m4_changequote(`[[[', `]]]')

m4_define([[[MMUX_M4_TOUPPER]]],[[[m4_translit([[[$1]]],[[[abcdefghijklmnopqrstuvwxyz]]],[[[ABCDEFGHIJKLMNOPQRSTUVWXYZ]]])]]])
m4_define([[[MMUX_M4_TOLOWER]]],[[[m4_translit([[[$1]]],[[[ABCDEFGHIJKLMNOPQRSTUVWXYZ]]],[[[abcdefghijklmnopqrstuvwxyz]]])]]])

m4_define([[[QQ]]],[[[m4_ifelse($#,1,"${$1}",$#,2,"${$1[$2]}",
  [[[m4_errprint(m4___program__:m4___file__:m4___line__: wrong number of arguments in qq use ($#): $@
)]]])]]])

m4_define([[[WW]]],[[[m4_ifelse($#,1,"${$1:?}",$#,2,"${$1[$2]:?}",
  [[[m4_errprint(m4___program__:m4___file__:m4___line__: wrong number of arguments in ww use ($#): $@
)]]])]]])

m4_define([[[RR]]],[[[m4_ifelse($#,1,${$1:?},$#,2,${$1[$2]:?},
  [[[m4_errprint(m4___program__:m4___file__:m4___line__: wrong number of arguments in rr use ($#): $@
)]]])]]])

m4_define([[[SS]]],[[[m4_ifelse($#,2,$1[$2],
  [[[m4_errprint(m4___program__:m4___file__:m4___line__: wrong number of arguments in ss use ($#): $@
)]]])]]])

m4_define([[[PP]]],[[[m4_ifelse($#,2,${$1:?"missing parameter $1 $2 in call to '$FUNCNAME'"},
  [[[m4_errprint(m4___program__:m4___file__:m4___line__: wrong number of arguments in ss use ($#): $@
)]]])]]])

# end of file
# Local Variables:
# mode: m4
# End:
m4_divert(0)m4_dnl
