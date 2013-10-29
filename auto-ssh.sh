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
  localport=${3-$remoteport}
  gatewayuser=${4-$USER}
  gatewayhost=${5-$remotehost}
  
  ssh -f -L $localport:$remotehost:$remoteport -N $gatewayuser@$gatewayhost
}

function ssh-kill-tunnels {
  ps -ef | grep "ssh -f -L" | grep -v grep | awk '{print $2}' | xargs kill -9
}
