#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: python_find_library_path.sh
#  所在目录: python-Python
#  说明: 本文件为 python_find_library_path.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-09-27 17:54:37 +0100 (Fri, 27 Sep 2019)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Shows the path to Python libraries given as arguments
#
# There is a better version of this in the adjacent DevOps Python Tools repo called python_find_library_path.py

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

python="${PYTHON:-python}"
python="$(type -P "$python" || die "'$python' not found")"

find_python_sys_path(){
    cat <<EOF |
from __future__ import print_function
# more likely to be right than \$USER
import getpass
import os
import sys
user = getpass.getuser()
for path in sys.path:
    # don't return local /Users/\$USER/Library/Python/2.7/lib/python/site-packages
    # as that is not the source of sys
    if user in path:
        continue
    if 'Python.framework' in path:
        path = path.rsplit('{}lib{}'.format(os.sep, os.sep))[0]
        print(path)
        break
    elif path.endswith('/site-packages'):
        print(path)
        break
EOF
    "$python" #|
    #sed 's,/python/*[[:digit:].]*/site-packages,,'
}

if [ $# -eq 0 ]; then
    find_python_sys_path
fi

for arg; do
    if [ "$arg" = "sys" ]; then
        find_python_sys_path
    else
        "$python" -c "from __future__ import print_function; import $arg; print($arg.__file__)"
    fi
done
