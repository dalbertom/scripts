git reset --hard %1
git commit --amend -c HEAD
git rebase --onto HEAD HEAD~1 "HEAD@{2}"