function setup-sites {
  export SITE_USERNAME=$1
  export SITE_DEFAULT_DOMAIN=$2
  SITE_BASEDIR=$3
  export SITE_LOG_APPSERVER=$SITE_BASEDIR/$4
  export SITE_LOG_AUDIT=$SITE_BASEDIR/$5
  export SITE_BUILD_INFO=$SITE_BASEDIR/$6
}

function setup-ec2 {
  export EC2_HOME=$1
  export EC2_CERT=$2
  export EC2_PRIVATE_KEY=$3
  export PATH=$EC2_HOME/bin:$PATH
}

function site-list {
  ec2dtag | awk '/instance.*Name.*site:/ {print $6}' | sort
}

alias qssh='ssh -e none -o StrictHostKeyChecking=no'
function ssh-site {
  hostname=$1
  if [[ "$hostname" != "*.$SITE_DEFAULT_DOMAIN" ]]; then
    hostname=$hostname.$SITE_DEFAULT_DOMAIN
  fi
  shift
  ssh-forget $hostname
  qssh $SITE_USERNAME@$hostname $*
}

function site-info {
  ssh-site $* grep = $SITE_BUILD_INFO
}

function site-exceptions {
  ssh-site $* cat $SITE_LOG_APPSERVER | awk '/Exception/,/^$/ {print $0}'
}

function site-activity {
  ssh-site $* tail -f $SITE_LOG_AUDIT
}
