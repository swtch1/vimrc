### personal ###

bindkey "^h" backward-word
bindkey "^l" forward-word

KEYTIMEOUT=0

# PATH
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/Users/josh/go/bin"

export EDITOR='nvim'

# cd to a dir and ls -l right after
function cdl() {
  cd "$@" && ll
}

#function vim() {
#  if [ "$(env | grep VIM)" ]; then
#    echo "NO"
#  else
#    nvim "$@"
#  fi
#}
alias vim='nvim'
alias vimt='nvim -c terminal'
alias vimrc='nvim ~/.vimrc'
alias v='nvim'
alias vt='nvim -c terminal'
alias vg='nvim -c :G'
alias vimdiff='v diff'

alias h='history'
alias c='clear'
alias mk='minikube'
alias agg='ag --go'
alias cdc='cd ~/code'
alias cds='cd ~/code/speedscale/'
alias cdsm='cd ~/code/ss/ss/master/'
alias docker='sudo docker'
alias rigwake='wakeonlan A8:A1:59:2D:26:60'
alias kdbg='kill $(lsof -i -P | grep -i listen | grep __debug_ | tr -s " " | cut -d " " -f 2)'
alias tf='terraform'
alias sk='skaffold'
alias awslogin='aws sso login --profile dev'
alias gcurl='grpcurl'
alias e='exit'
alias ff="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias mk='microk8s'
alias dc='docker-compose'
alias theqr='open ~/doc/theqr.png'

# environment
alias envm='(drop ~/env/dev.env &> /dev/null || vim ~/env/dev.env) && envl'
alias envl='set -o allexport; source ~/env/dev.env; set +o allexport'
envl # load the env every time

# speedctl
alias s='speedctl'
alias ss='speedscale'
alias sm='speedmgmt'
alias soa='s deploy operator -e $(k config current-context) | k apply -f -'
alias sod='s deploy operator -e $(k config current-context) | k delete -f -'
export PROD_USER_ID='bec83d8b-2c15-4e2e-a0a5-7a90193665f4'

# task warrior
alias tk='task'
alias tkh='tk help | less'
alias tka='tk active'
alias tkm='tk modify'
alias tkls='tk ls'
alias tkd='tk delete'
# make taskwarrior annoying
# tk next

alias n='nerdctl'

# make it easier to spot the testing debug lines I drop
alias fixme='ag "FIXME: \(JMT\)"'

export REVIEW_BASE='master'
alias gp='git pull'
function gpw() { git --work-tree "$1" pull }
alias gpsh='git push'
alias gs='git status -s && git status | ag --no-color "git push"'
alias gc='git checkout'
alias gcm='git commit -m'
alias grb='git rebase origin/master'
alias gsh='git stash'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gd='git diff'
alias gdm='git diff origin/master..HEAD'
alias gdc='git diff --cached'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- "
alias gb='for k in $(git branch | sed s/^..//); do echo -e $(git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --)\\t"$k";done | sort'
alias gw='git worktree'
alias gwa='git worktree add'
function gpa() {
  for d in $(git worktree list| grep -v '(bare)'| cut -d ' ' -f 1);do
    echo "worktree: $d"
    git --work-tree "$d" pull
  done
}
function gpm() {
  for d in $(git worktree list| grep 'master'| cut -d ' ' -f 1);do
    echo "worktree: $d"
    git --work-tree "$d" pull
  done
}
# review helpers
# review one
alias gro="vim -p +\"tabdo Gdiffsplit master\"" # files go after
alias gr='git reviewone'


# kubernetes
alias k='kubectl'
alias wk='watch kubectl'
alias kx='kubectx'
alias sns='kubectl config set-context $(kubectl config current-context) --namespace '
alias kc='k create'
alias kg='k get'
alias ke='k edit'
alias kgp='k get pod'
alias wkgp='watch kubectl get pods'
alias kgd='k get deploy'
alias wkgd='watch kubectl get deploy'
alias kgs='k get svc'
alias kgns='kg ns'
alias wkgns='watch kubectl get ns'
alias ka='k apply'
alias kd='k delete'
alias kdp='k delete pod'
alias kl='k logs'

# run base64 easier
function b64d() {
  echo "$1" | base64 -d
}

# run go tests easier
function t() {
  if [[ -z "$1" ]]; then
    go test -timeout=15s -race  ./...
    return
  fi
  go test -timeout=5s -race ./... -run "$1"
}
# run go tests easier.. with file watches
function tw() {
  while true; do
    t $1
    fswatch -1 . > /dev/null
  done
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

# speedscale env vars
export SPEEDSCALE_HOME="/Users/josh/.speedscale"
export PATH=$SPEEDSCALE_HOME:$PATH

# speedctl env vars
export SPEEDCTL_HOME=/Users/josh/.speedscale
export PATH=$SPEEDCTL_HOME:$PATH

export PATH=$PATH:/Users/josh/.linkerd2/bin

# solana
export PATH="/Users/josh/.local/share/solana/install/active_release/bin:$PATH"

# node version manager nonsense
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
