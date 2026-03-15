# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" # starship
eval "$(starship init bash)"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"
alias vim='nvim'
alias py='python3'
alias ls='eza --icons'
alias asr='atuin scripts run'

bind 'set bell-style none'
neofetch

# Created by `pipx` on 2025-02-13 17:41:43
export ANDROID_HOME="/home/deval/Android/Sdk"
export JAVA_HOME="/usr/lib/jvm/java-23-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$ANDROID_HOME/emulator/emulator"
export PATH="$PATH:$ANDROID_HOME/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/build-tools"
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

# Alias
alias emulator="$ANDROID_HOME/emulator/emulator"
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
