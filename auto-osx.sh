#alias panic='killall Dock Finder SystemUIServer'

# http://ianlunn.co.uk/articles/quickly-showhide-hidden-files-mac-os-x-mavericks/
alias showFiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

function bye {
  [ ! -z $1 ] && sleep $1
  pmset sleepnow              
}

function brb {
  pmset displaysleepnow
}

function lock {
  ssh-add -D
  security lock-keychain -a
  /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
}

function flush-dns {
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}

# http://blog.mattcrampton.com/post/64144666914/managing-wifi-connections-using-the-mac-osx
function wifi-scan {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan
}

function wifi {
  if [ $# -eq 0 ]; then
    networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}'
  else
    networksetup -setairportpower `wifi` $1
  fi
}

function wifi-network {
  if [ $# -eq 0 ]; then
    networksetup -getairportnetwork `wifi`
  else
    networksetup -setairportnetwork `wifi` $1 ${2--}
  fi
}

function wifi-preferred-list {
  networksetup -listpreferredwirelessnetworks `wifi`
}

function socks-on {
  networkservice=${1-Wi-Fi}
  networksetup -setsocksfirewallproxystate "$networkservice" on
}

function socks-off {
  networkservice=${1-Wi-Fi}
  networksetup -setsocksfirewallproxystate "$networkservice" off
}

function socks-setup {
  hostname=${1?hostname}
  port=${2?port}
  networkservice=${3-Wi-Fi}
  networksetup -setsocksfirewallproxy "$networkservice" $hostname $port
}

function topp {
  top -l 1 -stats MEM,COMMAND -o MEM \
  | sed -E 's/ +/,/;s/ *$//;s/ /-/g' \
  | awk -F, 'NR>12 {
    if($1~/M/) $1*=1024*1024; else if($1~/K/) $1*=1024; map[$2]+=$1
  } END {for(k in map) print map[k]/1024/1024 " " k}' \
  | sort -n
}
