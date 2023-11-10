export DIP_SHELL=1
export DIP_EARLY_ENVS=SHELL,SESSION_MANAGER,QT_ACCESSIBILITY,COLORTERM,XDG_CONFIG_DIRS,SSH_AGENT_LAUNCHER,XDG_MENU_PREFIX,TERM_PROGRAM_VERSION,GNOME_DESKTOP_SESSION_ID,GTK_IM_MODULE,GNOME_SHELL_SESSION_MODE,SSH_AUTH_SOCK,XMODIFIERS,HOMEBREW_PREFIX,DESKTOP_SESSION,GTK_MODULES,RUBY_VERSION,PWD,XDG_SESSION_DESKTOP,LOGNAME,XDG_SESSION_TYPE,MANPATH,GEM_ROOT,GPG_AGENT_INFO,SYSTEMD_EXEC_PID,XAUTHORITY,VSCODE_GIT_ASKPASS_NODE,GJS_DEBUG_TOPICS,WINDOWPATH,HOME,USERNAME,LANG,LS_COLORS,XDG_CURRENT_DESKTOP,RUBY_ENGINE,GIT_ASKPASS,INVOCATION_ID,MANAGERPID,CHROME_DESKTOP,INFOPATH,GJS_DEBUG_OUTPUT,VSCODE_GIT_ASKPASS_EXTRA_ARGS,GEM_PATH,GEM_HOME,LESSCLOSE,XDG_SESSION_CLASS,TERM,LESSOPEN,USER,VSCODE_GIT_IPC_HANDLE,HOMEBREW_CELLAR,DISPLAY,SHLVL,QT_IM_MODULE,HOMEBREW_REPOSITORY,XDG_RUNTIME_DIR,VSCODE_GIT_ASKPASS_MAIN,JOURNAL_STREAM,RUBY_ROOT,XDG_DATA_DIRS,GDK_BACKEND,PATH,GDMSESSION,ORIGINAL_XDG_CURRENT_DESKTOP,DBUS_SESSION_BUS_ADDRESS,GIO_LAUNCHED_DESKTOP_FILE_PID,RUBYOPT,GIO_LAUNCHED_DESKTOP_FILE,TERM_PROGRAM,_
export DIP_PROMPT_TEXT="ⅆ"

function dip_clear() {
  # just stub, will be redefined after injecting aliases
  true
}

function dip_inject() {
  eval "$(dip console inject)"
}

function dip_reload() {
  dip_clear
  dip_inject
}

# Inspired by RVM
function __zsh_like_cd() {
  \typeset __zsh_like_cd_hook
  if
    builtin "$@"
  then
    for __zsh_like_cd_hook in chpwd "${chpwd_functions[@]}"
    do
      if \typeset -f "$__zsh_like_cd_hook" >/dev/null 2>&1
      then "$__zsh_like_cd_hook" || break # finish on first failed hook
      fi
    done
    true
  else
    return $?
  fi
}

[[ -n "${ZSH_VERSION:-}" ]] ||
{
  function cd()    { __zsh_like_cd cd    "$@" ; }
  function popd()  { __zsh_like_cd popd  "$@" ; }
  function pushd() { __zsh_like_cd pushd "$@" ; }
}

export -a chpwd_functions
[[ " ${chpwd_functions[*]} " == *" dip_reload "* ]] || chpwd_functions+=(dip_reload)

if [[ "$ZSH_THEME" = "agnoster" ]]; then
  eval "`declare -f prompt_end | sed '1s/.*/_&/'`"

  function prompt_end() {
    if [[ -n $DIP_PROMPT_TEXT ]]; then
      prompt_segment magenta white "$DIP_PROMPT_TEXT"
    fi

    _prompt_end
  }
fi

dip_reload
