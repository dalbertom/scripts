:: Runs svn update on the current directory
svn info | find "Revision" > prev.txt
svn update --quiet %*