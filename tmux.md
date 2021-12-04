set -g default-terminal "screen-256color"
set -g prefix C-a
unbind C-b

#-- base --#
set -g display-time 3000
set -g history-limit 10000
set -g base-index 1
set -g pane-base-index 1
set -s escape-time 1
set -g mouse on

set -g status-keys vi
set -g visual-activity on
setw -g monitor-activity on
setw -g automatic-rename on

bind k selectp -U
bind j selectp -D
bind h selectp -L
bind l selectp -R
#############################################################

# 设置Shell
set-option -g default-shell /usr/bin/zsh

# 设置复制模式，空格开始选，Enter结束复制
setw -g mode-keys vi 
#开启status-bar uft-8支持
set -g status-utf8 on


#ruxvt标签式窗口切换
bind -n S-down new-window
bind -n S-left prev
bind -n S-right next
bind -n C-left swap-window -t -1 
bind -n C-right swap-window -t +1 # 切换panes
bind-key C-l last-pane

# 设置鼠标可以操作|滚动设置
# --> 使用shift键+鼠标键选择文件，Ctrl+Shift+C复制，Ctrl+Shift+V粘贴
# set -g mode-mouse on
# set -g mode-mouse off  # --> let cygwin mouse can be used.
# disable mouse control by default - change 'off' to 'on' to enable by default.
setw -g mode-mouse off
set-option -g mouse-resize-pane off
set-option -g mouse-select-pane off
set-option -g mouse-select-window off
# toggle mouse mode to allow mouse copy/paste
# set mouse on with prefix m
bind m \
    set -g mode-mouse on \;\
    set -g mouse-resize-pane on \;\
    set -g mouse-select-pane on \;\
    set -g mouse-select-window on \;\
    display 'Mouse: ON' # set mouse off with prefix M
    set -g mode-mouse off \;\
    set -g mouse-resize-pane off \;\
    set -g mouse-select-pane off \;\
    set -g mouse-select-window off \;\
    display 'Mouse: OFF' # 设置窗口可自动调整index
set -g renumber-windows on
# 复制和粘贴模式的快捷键
bind y copy-mode
bind c-y copy-mode
bind p paste-buffer
bind c-p paste-buffer
# Toggle log to file 
bind H pipe-pane -o 'cat >>$HOME/#W-tmux.log' '\;' display-message 'Toggled logging to $HOME/#W-tmux.log' 
bind h pipe-pane \; display-message 'Ended logging to $HOME/#W-tmux.log' # 设置窗口名字不能修改
set-option -g allow-rename off
# 设置启动窗口时默认名字
# bind-key c new-window -n 'zsh' # 设置r键为加载配置文件，并提示信息
bind r source-file ~/.tmux.conf \; display "配置文件已重新加载！" # other
setw -g xterm-keys on

#-- bindkeys --#
# split windows like vim. - Note: vim's definition of a horizontal/vertical split is reversed from tmux's
unbind s
bind s split-window -v
bind S split-window -v -l 40
bind v split-window -h
bind V split-window -h -l 120
# navigate panes nd h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
# key bindings for horizontal and vertical panes
unbind %
bind | split-window -h # 使用|竖屏，方便分屏
unbind '"'
bind - split-window -v # 使用-横屏，方便分屏
# swap panes
bind ^u swapp -U
bind ^d swapp -D
bind q killp
bind ^e last
unbind r
bind r source-file ~/.tmux.conf \; display "Configuration Reloaded!"
#-- statusbar --#
set -g status-justify centre
set -g status-left "#[fg=red]s#S:w#I.p#P#[default]"
set -g status-right '[#(whoami)#(date +" %m-%d %H:%M ")]'
set -g status-left-attr bright
set -g status-left-length 120
set -g status-right-length 120
set -g status-interval 1
setw -g automatic-rename off
# default statusbar colors
set -g status-bg colour235 #base02
set -g status-fg colour136 #yellow
set -g status-attr default
# default window title colors
setw -g window-status-fg colour244
setw -g window-status-bg default
#setw -g window-status-attr dim
# active window title colors
setw -g window-status-current-fg colour166 #orange
setw -g window-status-current-bg default
#setw -g window-status-current-attr bright
# window title string (uses statusbar variables)
set -g set-titles-string '#T'
set -g status-justify "centre"
set -g window-status-format '#I #W'
set -g window-status-current-format ' #I #W '
# pane border
set -g pane-active-border-fg '#55ff55'
set -g pane-border-fg '#555555'
# message text
set -g message-bg colour235 #base02
set -g message-fg colour166 #orange
# pane number display
set -g display-panes-active-colour colour33 #blue
set -g display-panes-colour colour166 #orange
# clock
setw -g clock-mode-colour colour64 #green

set-option -g status-left "#(~/path/to/tmux-powerline/powerline.sh left)"
set-option -g status-right "#(~/path/to/tmux-powerline/powerline.sh right)"
set-window-option -g window-status-current-format "#[fg=colour235, bg=colour27]⮀#[fg=colour255, bg=colour27] #I ⮁ #W #[fg=colour27, bg=colour235]⮀"






























