
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
# Change prefix from Ctrl+b to Alt+d
unbind C-b
set-option -g prefix M-Space
bind-key M-Space send-prefix

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
set-option -g renumber-windows on

bind-key -n C-1 select-window -t 1
bind-key -n C-2 select-window -t 2
bind-key -n C-3 select-window -t 3
bind-key -n C-4 select-window -t 4
bind-key -n C-5 select-window -t 5
bind-key -n C-6 select-window -t 6
bind-key -n C-7 select-window -t 7
bind-key -n C-8 select-window -t 8
bind-key -n C-9 select-window -t 9

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
set -g @continuum-restore 'on'
set -g @resurrect-strategy-nvim 'session'

# Autostart tmux on boot
set -g @continuum-boot 'on'

# Fix colors
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# Enable mouse
set -g mouse on
        '';
    };
}
