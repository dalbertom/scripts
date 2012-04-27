@echo off
set /p gitusername=user.name [%username%]=
if not defined gitusername set gitusername=%username%

set /p gitemail=user.email [%username%@%userdomain%]=
if not defined gitemail set gitemail=%username%@%userdomain%
git config --global user.name %gitusername%
git config --global user.email %gitemail%
set gitusername=
set gitemail=
echo on
git config --global alias.diffall "difftool -y -x 'compare -nowait'"
git config --global alias.fatp "fetch --all --tags --prune"
git config --global alias.s status
git config --global alias.d diff
git config --global alias.c "commit --cleanup=whitespace"
git config --global alias.g "grep -n"
git config --global alias.amend "commit --amend --cleanup=whitespace -C HEAD"
git config --global alias.clear "clean -e .metadata -e build/developer.properties"
git config --global alias.tree "log --oneline --decorate --graph --source"
git config --global alias.neighborhood "for-each-ref --sort='committerdate' --format='%(committerdate:short) %(refname)'"
git config --global alias.incoming "log ..@{u}"
git config --global alias.outgoing "log @{u}.."
git config --global color.ui true
git config --global core.autocrlf true
git config --global core.safecrlf warn
git config --global core.filemode false
git config --global diff.tool araxis
git config --global merge.tool araxis
git config --global difftool.path compare
git config --global mergetool.path compare
git config --global rerere.enabled 1