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
  dlhs=$(dirname $lhs)
  flhs=$(basename $lhs)
  drhs=$(dirname $rhs)
  frhs=$(basename $rhs)
  diff <(cd $dlhs; unzip -lv $flhs | awk '{print $NF " " $(NF-1)}' | sort) <(cd $drhs; unzip -lv $frhs | awk '{print $NF " " $(NF-1)}' | sort)
}
alias diff-jar=diff-zip

function diff-zip2 {
  lhs=${1?lhs}
  rhs=${2?rhs}
  tlhs=$(mktemp -d)
  trhs=$(mktemp -d)
  unzip -qo $lhs -d $tlhs
  unzip -qo $rhs -d $trhs
  find $tlhs $trhs -type f -name '*.jar' -o -name '*.zip' | while read i; do
    unzip -qo $i -d $i-diff && rm $i
  done
  diff -r $tlhs $trhs && rm -rf $tlhs $trhs
}
