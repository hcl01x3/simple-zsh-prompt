# The prompt
PROMPT='%{$fg_bold[grey]%}%c %{$reset_color%}$(git_status)${prev_status}%{$reset_color%}'

local prev_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_NEED_TO_COMMIT="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_NEED_TO_ADD="%{$fg[red]%}✗%{$reset_color%}"


function git_status() {
  local branch=$(git branch --show-current 2> /dev/null)
  if [[ ! -z branch ]]; then
    local prompt="${ZSH_THEME_GIT_PROMPT_PREFIX}$branch"
    local needToAdd=$(git ls-files --modified --deleted --others 2> /dev/null | wc -l)

    if [[ $needToAdd -ne 0 ]]; then
      prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_NEED_TO_ADD} "
    else
      prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_CLEAN} "
    fi

    echo $prompt
  fi


  #if git log -1 > /dev/null 2>&1; then
  #  branch=$(git branch --show-current)
  #  local prompt="${ZSH_THEME_GIT_PROMPT_PREFIX}$branch"

  #  #git diff --quiet > /dev/null 2>&1
  #  #isDirty=$?

  #  #if [[ $isDirty -ne 0 ]]; then
  #  #  prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_NEED_TO_COMMIT} "
  #  if [[ $(git ls-files --modified --deleted --others 2> /dev/null | wc -l) -ne 0 ]]; then
  #    prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_NEED_TO_ADD} "
  #  else
  #    prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_CLEAN} "
  #  fi
  #  echo $prompt
  #fi
}
