############################## PLUGINS ##################################
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"

if [[ ! -d "$ZSH_PLUGIN_DIR/fzf-tab" ]]; then
  mkdir -p "$ZSH_PLUGIN_DIR"
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git "$ZSH_PLUGIN_DIR/fzf-tab"
fi
source "$ZSH_PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"

if [[ ! -d "$ZSH_PLUGIN_DIR/zsh-completions" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git "$ZSH_PLUGIN_DIR/zsh-completions"
fi
fpath+=("$ZSH_PLUGIN_DIR/zsh-completions/src")


############################## COMPLETION ################################
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

############################## PROMPT ####################################
autoload -U colors && colors
# PROMPT='%F{#eeeeee}󰣇%f %F{#999999}%~%f %F{#eeeeee}$%f '
# PROMPT='%F{green}%n@%m %F{blue}%~ %# %f'
# NEWLINE=$'\n'
# PROMPT="%K{#11111b}%F{#cdd6f4}  %n %K{#181825}%F{#b4befe} %~ %f%k %F{#f38ba8}󰇁%f "
PROMPT="%F{#11111b}%F{#cdd6f4}  %n %F{#b4befe} %~ %f %F{#f38ba8}󰇁%f "

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

############################## GLOBAL EXPORTS ############################
eval "$(batman --export-env)"
declare -x http_proxy=socks5h://192.168.42.129:9050
declare -x https_proxy=socks5h://192.168.42.129:9050
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/n00b/scripts:/home/n00b/.local/bin:/home/n00b/.npm-global/bin
export EDITOR=nvim
setopt correct
export LIBVA_DRIVER_NAME=iHD
# export CLANGD_FLAGS="--fallback-style=webkit"
export FZF_DEFAULT_OPTS="
  --border=sharp \
  --border-label='' \
  --preview-window=border-sharp \
  --prompt='> ' \
  --marker='>' \
  --pointer='*' \
  --separator='─' \
  --scrollbar='|' \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --color=spinner:#F5E0DC,hl:#F38BA8,fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC,marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8,selected-bg:#45475A,border:#6C7086,label:#CDD6F4
"

############################## ALIASES ###################################
alias vi="NVIM_APPNAME=nvim-nvchad nvim"
alias ..="cd .."
alias chm="chmod +x"
alias py="python3"
alias ipy="ipython"
alias pwndir="cd ~/learn/pwn.college"
alias sus="systemctl suspend"
alias y="yazi"
alias ghidra="export _JAVA_AWT_WM_NONREPARENTING=1 AWT_TOOLKIT=MToolkit ; /usr/bin/ghidra "
alias gdb="gdb -q -x ~/dotfiles/gdb/x_og.cfg"
alias f="firefox"
alias chem="cd ~/al/chem/pap"
alias ph="cd ~/al/ph/pap"
alias cm="cd ~/al/cm/pap"
alias autorm="sudo pacman -Rns \$(pacman -Qdtq)"
alias mdwms="cd ~/dotfiles/suckless/dwmstatus; sudo make clean install; cd -"
alias mdwm="cd ~/dotfiles/rice/dwm-flexipatch/; sudo make clean install; cd -"
alias mst="cd ~/dotfiles/rice/st; sudo make clean install; cd -"
alias pav="pavucontrol"
# alias neofetch="fastfetch --config ascii-art.jsonc"
alias neofetch="fastfetch --config examples/13.jsonc"
alias git="proxychains -q git"
alias gs="git status"
alias ga="git add ."
alias gp="proxychains -q git push -u origin main"
alias gp="git push -u origin main"
alias gall="ga; gc; gp"
alias p="proxychains -q" 
alias vizsh="vi ~/.zshrc" 
alias so="source ~/.zshrc" 
alias tns="tmux new -s 'main'"
alias tks="tmux kill-server"
alias t="tmux"
# alias copy="xclip -selection clipboard"
alias copy="wl-copy"
alias ls="ls --color=auto --sort=version"
alias la="ls -lah"
alias c="clear"
alias vii3="$EDITOR ~/.config/i3/config"

############################## STUFF #################################
pipz(){ pip install "$@" --break-system-packages; }
i(){ sudo proxychains -q pacman -S "$@"; }
pullzsh(){
git -C ~/.zsh/plugins/fzf-tab pull; git -C ~/.zsh/plugins/zsh-completions pull
}
gc(){
  if [[ $# -eq 0 ]]; then
    git commit --allow-empty-message -m ""
  else
    git commit -m "$@"
  fi
}
sn(){
  neofetch
  echo -ne "shutting down in "
  for i in {1..3}; do
    echo -ne "${i}... "
    sleep 0.9
  done
  shutdown now
}
pipxa(){
  unset http_proxy https_proxy
  p pipx install "${@}"
  source ~/.zshrc
}
pipxu(){
  p pipx uninstall "${@}"
}
############################## KEYBINDS ##################################
bindkey -v  # vim mode

# Insert mode
# bindkey -M viins '^f' autosuggest-accept
bindkey -M viins '^p' history-search-backward
bindkey -M viins '^n' history-search-forward
bindkey '^u' backward-kill-word
# bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

# Command mode
bindkey -M vicmd '^p' history-search-backward
bindkey -M vicmd '^n' history-search-forward
bindkey -M vicmd 'J' down-line-or-history
bindkey -M vicmd 'K' up-line-or-history

# FZF widgets
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-file-widget
bindkey '^[c' fzf-cd-widget


############################## CURSOR MODE ###############################
# function zle-keymap-select {
#   case $KEYMAP in
#     vicmd)      echo -ne '\e[3 q' ;;  # blinking block for NORMAL
#     viins|main) echo -ne '\e[3 q' ;;  # blinking bar for INSERT
#   esac
# }
# zle -N zle-keymap-select
#
# function zle-line-init {
#   zle -K viins
#   echo -ne '\e[1 q'   # start prompt in INSERT with blinking block
# }
# zle -N zle-line-init
#
# precmd() { echo -ne '\e[1 q'; }  # restore blinking block before prompt

############################## HISTORY ###################################
HISTSIZE=10000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

############################## FZF-TAB SETTINGS ##########################
zstyle ':fzf-tab:*' fzf-flags --height=40% --border
zstyle ':fzf-tab:*' default-color $'\033[38;2;144;140;170m'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-a:toggle-all'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Directory preview examples
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(ls|bat|cat|vim|nvim|vi):*' fzf-preview 'ls --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(cp|mv|rm|mkdir|touch):*' fzf-preview 'ls --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:*' fzf-preview '
  if [ -d $realpath ]; then
      ls --color=always $realpath 2>/dev/null
  else
      bat --color=always $realpath 2>/dev/null || ls --color=always $realpath 2>/dev/null
  fi'

############################## FZF INTEGRATION ###########################
if [[ $- == *i* ]]; then
  eval "$(fzf --zsh)"
fi
