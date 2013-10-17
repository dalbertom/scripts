if [ ! -d ~/.gist ]; then
  git clone git@github.com:dalbertom/scripts ~/.gist

  cat<<EOF>>~/.profile
if [ -d ~/.gist ]; then
  for i in ~/.gist/auto-*.sh; do
    source \$i
  done
fi
EOF
fi

