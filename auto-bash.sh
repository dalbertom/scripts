function define {
  set | awk "/^$1/,/^}/"
}

alias top-cmd='history | sed "s/ *//" | cut -d" " -f 3 | sort | uniq -c | sort -n'                                
alias top-git='history | grep "git " | grep -v history | sed "s/ *//" | cut -d" " -f 4 | sort | uniq -c | sort -n'
alias today="date +%Y-%m-%d"
#alias yesterday="date -v-1d +%Y-%m-%d"
alias yesterday="date -d yesterday +%Y-%m-%d"

function absolute {
  rel=$1
  pushd $rel > /dev/null
  pwd
  popd > /dev/null
}

function diff-zip {
  lhs=${1?lhs}
  rhs=${2?rhs}
  diff <(unzip -lv $lhs | awk '{print $NF " " $(NF-1)}' | grep -v 00000000 | sort) <(unzip -lv $rhs | awk '{print $NF " " $(NF-1)}' | grep -v 00000000 | sort)
}
alias diff-jar=diff-zip
