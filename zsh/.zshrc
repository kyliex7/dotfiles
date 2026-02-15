if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

############################## PLUGINS ##################################
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"

plugins=(
	Aloxaf/fzf-tab
	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
)

for plugin in $plugins; do
    plugin_name=${plugin#*/}
    if [[ ! -d "$ZSH_PLUGIN_DIR/$plugin_name" ]]; then
        echo "Installing $plugin_name..."
        git clone --depth=1 "https://github.com/$plugin" "$ZSH_PLUGIN_DIR/$plugin_name"
    fi
done

source "$ZSH_PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"
# source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

############################## COMPLETION ################################
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

############################## PROMPT ####################################
#autoload -U colors && colors
# PROMPT='%F{#eeeeee}󰣇%f %F{#999999}%~%f %F{#eeeeee}$%f '
# PROMPT='%F{green}%n@%m %F{blue}%~ %# %f'
# NEWLINE=$'\n'
# PROMPT="${NEWLINE}%K{#11111b}%F{#cdd6f4}  %n %K{#181825}%F{#b4befe} %~ %f%k %F{#f38ba8}❯%f "
# PROMPT='%F{#a89984}%~%f %F{#928374}❯%f '
# PROMPT=' %F{#a89984}%~%f %F{#928374}%f '

############################## GLOBAL EXPORTS ############################
# export CLANGD_FLAGS="--fallback-style=LLVM"
eval "$(batman --export-env)"
export BAT_THEME="tokyonight_night"
declare -x http_proxy=socks5h://192.168.42.129:9050
declare -x https_proxy=socks5h://192.168.42.129:9050
# export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/n00b/scripts:/home/n00b/.local/bin:/home/n00b/.npm-global/bin:
export EDITOR=nvim
export NVIM_APPNAME=nvim
typeset -U path
path=(
	~/scripts
	~/.local/bin
	~/.npm_global/bin
	$path
)

setopt correct
setopt autocd
setopt autopushd        # pushd every time you cd
setopt pushdignoredups  # don't store duplicates
setopt pushdminus       # use - for the stack instead of +

############################## ALIASES ###################################

# suffix aliases
alias -s md="bat"
alias -s png="qiv"
alias -s jpg="qiv"
alias -s pcap="wireshark"
alias -s json="jq ."
alias -s html="librewolf"
alias -s log="bat"
alias -s pdf="evince"
alias -s py="python3"
# global aliases
alias -g NE="2>/dev/null"
alias -g C="| wl-copy"
alias -g G='| grep --color=auto'
alias -g L='| bat'
alias -g M='| most'
alias -g H='| head'
alias -g T='| tail'
# Recursively grep for a string, ignore binaries, show line numbers
alias -g RG='| xargs rg --line-number --column --smart-case'
# normal mfs
alias hex='_hex(){ printf "0x%x\n" $(($1)) }; _hex'
alias dec='_dec(){ printf "%d\n" $(($1)) }; _dec'
alias oct='_oct(){ printf "0o%o\n" $(($1)) }; _oct'
alias bin='_bin(){ echo "obase=2; $1" | bc | sed "s/^/0b/" }; _bin'
alias sc="sudo systemctl"
alias obsidian="obsidian --disable-gpu --proxy-server=socks5://192.168.42.129:9050"
alias pvi="proxychains -q nvim"
alias please="sudo"
alias uns="unset http_proxy https_proxy"
alias vi="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias chm="chmod +x"
alias py="python3"
alias ipy="ipython3"
alias sus="systemctl suspend"
alias y="yazi"
alias ghidra="export _JAVA_AWT_WM_NONREPARENTING=1 AWT_TOOLKIT=MToolkit; /usr/bin/ghidra "
alias chem="cd ~/al/chem/pap"
alias ph="cd ~/al/ph/pap"
alias cm="cd ~/al/cm/pap"
# alias mdwms="cd ~/dotfiles/suckless/dwmstatus; sudo make clean install; cd -"
# alias mdwm="cd ~/dotfiles/rice/dwm-flexipatch/; sudo make clean install; cd -"
alias mst="cd ~/dotfiles/st-flexipatch; sudo make clean install; cd -"
alias pav="pavucontrol"
alias neofetch="fastfetch --config examples/13.jsonc"
alias git="proxychains -q git"
alias gs="git status"
alias ga="git add ."
alias gd="git diff"
alias gp="git push -u origin main"
alias gall="ga; gc; gp"
alias p="proxychains -q" 
alias vizsh="vi ~/.zshrc" 
alias so="source ~/.zshrc" 
alias autorm="sudo pacman -Rns \$(pacman -Qdtq)"
alias tks="tmux kill-server"
alias ta="tmux attach"
alias t="tmux"
# alias copy="xclip -selection clipboard"
alias copy="wl-copy"
# alias ls="ls --color=auto --sort=version"
alias ls="eza --icons --grid --sort=name"
alias la="ls -lah"
alias lt="ls --tree"
alias ll="ls -l"
alias c="clear"
# alias vii3="$EDITOR ~/.config/i3/config"
alias viniri="$EDITOR ~/dotfiles/niri/.config/niri/config.kdl"
alias vivi="cd ~/dotfiles/nvim/.config/nvim/; vi ."

############################## STUFF #################################
burp() {
    local loader="/home/n00b/.tools/burp/BurpLoaderKeygen_v1.18.jar"
    local jar="/home/n00b/.tools/burp/burpsuite_pro_v2025.11.3/burpsuite_pro_v2025.11.3.jar"
    
    java --add-opens=java.desktop/javax.swing=ALL-UNNAMED \
         --add-opens=java.base/java.lang=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED \
         -javaagent:"$loader" -noverify -jar "$jar" "$@"
}

fs() {
  local file
  local line
  read -r file line <<< "$(rg --line-number --column --no-heading --color=always --smart-case "${*:-}" | fzf --ansi --delimiter : --preview 'bat --color=always --highlight-line {2} {1}' | awk -F: '{print $1, $2}')"
  [[ -n $file ]] && ${EDITOR:-vim} "+$line" "$file"
}

ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

i(){ yay -S --disable-download-timeout --needed "${@}"; }
s(){ yay -Ss "${@}"; }
u(){ yay -Rns "${@}"; }

tns() {
	if [[ $# -eq 0 ]]; then
		tmux new -s 'main'
	else
		tmux new -s "$1"
	fi
}
tat() {
	local session=$(tmux ls | fzf)
	[[ $session ]] && tmux a -t "${session%%:*}"
}

pullzsh(){ git -C ~/.zsh/plugins/fzf-tab pull; git -C ~/.zsh/plugins/zsh-completions pull }

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
  echo
  shutdown now
}

pipxa(){
  unset http_proxy https_proxy
  p pipx install "${@}" -v
  source ~/.zshrc
}

pipxu(){
  p pipx uninstall "${@}"
}

############################## KEYBINDS ##################################
bindkey -v  # vim mode

# Insert mode
bindkey -M viins '^f' autosuggest-accept
bindkey -M viins '^a' autosuggest-execute
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

# Change cursor shape for different vi modes
# zle-keymap-select() {
#   if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
#     echo -ne '\e[2 q' # Block
#   elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == "" ]] || [[ $1 = 'beam' ]]; then
#     echo -ne '\e[6 q' # Beam/Line
#   fi
# }
# zle -N zle-keymap-select
# _fix_cursor() { echo -ne '\e[6 q' } # Ensure beam on startup
# precmd_functions+=(_fix_cursor)

# Force a steady block cursor everywhere
# \e[2 q = steady block (use \e[1 q if you want it to blink)
_force_block_cursor() {
  echo -ne '\e[2 q'
}

# Apply on shell startup
_force_block_cursor

# Ensure it stays a block after every command
precmd_functions+=(_force_block_cursor)

# Override the Vi mode switch so it doesn't change the cursor
zle-keymap-select() {
  _force_block_cursor
}
zle -N zle-keymap-select

############################## MISC ###############################
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

clear-keep-buffer(){
  zle clear-screen
}
zle -N clear-keep-buffer
bindkey '^Al' clear-keep-buffer

copy-cmd(){
  echo -n $BUFFER | wl-copy
  zle -M "copied!"
}
zle -N copy-cmd
bindkey '^Y' copy-cmd

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg 2>/dev/null || zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# expand-alias-space() {
#   # Check if the word before the cursor is an alias
#   # This regex is more forgiving: [a-zA-Z0-9_-] covers most alias names
#   if [[ $LBUFFER =~ ' [a-zA-Z0-9_-]+$' ]]; then
#     zle _expand_alias
#   fi
#   zle self-insert
# }

# Register it as a Zle widget
# zle -N expand-alias-space
#
# # Bind it to BOTH Emacs and Vi-Insert maps
# bindkey -M emacs ' ' expand-alias-space
# bindkey -M viins ' ' expand-alias-space
#
# # Optional: If you want 'Enter' to also expand aliases before running
# bindkey -M viins '^M' _expand_alias

############################## HISTORY ###################################
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups \
			 hist_verify

############################## FZF-TAB SETTINGS ##########################
zstyle ':fzf-tab:*' fzf-flags --height=40% --border --layout=reverse
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group ',' '.'

# Group matches and describe categories
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' menu select
# Focus on the relevant part of the path
zstyle ':completion:*' expand yes
zstyle ':completion:*' squeeze-slashes yes

zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=01;31'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview \
  'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'

zstyle ':fzf-tab:complete:(cd|ls|eza):*' fzf-preview \
	'eza -1 --color=always --icons --group-directories-first $realpath'

zstyle ':fzf-tab:complete:*:*' fzf-preview '
	if [ -d $realpath ]; then
		eza --tree --color=always --level=2 --icons $realpath
	elif [ -f $realpath ]; then
		bat --color=always --style=numbers --line-range=:500 $realpath
	else
		echo "File not found"
	fi'

#from kali
# zstyle ':completion:*:*:*:*:*' menu select
# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' rehash true
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

############################## FZF INTEGRATION ###########################
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always --line-range :500 {} 2>/dev/null || eza --tree --level=2 --color=always {} 2>/dev/null'
  --preview-window 'right:60%:wrap'
"

export FZF_CTRL_R_OPTS="
  --preview 'echo {} | bat --language=sh --style=plain --color=always'
  --preview-window 'down:3:wrap'
"

export FZF_ALT_C_OPTS="
  --preview 'eza --tree --level=2 --color=always {}'
"

if [[ $- == *i* ]]; then
  eval "$(fzf --zsh)"
fi

eval "$(zoxide init --cmd cd zsh)"
source $ZSH_PLUGIN_DIR/powerlevel10k/powerlevel10k.zsh-theme
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# if [ -z "$NIRI_SOCKET" ] || [ ! -S "$NIRI_SOCKET" ]; then
#     ACTIVE_NIRI_SOCKET=$(ls -t /run/user/$(id -u)/niri.wayland-*.sock 2>/dev/null | head -n 1)
#     if [ -n "$ACTIVE_NIRI_SOCKET" ]; then
#         export NIRI_SOCKET="$ACTIVE_NIRI_SOCKET"
#     fi
# fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
