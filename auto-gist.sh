function setup-gist {
  git clone git@github.com:dalbertom/scripts ~/.gist
}

function gist-pull {
  pushd ~/.gist
  git pull
  popd
  source ~/.profile
}

