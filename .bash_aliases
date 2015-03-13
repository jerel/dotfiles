
alias a='git add'
alias b='git branch'
alias co='git checkout'
alias ci='git commit --interactive'
alias s='git status'

alias attach='tmux attach -t '
alias list='tmux list-sessions'

new-session () {
    # the session wasn't named
    if [ $# -eq 0 ]
    then
      tmux new-session -d vim
    else
      tmux new-session -s $1 -d vim
    fi
    tmux split-window -l 20 -d
    tmux attach-session
}

