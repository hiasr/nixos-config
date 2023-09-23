
{ pkgs, config, lib, ...} : 
{
    programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
            sensible
            yank
            resurrect
            continuum
            vim-tmux-navigator
            logging
            tmux-fzf
            catppuccin
        ];
        extraConfig = ''
# Change prefix from Ctrl+b to Alt+b
unbind C-b
set-option -g prefix M-b
bind-key M-b send-prefix

bind C-c new-session

# Set vim copy mode
setw -g mode-keys vi
unbind [
bind Escape copy-mode

# use vim-like keys for splits and windows
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind > swap-pane -D       # swap current pane with the next one
bind < swap-pane -U       # swap current pane with the previous one
bind x kill-pane

# fzf sessions
#bind S run-shell -b "~/.tmux/plugins/tmux-fzf/scripts/session.sh attach"

# window navigation
set -g base-index 1
set -g pane-base-index 1
unbind n
unbind p
bind -r C-h previous-window # select previous window
bind -r C-l next-window     # select next window
bind Tab last-window

# Shift Alt vim keys to switch windows
bind -n M-H previous-window
bind -n M-L next-window

# Otherwise neovim escape behaves weird
set -sg escape-time 0

# Restore neovim session
# set -g @continuum-restore 'on'
set -g @resurrect-strategy-nvim 'session'

# Fix colors
set -g default-terminal "screen-256color"
#set -ag terminal-overrides ",xterm-256color:RGB"

# Enable mouse
set -g mouse on
        '';
    };
}
