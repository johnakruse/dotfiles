# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/john/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
setopt COMPLETE_ALIASES HIST_IGNORE_DUPS

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# arrow select for autocomplete
zstyle ':completion:*' menu select

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

# prompt themes
autoload -Uz promptinit
promptinit

autoload -Uz colors && colors

#Prompt
#Right hand side of prompt
RPROMPT="[%{$fg[green]%}%*%{$reset_color%}]"
#Left hand side of prompt
PS1="%{$fg[red]%}%n%{$reset_color%} %{$fg_no_bold[yellow]%}%~ %{$reset_color%}%# "

export _JAVA_AWT_WM_NONREPARENTING=1

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
