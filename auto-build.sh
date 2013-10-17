# Aliases for internal build system

alias build="ant -s build/build.xml"
alias qbuild="build -Dskip.gwt=true"
alias crash="build clean-eclipse eclipse"
alias rebuild='qbuild sound dev || build sound dev || crash sound dev || build sound clean dev'
