#!/usr/bin/env zsh

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
#eval "$(anyenv init -)"
eval "$(mise activate zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/t_okawa/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/t_okawa/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/t_okawa/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/t_okawa/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


# History settings
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

# Ensure history directory exists
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"


setopt EXTENDED_HISTORY       # Saves timestamp and duration
setopt HIST_IGNORE_ALL_DUPS  # Keeps history clean of duplicates
setopt HIST_IGNORE_SPACE     # Doesn't save commands starting with space
setopt INC_APPEND_HISTORY    # Saves commands immediately
setopt SHARE_HISTORY         # Shares history across sessions

# this also fix control key related shortcuts(like ctrl-a/e) doesn't work propery
# in tmux
# c.f https://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e
# https://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e
bindkey -e


######################################
# fzf setup
######################################

if type brew &>/dev/null; then
  if [[ -d $(brew --prefix)/opt/fzf ]]; then
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --zsh)"
  fi
fi

# Base fzf configuration - no preview to keep it simple and fast
# export FZF_DEFAULT_OPTS="
#   --height 40% 
#   --layout=reverse 
#   --border
#   --prompt='❯ '
#   --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
#   --info=inline
#   --multi
#   --bind '?:toggle-preview'
#   --bind 'ctrl-a:select-all'
#   --bind 'ctrl-e:deselect-all'
#   --bind 'ctrl-t:toggle-all'
# "

# CTRL-T - Paste the selected files and directories onto the command-line
export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="
  --preview='head -n 100 {}'
  --preview-window='right:hidden:wrap'
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-x:execute-silent(echo -n {+} | pbcopy)'
"

# CTRL-R - Paste the selected command from history onto the command-line
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window=down:3:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"

# ALT-C - cd into the selected directory
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="
  --preview='tree -C {} | head -100'
  --bind='ctrl-/:toggle-preview'
"

function fzf_aws_ecs_exec() {
  zparseopts -D -E -A opthash -- -profile:

  local profile="${opthash[--profile]}"
  local query="$*"
  local selections
  local clusters services tasks containers

  # cluster > service > taskdef > taskid > container
  clusters=`aws --profile ${profile} ecs list-clusters --no-paginate | jq -r '.clusterArns[]' | sort | cut -d '/' -f 2`
  clusters=(`echo ${clusters}`)
  for cluster in "${clusters[@]}"; do
    # echo "cluster: ${cluster}"
    services=`aws --profile ${profile} ecs list-services --no-paginate --cluster ${cluster} | jq -r '.serviceArns[]' | sort | cut -d '/' -f 3`
    services=(`echo ${services}`)
    for service in "${services[@]}"; do
      # echo "service: ${service}"
      tasks=`aws --profile ${profile} ecs list-tasks --no-paginate --cluster ${cluster} --service-name ${service} | jq -r '.taskArns[]' | sort | cut -d '/' -f 3`
      tasks=(`echo ${tasks}`)
      for task in "${tasks[@]}"; do
        # echo "task: ${task}"
        containers=`aws --profile ${profile} ecs describe-tasks --no-paginate --cluster ${cluster} --tasks ${task} | jq -r '.tasks[].containers[].name' | sort`
        containers=(`echo ${containers}`)
        for container in "${containers[@]}"; do
          selections+="${cluster}/${service}/${task}/${container}\n"
        done
      done
    done
  done

  local selected=`echo -n ${selections} | sort | fzf --query "${query}" | tr '/' '\n'`
  if [ -z $selected ]; then
    return 0
  fi

  selected=(`echo ${selected}`)
  print -z "aws --profile ${profile} ecs execute-command --cluster ${selected[1]} --task ${selected[3]} --container ${selected[4]} --interactive --command '/bin/bash'"
}

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbrm - checkout git branch (including remote branches)
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/origin/##")
}

alias aee=fzf_aws_ecs_exec

fssh() {
  SSH_ID=`aws ec2 describe-instances --query 'Reservations[].Instances[].{InstanceId:InstanceId,Name:Tags[?Key==\`Name\`].Value}' |
  jq -c '.[] | { name: .Name[0], id: .InstanceId}' | sort | fzf | jq -r '.id'`
  ssh ${SSH_ID}
}

fsst() {
  SSH_ID=`aws ec2 describe-instances --query 'Reservations[].Instances[].{InstanceId:InstanceId,Name:Tags[?Key==\`Name\`].Value}' |
  jq -c '.[] | { name: .Name[0], id: .InstanceId}' | sort | fzf | jq -r '.id'`
  aws ec2 start-instances --instance-ids ${SSH_ID}
}


alias aider='/Users/t_okawa/.local/share/mise/installs/python/3.12.9/bin/aider'

# completion
# TODO: add zsh completion
# fpath=($HOME/dotfiles/zsh/completion $fpath)
autoload -U compinit && compinit

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/t_okawa/.config/.dart-cli-completion/zsh-config.zsh ]] && . /Users/t_okawa/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# pnpm
export PNPM_HOME="/Users/t_okawa/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
