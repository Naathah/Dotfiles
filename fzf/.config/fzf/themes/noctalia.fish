set -l fzf_theme_opts "\
--color=bg+:#42474d
--color=bg:#121316
--color=spinner:#e2e2e5
--color=hl:#ffb4ab
--color=fg:#e2e2e5
--color=header:#ffb4ab
--color=info:#a7caed
--color=pointer:#e2e2e5
--color=marker:#c2c7ce
--color=fg+:#e2e2e5
--color=prompt:#a7caed
--color=hl+:#ffb4ab
--color=selected-bg:#42474d
--color=border:#42474d
--color=label:#e2e2e5"

if set -q FZF_DEFAULT_OPTS[1]; and test -n "$FZF_DEFAULT_OPTS"
    set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS
$fzf_theme_opts"
else
    set -Ux FZF_DEFAULT_OPTS "$fzf_theme_opts"
end
