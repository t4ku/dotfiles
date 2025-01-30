#!/usr/bin/env zsh

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# if homebrew installed mysql-client exists, lanaguage specific 
# binding may need to set these flags
# if [ -d /opt/homebrew/opt/mysql-client ]; then
#   export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
#   export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
#   # export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
# fi

# uv
export PATH="$HOME/.local/share/../bin:$PATH"
