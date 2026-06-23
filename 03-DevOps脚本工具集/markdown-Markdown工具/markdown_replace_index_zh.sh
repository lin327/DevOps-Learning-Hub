#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: markdown_replace_index.sh
#  所在目录: markdown-Markdown工具
#  说明: 本文件为 markdown_replace_index.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2024-08-17 03:06:53 +0200 (Sat, 17 Aug 2024)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Replaces the index block of a given markdown file

Uses the adjacent script markdown_generate_index.sh

Requires the markdown file to have lines with

<!-- INDEX_START -->

    and

<!-- INDEX_END -->

lines to demark the index block


If no file is given but README.md is found in the \$PWD, then uses that
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<README.md>]"

help_usage "$@"

max_args 1 "$@"

markdown_file="${1:-README.md}"

index_tmp="$(mktemp)"

markdown_tmp="$(mktemp)"

if ! [ -f "$markdown_file" ]; then
    die "File not found: $markdown_file"
fi

# check the tags existing in the markdown file otherwise we can't do anything
for x in INDEX_START INDEX_END; do
    if ! grep -q "<!--.*$x.*-->" "$markdown_file"; then
        die "Markdown file '$markdown_file' is missing the index boundary comment <!--.*$x.*-->"
    fi
done

timestamp "Generating new index for file: $markdown_file"

"$srcdir/markdown_generate_index.sh" "$markdown_file" > "$index_tmp"

timestamp "Replacing index in file: $markdown_file"

sed -n "
    1,/INDEX_START/p

    /INDEX_START/ a

    /INDEX_START/,/INDEX_END/ {
        /INDEX_START/ {
            r $index_tmp
        }
    }

    /INDEX_END/ i

    /INDEX_END/,$ p
" "$markdown_file" > "$markdown_tmp"

#unalias mv &>/dev/null || :
mv -f "$markdown_tmp" "$markdown_file"

#unalias rm &>/dev/null || :
rm -f "$index_tmp"

timestamp "Replaced index in file: $markdown_file"
