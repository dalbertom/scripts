function setup-mysql {
  export MYSQL_HOME=$1
}

function mysql-start {
  pushd $MYSQL_HOME/bin
  ./mysqld_safe &
  sleep 5
  ./mysql -u root
}

function mysql-kill {
  ps -ef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9
}