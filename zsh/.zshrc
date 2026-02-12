if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/n00b/scripts:/home/n00b/.local/bin:/home/n00b/.npm-global/bin:
export EDITOR=nvim
export NVIM_APPNAME=nvim

setopt correct
setopt autocd

############################## ALIASES ###################################
# lol
alias burp="java --add-opens=java.desktop/javax.swing=ALL-UNNAMED \
--add-opens=java.base/java.lang=ALL-UNNAMED \
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED \
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED \
--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED \
-javaagent:"/home/n00b/.tools/burp/BurpLoaderKeygen_v1.18.jar" -noverify -jar "/home/n00b/.tools/burp/burpsuite_pro_v2025.11.3/burpsuite_pro_v2025.11.3.jar"
"

# suffix aliases
alias -s md="bat"
alias -s png="qiv"
alias -s jpg="qiv"
# global aliases
alias -g NE="2>/dev/null"
alias -g C="| wl-copy"
# normal mfs
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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
	'[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'

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
# if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#         . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#         ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
#         ZSH_HIGHLIGHT_STYLES[default]=none
#         ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
#         ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
#         ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
#         ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[path]=bold
#         ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
#         ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
#         ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[command-substitution]=none
#         ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[process-substitution]=none
#         ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
#         ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
#         ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
#         ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
#         ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[assign]=none
#         ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
#         ZSH_HIGHLIGHT_STYLES[named-fd]=none
#         ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
#         ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
#         ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
#         ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
# 	fi

# if [ -z "$NIRI_SOCKET" ] || [ ! -S "$NIRI_SOCKET" ]; then
#     ACTIVE_NIRI_SOCKET=$(ls -t /run/user/$(id -u)/niri.wayland-*.sock 2>/dev/null | head -n 1)
#     if [ -n "$ACTIVE_NIRI_SOCKET" ]; then
#         export NIRI_SOCKET="$ACTIVE_NIRI_SOCKET"
#     fi
# fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
