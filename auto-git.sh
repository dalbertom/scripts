function setup-git {
  export MASTER=$1
  export REMOTES=$2
}

function git-aliases {
  git config --global alias.g "grep -n"
  git config --global alias.s "status -sb"
  git config --global alias.neighborhood "for-each-ref --sort='committerdate' --format='%(committerdate:short),%(refname),%(committername)'"
  git config --global alias.incoming "log ..@{u}"
  git config --global alias.outgoing "log @{u}.."
}

function git-hunt {
  target=$1
  base=$2
  if [ -z $base ]; then base=HEAD; fi
  git rev-list --reverse --merges --first-parent $target..$base \
  | while read changeset; do 
    git log --format="$changeset %H" $changeset^1..$changeset^2 | grep $target && git log -1 $changeset && break
  done
}

function git-hunt2 {
  target=$1
  base=${2-HEAD}
  git rev-list --reverse --merges --first-parent $target..$base \
  | while read i; do 
    git merge-base --is-ancestor $target $i^2 && echo $i && break
  done | xargs git log -1
}

function git-hunt3 {
  target=$1
  base=${2-HEAD}
  git rev-list --ancestry-path --reverse --merges $target..$base | head -1 | xargs git log -1
}

function git-fixup {
  git ls-files -m $* | while read file; do
    echo "Diff for $file"
    git diff -U1 $file | grep ^@@ | cut -d @ -f 3 | sed -E -e "s/[-+]([0-9]+),([0-9]+)/-L\1,+\2/g" | awk -v f=$file '{
      system(sprintf("git blame -s $MASTER..HEAD %s %s", $1, f))
      print ""
      system(sprintf("git blame -fs HEAD %s %s", $1, f))
      print ""
      system(sprintf("git blame -s %s %s", $2, f))
      print "-------------"
    }'
  done
}

function git-praise {
  git grep -n $* | cut -d: -f 1-2 | sed "s/:\(.*\)/ -L\1,+1/" | xargs -n 2 git --no-pager blame -w -fn HEAD
}

function git-review {
  d=$1
  git neighborhood refs/remotes \
  | grep "^$d" | cut -d , -f 2 \
  | while read i; do
    git -c core.whitespace=cr-at-eol log --source --decorate --dirstat --log-size --format=fuller -p -C -w $MASTER..$i
  done
}
function git-review-today {
  git-review `today`
}
function git-review-yesterday {
  git-review `yesterday`
}

function git-review-rebases {
  git neighborhood refs/remotes | cut -d , -f 2 | cut -d / -f 3- \
  | grep -v master | while read i; do 
    git rev-list -g --count $i 2> /dev/null || echo 0; echo $i; done \
  | xargs -n 2 | sort -n | awk '$1 > 1 {print $2}' \
  | while read i; do 
    echo -e "\n$i"; git rev-list -g $i \
  | while read j; do echo $(git merge-base $MASTER $j) $j; done; done
}

function git-stat-commit {
  git log --oneline --shortstat --format="commit %h" --no-merges $* \
  | awk '/commit/ {hash=$2} /file/ {printf("%s %s %s\n", hash, $4, $6)}'
}

function git-stat-overall {
  git log --oneline --shortstat --format="commit %h" --no-merges $* \
  | awk '/commit/ {hash=$2} /file/ {add+=$4; del+=$6} END {print add; print del}'
}

# Create branches for
# all pull requests
function github-pr-fetch {
  remote=$1
  git fetch $remote refs/pull/*:refs/heads/*
}
# Find pull requests that have not been
# merged into the given branch
function github-pr-no-merged {
  target=$1
  git branch --no-merged $target \
  | grep head | cut -d / -f 1 | sort -rn \
  | while read i; do
    git show-ref -q $i/merge && git name-rev --name-only --refs=refs/remotes/* $i/merge^1 \
    | grep -q $target && echo $i
  done
}

function git-review-fetch {
  url=git@github.com
  repo=$(git remote | while read i; do git config remote.$i.url | cut -d : -f 2 | cut -d / -f 2; done | sort -u | head -1)
  for i in $REMOTES; do
    git config remotes.$i > /dev/null
    if [ $? -eq 0 ]; then
      for j in $(git config remotes.$i); do
        git remote | grep -q $j || git remote add $j $url:$j/$repo
      done
    else
      git remote | grep -q $i || git remote add $i $url:$i/$repo
    fi
  done
  git fetch --multiple $REMOTES
}

function git-owner {
  echo By commit
  git shortlog -nes --no-merges $*
  echo By line
  git blame -w -f -e -C $* | awk '{print $3}' | sort | uniq -c | sort -rn
}

# infer tracking branch
# of current branch
function git-tracking {
  git branch -vv | grep "^*" | grep -o "\[.*\]" | awk '{print substr($0,2,length($0)-2)}' | cut -d : -f 1
}

function git-independent {
  git branch -r --no-merged $MASTER \
  | xargs git merge-base --independent \
  | git name-rev --stdin --name-only --refs=refs/remotes/* \
  | cut -d / -f 2-
}

function git-parents {
  git rev-list --first-parent --parents --merges $MASTER..HEAD \
  | awk '{first[$1]=1; for(i=1;i<=split($0,tmp);i++) all[tmp[i]]=1} 
     END {for(k in first) delete all[k]; for(k in all) print k}'
}

function git-ls-dir {
  dir=$1
  git ls-files -- */$1/* | grep -o ".*$1" | sort -u
}

function git-whoami {
  echo $GIT_DIR $GIT_WORK_TREE
}

function git-workspace {
  export GIT_DIR=$1
  export GIT_WORK_TREE=$2
}

# preferred over git-workspace
function git-link {
  if [ -f .git ]; then cat .git; fi 
  echo "gitdir: $1" > .git
}

function git-find {
  find . -type d -name "*.git" $*
}

function git-du {
  git-find | xargs du -sh
}

# assuming the current branch was based
# off the previous branch @{-1}, it will
# change the current branch parent to the
# newly-rebased parent. This walks the 
# reflog of the previous branch to find
# the best candidate in case there were
# multiple rebases in the parent branch
# before reparenting the current branch.
function git-reparent {
  git rev-list -g @{-1} | while read i; do
    git merge-base --is-ancestor $i @ && git rebase --onto @{-1} $i && break
  done
}

if [ -n "$SSH_TTY" ]; then
  PS1='\[\e[0;37m\]\t \[\e[0;32m\]\u@\h \[\e[0;36m\]\w\[\e[0;33m\]\n\[\e[0;37m\]\!\[\e[0m\]\$ '
else
  PS1='\[\e[0;37m\]\t \[\e[0;32m\]\u@\h \[\e[0;36m\]\w\[\e[0;33m\]$(__git_ps1 " (%s)")\n\[\e[0;37m\]\!\[\e[0m\]\$ '
fi

# Adds a * for modified files
# Adds a + for staged files
GIT_PS1_SHOWDIRTYSTATE=true

# Adds a $ for stashed files
GIT_PS1_SHOWSTASHSTATE=true

# Adds a % for untracked files
GIT_PS1_SHOWUNTRACKEDFILES=true

# < indicates behind
# > indicates ahead
# <> indicates diverged
GIT_PS1_SHOWUPSTREAM=auto
