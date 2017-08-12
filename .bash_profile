# settings for your terminal prompt
export PS1='$(whoami)@macbook:`basename $PWD` $'

# uses the git-completion file in your home directory downloaded from here [curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias ll='ls -altr'

alias dockrrm='docker rm -f $(docker ps -aq)'

JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
export JAVA_HOME

#PATH=$JAVA_HOME:$M3_HOME:/bin$PATH
PATH=/usr/local/bin:$JAVA_HOME:$PATH
export PATH

