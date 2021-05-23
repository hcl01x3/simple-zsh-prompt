# The prompt
PROMPT='%{$fg_bold[grey]%}%c %{$reset_color%}$(git_status)${prev_status}%{$reset_color%}'

prev_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_NEED_TO_COMMIT="%{$fg_bold[yellow]%}⤒%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_NEED_TO_ADD="%{$fg_bold[red]%}±%{$reset_color%}"


function git_status() {
  local branch=$(git branch --show-current 2> /dev/null)
  if [[ $branch != "" ]]; then
    local prompt="${ZSH_THEME_GIT_PROMPT_PREFIX}$branch"
    local needToAdd=$(git ls-files --modified --deleted --others --exclude-standard $(git rev-parse --show-toplevel) 2> /dev/null | wc -l)

    if [[ $needToAdd -ne 0 ]]; then
      prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_NEED_TO_ADD} "
    elif ! git diff HEAD --quiet > /dev/null 2>&1; then
      prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_NEED_TO_COMMIT} "
    else
      prompt="${prompt} ${ZSH_THEME_GIT_PROMPT_CLEAN} "
    fi

    echo $prompt
  fi
}
