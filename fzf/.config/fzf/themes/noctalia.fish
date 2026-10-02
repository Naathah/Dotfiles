set -l fzf_theme_opts "\
--color=bg+:#43474b
--color=bg:#131314
--color=spinner:#e4e2e3
--color=hl:#ffb4ab
--color=fg:#e4e2e3
--color=header:#ffb4ab
--color=info:#b6c9d9
--color=pointer:#e4e2e3
--color=marker:#c3c7cb
--color=fg+:#e4e2e3
--color=prompt:#b6c9d9
--color=hl+:#ffb4ab
--color=selected-bg:#43474b
--color=border:#43474b
--color=label:#e4e2e3"

if set -q FZF_DEFAULT_OPTS[1]; and test -n "$FZF_DEFAULT_OPTS"
    set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS
$fzf_theme_opts"
else
    set -Ux FZF_DEFAULT_OPTS "$fzf_theme_opts"
end
