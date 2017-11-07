export PS1="[\u@\h \W]\$ "
export CLICOLOR=1
export LSCOLORS="DxGxcxdxCxegedabagacad"
#export GOROOT=$HOME/.go
export GOPATH=$HOME/.go

export PYTHONPATH="/Library/Python/2.7/site-packages:$PYTHONPATH"

alias awk='gawk'
alias ce='carton exec'
alias date='gdate'
alias h='history'
alias ll='ls -al'
alias readlink='greadlink'
alias sed='gsed'
alias pbcp='pbcopy;pbpaste;'
alias pbc='pbcopy;'
alias pbp='pbpaste;'
alias vi='reattach-to-user-namespace vim'
alias gitgraph='git log --graph --decorate --oneline'
alias date="gdate"

gittagsearch ()
{
    git for-each-ref --sort=-taggerdate --format='%(taggerdate:short) %(tag) %(taggername) %(subject)' refs/tags | head -n $1
}

pcap ()
{
    local TARGET=$1;
    TARGET=`echo "$TARGET" | grep -E '(stage|production)'`;
    if [ -z "$TARGET" ]; then
        echo "Usage: pcap [stage or production]";
        return 1;
    fi;
    VERSION="";
    if [ "$TARGET" == "production" ]; then
        git pull --tags > /dev/null 2>&1;
        TAG=`git for-each-ref --sort=-taggerdate --format='%(taggerdate:short) %(tag) %(taggername) %(subject)' refs/tags | head -n 10 | peco | perl -anle 'print $F[1]'`;
        if [ -z "$TAG" ]; then
            return 1;
        fi;
        APP=`echo $TAG | grep -o -E '(admin|batch)'`;
        VERSION="-Stag=$TAG";
    else
        if [ "$TARGET" == "stage" ]; then
            BRANCH=`git branch | peco | sed -e "s/\* //g"`;
            APP="admin";
            VERSION="-Sbranch=$BRANCH";
        fi;
    fi;
    CATAPP="";
    if [ -n "$APP" ]; then
        CATAPP="CATAPP=$APP";
    fi;
    echo "cap $VERSION $CATAPP TARGET=$TARGET deploy"
}

set_term_bgcolor ()
{
    local R=$1
    local G=$2
    local B=$3
    /usr/bin/osascript <<EOF
tell application "iTerm2"
  tell current session of first window
    set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
  end tell
end tell
EOF
}

resetcolor ()
{
    set_term_bgcolor 30 30 30
}

tmux_new ()
{
    tmux new -s $1
}

tmux_attach ()
{
    tmux a -t $1
}

tmux_kill ()
{
    tmux kill-session -t $1
}
