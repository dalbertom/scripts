function site-list {
  ec2dtag | awk '/instance.*Name.*site:/ {print $6}' | sort
}

alias qssh='ssh -A -e none -o StrictHostKeyChecking=no'
alias qscp='scp -o StrictHostKeyChecking=no'
