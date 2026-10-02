fzf_theme_opts="\
--color=bg+:#45474b
--color=bg:#141313
--color=spinner:#e5e2e1
--color=hl:#ffb4ab
--color=fg:#e5e2e1
--color=header:#ffb4ab
--color=info:#c6c6cb
--color=pointer:#e5e2e1
--color=marker:#c6c6cb
--color=fg+:#e5e2e1
--color=prompt:#c6c6cb
--color=hl+:#ffb4ab
--color=selected-bg:#45474b
--color=border:#45474b
--color=label:#e5e2e1"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS
}$fzf_theme_opts"
