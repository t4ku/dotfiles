#!/bin/sh

# Copyright (c) 2012 Juan Ignacio Pumarino, jipumarino@gmail.com
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Instructions
# ------------
#
# 1. Install this script and give it execute permission somewhere in your PATH.
#    For example:
#
#    $ mkdir -p ~/bin
#    $ wget https://raw.github.com/jipumarino/tmux-zoom/master/tmux-zoom.sh -O ~/bin/tmux-zoom.sh
#    $ chmod +x ~/bin/tmux-zoom.sh
# 
# 2. Add a shortcut in your ~/.tmux.conf file:
#
#    bind C-k run "tmux-zoom.sh"
#
# 3. When using this shortcut, the current tmux pane will open in a new window by itself.
#    Running it again in the zoomed window will return it to its original pane. You can have
#    as many zoomed windows as you want.

set -u

current_name=$(tmux display-message -p '#W')
current_window=$(tmux display-message -p '#I')
current_pane=$(tmux display-message -p '#P')
new_zoom_window="ZOOM-$current_window-$current_pane"

case "$current_name" in
ZOOM-*)
	if [ "$(tmux list-panes | wc -l)" -gt 1 ]; then
		tmux display-message "other panes exist"
		exit 0
	fi
	eval $(echo "$current_name" | sed 's/^.*\([0-9][0-9]*\)-\([0-9][0-9]*\)$/orig_window=\1;orig_pane=\2/')
	tmux select-window -t "$orig_window" \; select-pane -t "$orig_pane" \; swap-pane -s "$current_window.$current_pane" \; rename-window -t "$current_window" "zoom-$orig_window-$orig_pane" \; kill-pane -t "$current_window.$current_pane"
	exit 0
	;;
esac

case "$(tmux list-windows)" in
*$new_zoom_window*)
	tmux select-window -t $new_zoom_window
	exit 0
	;;
esac

if [ "$(tmux list-panes | wc -l)" -eq 1 ]; then
	tmux display-message "already zoomed"
	exit 0
fi

tmux new-window -d -n $new_zoom_window \; send-keys -t $new_zoom_window.0 ": ZOOM on $new_zoom_window..." Enter \; swap-pane -s $new_zoom_window.0 \; select-window -t $new_zoom_window
exit 0
