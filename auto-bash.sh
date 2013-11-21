function define {
  set | awk "/^$1/,/^}/"
}

alias top-cmd='history | sed "s/ *//" | cut -d" " -f 3 | sort | uniq -c | sort -n'                                
alias top-git='history | grep "git " | grep -v history | sed "s/ *//" | cut -d" " -f 4 | sort | uniq -c | sort -n'
alias today="date +%Y-%m-%d"
alias yesterday="date -v-1d +%Y-%m-%d"
