#!/usr/bin/env bash
# 中文注释版本: count_questions.sh
# 所在目录: scripts-脚本

#!/usr/bin/env bash

set -eu

count=$(echo $(( $(grep -E "\[Exercise\]|</summary>" -c README.md topics/*/README.md | awk -F: '{ s+=$2 } END { print s }' ))))

echo "There are $count questions and exercises"

sed -i "s/currently \*\*[0-9]*\*\*/currently \*\*$count\\**/" README.md
