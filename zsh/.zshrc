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
export CLANGD_FLAGS="--fallback-style=LLVM"
eval "$(batman --export-env)"
declare -x http_proxy=socks5h://192.168.42.129:9050
declare -x https_proxy=socks5h://192.168.42.129:9050
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/n00b/scripts:/home/n00b/.local/bin:/home/n00b/.npm-global/bin:
export EDITOR=nvim
export NVIM_APPNAME=nvim
setopt correct

############################## ALIASES ###################################
# suffix aliases
alias -s md="bat"
alias -s png="qiv"
alias -s jpg="qiv"
# global aliases
alias -g NE="2>/dev/null"
alias -g C="| wl-copy"
# normal mfs
alias pvi="proxychains -q nvim"
alias please="sudo"
alias uns="unset http_proxy https_proxy"
alias wf="waterfox"
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
# alias mst="cd ~/dotfiles/rice/st; sudo make clean install; cd -"
alias pav="pavucontrol"
alias neofetch="fastfetch --config examples/13.jsonc"
alias git="proxychains -q git"
alias gs="git status"
alias ga="git add ."
alias gp="git push -u origin main"
alias gall="ga; gc; gp"
alias p="proxychains -q" 
alias vizsh="vi ~/.zshrc" 
alias so="source ~/.zshrc" 
alias cleanup="sudo pacman -Rns \$(pacman -Qdtq)"
alias tns="tmux new -s 'main'"
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
i(){ yay -S --needed "${@}"; }
s(){ yay -Ss "${@}"; }
u(){ yay -R "${@}"; }

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
HISTSIZE=10000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

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

############################## FZF INTEGRATION ###########################
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
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
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh