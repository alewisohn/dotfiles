# Homebrew installs an up-to-date Git completion definition outside the
# standard zsh function path. Other platforms use the completion bundled by
# their package manager and discovered by compinit.
if (( $+commands[brew] ))
then
  completion="$(brew --prefix)/share/zsh/site-functions/_git"
  if [[ -f "$completion" ]]
  then
    source "$completion"
  fi
fi

unset completion
