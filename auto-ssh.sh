function setup-ssh {
  export SSH_OTHER_USERNAME=$1
  export SSH_OTHER_HOSTNAME=$2
}

function ssh-forget {
  ssh-keygen -R $1
}

function ssh-other {
  ping -o $SSH_OTHER_HOSTNAME && ssh -e none $SSH_OTHER_USERNAME@$SSH_OTHER_HOSTNAME $*
}

function ssh-tunnel {
  remotehost=$1
  remoteport=$2
  gatewayuser=${3-$USER}
  gatewayhost=${4-$remotehost}
  localport=${5-$remoteport}
  
  ssh -f -L $localport:$remotehost:$remoteport -N $gatewayuser@$gatewayhost
}
