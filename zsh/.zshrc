# Dependencies: Bat, Eza, File, Fzf, Starship, Zoxide, Yazi (recomended terminal fm).

# Only auto-start Niri on login if we are on TTY1
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    # Export necessary Wayland environment variables
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland;xcb"

    # Launch Niri and suppress standard output noise
    exec niri-session > /dev/null 2>&1
fi

# Aliases
alias l='eza -lha --git --icons --total-size --group-directories-first'
alias la='eza -lha --git --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias ls='eza --icons --group-directories-first'
alias md="mkdir -pv"
alias e=zeditor
alias zdump='rm -f ~/.zcompdump ~/.zcompdump.zwc && exec zsh'
alias ql=qalc
alias weather="curl wttr.in/25.979281,88.064675"
alias age="echo $(( ( $(date +%s) - $(date -d "$(stat / | grep -oP 'Birth:\s+\K[^ ]+ [^ ]+')" +%s) ) / 86400 )) days old"
alias refont='fc-cache -fv'
alias pdf='file=$(find -type f -name "*.pdf" | fzf) && [ -n "$file" ] && zathura "$file" & disown'
# alias build="nh os switch && z -"
# alias update="nh os switch --update && z -"
# alias clean="nh clean all"
# alias config='editor "$NH_FLAKE/configuration.nix"'
alias clean="sudo pacman -Rcns $(pacman -Qdtq)"
alias ins="sudo pacman -S"
alias upd="sudo pacman -Syu"
alias rmv="sudo pacman -Rns"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups

# Keybindings
# bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region

# Exports
export PATH=$HOME/.local/bin:$PATH
export EDITOR=zeditor
export VISUAL=zeditor
# export NH_FLAKE="/etc/nixos/"

# fastfetch
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

autoload -Uz compinit
# local stale_cache=( ~/.zcompdump(Nmh+24) )
# if [[ ${#stale_cache} -gt 0 || ! -f ~/.zcompdump ]]; then
#     compinit -i  # The -i flag skips the slow security checks
#     touch ~/.zcompdump
# else
#     compinit -C -i
# fi
# [[ ~/.zcompdump -nt ~/.zcompdump.zwc ]] && (zcompile ~/.zcompdump &!)

# plugin manager
zsh_plugin_dir="$HOME/.zsh_plugins"
mkdir -p "$zsh_plugin_dir"

plugins=(
    "marlonrichert/zsh-autocomplete"
    "aloxaf/fzf-tab"
    "zsh-users/zsh-autosuggestions"
    "hcgraf/zsh-sudo"
    "zsh-users/zsh-syntax-highlighting"
)

local expected_plugins=()
for repo in "${plugins[@]}"; do
    expected_plugins+=("${repo:t}")
done

for dir in "$zsh_plugin_dir"/*(/N); do
    local dir_name="${dir:t}"
    if (( ! ${expected_plugins[(I)$dir_name]} )); then
        echo "removing deleted plugin: $dir_name..."
        rm -rf "$dir"
    fi
done

for repo in "${plugins[@]}"; do
    local plugin_name="${repo:t}"
    local plugin_path="$zsh_plugin_dir/$plugin_name"

    if [[ ! -d "$plugin_path" ]]; then
        echo "downloading $plugin_name..."
        git clone --quiet --depth 1 "https://github.com/$repo.git" "$plugin_path"
    fi

    local target_file=""
    if [[ -f "$plugin_path/$plugin_name.plugin.zsh" ]]; then
        target_file="$plugin_path/$plugin_name.plugin.zsh"
    elif [[ -f "$plugin_path/$plugin_name.zsh" ]]; then
        target_file="$plugin_path/$plugin_name.zsh"
    fi

    if [[ -n "$target_file" ]]; then
        if [[ ! -f "${target_file}.zwc" || "$target_file" -nt "${target_file}.zwc" ]]; then
            zcompile "$target_file"
        fi
        source "$target_file"
    fi
done


# tool configurations
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

f() {
    local selected
    selected=$(fzf -m --preview='bat --color=always {}')
    [[ -z "$selected" ]] && return
    local text_files=()
    local other_files=()
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        local mime
        mime=$(file -b --mime-type "$file")
        if [[ "$mime" == text/* || "$mime" == inode/x-empty || "$mime" == application/* ]]; then
            text_files+=("$file")
        else
            other_files+=("$file")
        fi
    done <<< "$selected"
    for file in "${other_files[@]}"; do
        if command -v xdg-open >/dev/null 2>&1; then
            (xdg-open "$file" </dev/null &> /dev/null &)
        elif command -v open >/dev/null 2>&1; then
            (open "$file" </dev/null &> /dev/null &)
        fi
    done
    if [[ ${#text_files[@]} -gt 0 ]]; then
        vis "${text_files[@]}" </dev/tty
    fi
}

mcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mcd <directory>"
    else
        mkdir -pv "$1" && cd "$1"
    fi
}

ex() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: ex <file1> [file2] [file3]..."
        return 1
    fi
    for archive in "$@"; do
        if [[ -f "$archive" ]]; then
            case "${archive:l}" in
                *.tar.bz2|*.tbz2) tar xjf "$archive"   ;;
                *.tar.gz|*.tgz)   tar xzf "$archive"   ;;
                *.tar.xz|*.txz)   tar xJf "$archive"   ;;
                *.tar.zst)        tar --zstd -xf "$archive" ;;
                *.bz2)            bunzip2 "$archive"   ;;
                *.gz)             gunzip "$archive"    ;;
                *.tar)            tar xf "$archive"    ;;
                *.rar)            unrar x "$archive" ;;
                *.zip|*.jar|*.cbz) unzip "$archive"  ;;
                *.7z)             7z x "$archive"    ;;
                ## *.rar)            nix run nixpkgs#unrar -c unrar x "$archive" ;;
                ## *.zip|*.jar|*.cbz) nix run nixpkgs#unzip -c unzip "$archive"  ;;
                ## *.7z)             nix run nixpkgs#p7zip -c 7z x "$archive"    ;;
                *)                echo "ex: '$archive' - unknown archive method" ;;
            esac
        else
            echo "ex: '$archive' is not a valid file"
        fi
    done
}

Fz() {
    qalc -t "normdist($1, 0, 1, 1)"
}

Fzi() {
    qalc -t "normdistinv($1, 0, 1)"
}

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

if [ -e /home/nath/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nath/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source ~/.config/fzf/themes/noctalia.sh
