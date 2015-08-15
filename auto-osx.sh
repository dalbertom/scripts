alias panic='killall Dock Finder SystemUIServer'

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

function flush-dns {
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}
