fzf_theme_opts="\
--color=bg+:#42474e
--color=bg:#121316
--color=spinner:#e2e2e6
--color=hl:#ffb4ab
--color=fg:#e2e2e6
--color=header:#ffb4ab
--color=info:#a2caf7
--color=pointer:#e2e2e6
--color=marker:#c2c7cf
--color=fg+:#e2e2e6
--color=prompt:#a2caf7
--color=hl+:#ffb4ab
--color=selected-bg:#42474e
--color=border:#42474e
--color=label:#e2e2e6"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS
}$fzf_theme_opts"
