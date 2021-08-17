### personal ###

KEYTIMEOUT=0

# PATH
export PATH=$PATH:~/go/bin

# speedctl env vars
export SPEEDCTL_HOME=/Users/josh/.speedscale
export PATH=$SPEEDCTL_HOME:$PATH

export EDITOR='vim'

# cd to a dir and ls -l right after
function cdl() {
  cd "$@" && ll
}

alias vim='nvim'
alias vimt='nvim -c terminal'
alias vimrc='vim ~/.vimrc'
alias v='vim'
alias vt='nvim -c terminal'

alias cdc='cd ~/code'
alias docker='sudo docker'
alias rigwake='wakeonlan A8:A1:59:2D:26:60'
alias kdbg='kill $(lsof -i -P | grep -i listen | grep __debug_ | tr -s " " | cut -d " " -f 2)'
alias tf='terraform'
alias awslogin='aws sso login --profile dev'
alias s='speedctl'
alias gcurl='grpcurl'
alias cds='cd ~/code/speedscale/'
alias envm='vim ~/env/dev.env'
alias envl='set -o allexport; source ~/env/dev.env; set +o allexport'
alias e='exit'

# make it easier to spot the testing debug lines I drop
alias fixme='ag "// FIXME: \(JMT\)"'

alias gp='git pull'
alias gpsh='git push'
alias gs='git status'
alias gc='git checkout'
alias gcm='git commit -m'
alias grb='git rebase origin/master'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gd='git diff'
alias gdc='git diff --color-words'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- "
alias gb='for k in $(git branch | sed s/^..//); do echo -e $(git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --)\\t"$k";done | sort'


# kubernetes
alias k='kubectl'
alias kx='kubectx'
alias sns='kubectl config set-context $(kubectl config current-context) --namespace '

# run base64 easier
function b64d() {
  echo "$1" | base64 -d
}

# run go tests easier
function t() {
  if [[ -z "$1" ]]; then
    go test ./...
    return
  fi
  go test ./... -run "$1"
}
# run go tests easier.. with file watches
function tw() {
  while true; do
    t $1
    fswatch -1 . > /dev/null
  done
}

# find files faster
function ff() {
  find . -iname "*$1*" | grep -v '.git/'
}

# know that our terminal is from vim
if [ "$(env | grep VIM)" ]; then
  FROM_VIM="%{$fg[red]%}[V]%{$reset_color%}"
  PS1="${FROM_VIM} ${PS1}"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

