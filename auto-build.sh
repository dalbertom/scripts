# Aliases for internal build system

alias build="ant -s build/build.xml"
alias qbuild="build -Dskip.gwt=true"
alias crash="build clean-eclipse eclipse"
alias rebuild='qbuild -l build1.log sound dev || build -l build2.log sound dev || crash -l build3.log sound dev || build -l build4.log sound clean dev'
