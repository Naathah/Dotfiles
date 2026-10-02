fzf_theme_opts="\
--color=bg+:#454842
--color=bg:#131313
--color=spinner:#e5e2e0
--color=hl:#ffb4ab
--color=fg:#e5e2e0
--color=header:#ffb4ab
--color=info:#c3c8be
--color=pointer:#e5e2e0
--color=marker:#c5c7c0
--color=fg+:#e5e2e0
--color=prompt:#c3c8be
--color=hl+:#ffb4ab
--color=selected-bg:#454842
--color=border:#454842
--color=label:#e5e2e0"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS
}$fzf_theme_opts"
