ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit ice depth"1" # git clone depth
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# auto load completions
autoload -U compinit && compinit
zinit cdreplay -q
# prompt
autoload -U colors && colors
# PROMPT='%(?.%F{blue}>.%F{red}>) %F{green}[%n@%m]%f %F{yellow}%~%f :: '
PROMPT='󰣇 %F{blue}%n%f :: '

# exports
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/n00b/scripts
export EDITOR=nvim
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
declare -x http_proxy="socks5h://192.168.42.129:9050"
declare -x https_proxy="socks5h://192.168.42.129:9050"
setopt correct

# aliases
alias la="ls -lah"
alias vi="nvim"
alias gall="git add . ;git commit --allow-empty-message -m '' ;prox git push -u origin main"
alias gs="git status"
alias ga="git add ."
alias gc="git commit --allow-empty-message -m ''"
alias gp="git push -u origin main"
alias s="shutdown now"
alias prox="proxychains -q" 
alias vizsh="vi ~/.zshrc" 
alias so="source ~/.zshrc" 
alias tns="tmux new -s '@kyliex7'"
alias tks="tmux kill-server"
alias t="tmux"
alias copy="xclip -selection clipboard"
alias chm="chmod +x"
alias brave="brave --proxy-server=socks5://192.168.42.129:9050"
alias ls="ls --color=auto"
alias c="clear"
alias vii3="vi ~/.config/i3/config"


### Keybinds ###
bindkey -v  # enable vim mode

# Insert mode mappings
bindkey -M viins '^f' autosuggest-accept
bindkey -M viins '^p' history-search-backward
bindkey -M viins '^n' history-search-forward
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^u' backward-kill-line
bindkey -M viins 'jj' vi-cmd-mode

# Command mode mappings
bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line
bindkey -M vicmd '^p' history-search-backward
bindkey -M vicmd '^n' history-search-forward
bindkey -M vicmd 'J' down-line-or-history
bindkey -M vicmd 'K' up-line-or-history

# FZF widgets
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-file-widget
bindkey '^[c' fzf-cd-widget

# --- Cursor shape control ---
# 1 -> blinking block
# 2 -> steady block
# 3 -> blinking underline
# 4 -> steady underline
# 5 -> blinking bar
# 6 -> steady bar

function zle-keymap-select {
  case $KEYMAP in
    vicmd)      echo -ne '\e[1 q' ;;  # steady block for NORMAL mode
    viins|main) echo -ne '\e[1 q' ;;  # steady bar for INSERT mode
  esac
}
zle -N zle-keymap-select

# When zsh first starts, make sure cursor matches mode
function zle-line-init {
  zle -K viins
  echo -ne '\e[1 q'  # steady bar
}
zle -N zle-line-init

# Fix cursor on exit (so you don’t get stuck with a weird shape)
precmd() { echo -ne '\e[1 q'; }
# hist
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd*' fzf-preview "ls --color $realpath"


# shell intergration
eval "$(fzf --zsh)"
