# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.fzf/shell/key-bindings.zsh"
# Customization
# -----------
#

fzfopts() {
  if [ "$COLORFGBG" = "0;15" ]; then
    export FZF_DEFAULT_OPTS='--color light'
  else
    export FZF_DEFAULT_OPTS='--color dark'
  fi
}
#export FZF_DEFAULT_OPTS='--color light'
#export FZF_DEFAULT_OPTS='--color dark'
## dark(onehalfdark)
#export FZF_DEFAULT_OPTS='--color=bg+:#313640,bg:#282c34,border:#dcdfe4,spinner:#c678dd,hl:#5c6370,fg:#dcdfe4,header:#5c6370,info:#e5c07b,pointer:#c678dd,marker:#e06c75,fg+:#dcdfe4,preview-bg:#282c34,prompt:#c678dd,hl+:#c678dd'
## light(onehalflight)
#export FZF_DEFAULT_OPTS='--color=bg+:#f0f0f0,bg:#fafafa,border:#383a42,spinner:#a626a4,hl:#a0a1a7,fg:#383a42,header:#a0a1a7,info:#c18401,pointer:#a626a4,marker:#e45649,fg+:#383a42,preview-bg:#fafafa,prompt:#a626a4,hl+:#a626a4'

fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
#fz() {
#  local dir
#  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
#}
fz() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

fv() {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}


# http://blog.b4b4r07.com/entry/2015/11/08/013526
export ONELINER_FILE=$HOME/dotfiles/oneliner.txt

exec-oneliner() {
    local oneliner_f
    oneliner_f="$HOME/.command.list"

    [[ ! -f $oneliner_f || ! -s $oneliner_f ]] && return

    local cmd q k res accept
    while accept=0; cmd="$(
        cat $oneliner_f $ONELINER_FILE \
            | sed -e '/^#/d;/^$/d' \
            | perl -pe 's/^(\[.*?\]) (.*)$/$1\t$2/' \
            | perl -pe 's/(\[.*?\])/\033[31m$1\033[m/' \
            | perl -pe 's/^(: ?)(.*)$/$1\033[30;47;1m$2\033[m/' \
            | perl -pe 's/^(.*)([[:blank:]]#[[:blank:]]?.*)$/$1\033[30;1m$2\033[m/' \
            | perl -pe 's/(!)/\033[31;1m$1\033[m/' \
            | perl -pe 's/(\|| [A-Z]+ [A-Z]+| [A-Z]+ )/\033[35;1m$1\033[m/g' \
            | fzf --ansi --multi --no-sort --tac --query="$q" \
            --print-query --expect=ctrl-v --exit-0
            )"; do
        q="$(head -1 <<< "$cmd")"
        k="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d;s/[[:blank:]]#.*$//' <<< "$cmd")"
        [ -z "$res" ] && continue
        if [ "$k" = "ctrl-v" ]; then
            vim "$oneliner_f" < /dev/tty > /dev/tty
        else
            cmd="$(perl -pe 's/^(\[.*?\])\t(.*)$/$2/' <<<"$res")"
            if [[ $cmd =~ "!$" || $cmd =~ "! *#.*$" ]]; then
                accept=1
                cmd="$(sed -e 's/!.*$//' <<<"$cmd")"
            fi
            break
        fi
    done

    local len
    if [[ -n $cmd ]]; then
        BUFFER="$(tr -d '@' <<<"$cmd" | perl -pe 's/\n/; /' | sed -e 's/; $//')"
        len="${cmd%%@*}"
        CURSOR=${#len}
        if [[ $accept -eq 1 ]]; then
            zle accept-line
        fi
    fi
    #zle reset-prompt
    zle redisplay
}
zle -N exec-oneliner
bindkey '^x^x' exec-oneliner
