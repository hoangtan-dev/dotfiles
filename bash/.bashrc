# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" # starship
eval "$(starship init bash)"

# Aliases
alias vim='nvim'
alias py='python3'
alias ls='eza --icons'
alias asr='atuin scripts run'
alias gst='git status'

bind 'set bell-style none'
neofetch

# Created by `pipx` on 2025-02-13 17:41:43
export JAVA_HOME="/usr/lib/jvm/java-23-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/home/deval/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

eval "$(fzf --bash)"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,.env,.venv
  --preview 'tree -C {}'"

eval "$(uv generate-shell-completion bash)"

# Zoxide
eval "$(zoxide init bash --cmd cd)"

sesh_sessions() {
  local session
  session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  [[ -z "$session" ]] && return
  sesh connect "$session"
}

# Bind Alt+S to run sesh_sessions
bind -x '"\es":sesh_sessions'
. "$HOME/.cargo/env"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

# Load all .bash files from plugins directory
if [[ -d "$HOME/dotfiles/bash/plugins" ]]; then
  for plugin in "$HOME/dotfiles/bash/plugins"/*.bash; do
    [[ -f "$plugin" ]] && source "$plugin"
  done
fi

# Vim mode
set -o vi
