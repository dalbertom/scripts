:: Checks out to a new branch and recreates projects if a crash is detected
git checkout %*
for /f %%a in ('git diff-tree -r HEAD@{0} HEAD@{1} -- */.project.template */.classpath.template */pom.xml ^| wc -l') do if not "%%a"=="0" call ant -f build/build.xml eclipse-projects-clean eclipse-projects