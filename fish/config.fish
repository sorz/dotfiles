if status is-interactive
    # Sync history across sessions
    # https://github.com/fish-shell/fish-shell/issues/825
    bind \e\[A 'history merge; up-or-search'

    # Abbr
    if command -q systemctl
        abbr -a sys sudo systemctl
        abbr -a syses sudo systemctl enable --now
        abbr -a sysds sudo systemctl disable --now
        abbr -a sysed sudo systemctl edit
        abbr -a sysdr sudo systemctl daemon-reload
        abbr -a log journalctl -u
    end
    abbr -a json python3 -m json.tool --no-ensure-ascii

    # Editor
    if command -q nvim
        alias vim=nvim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end
    if command -q helix
        alias hx=helix
        set -gx EDITOR helix
    end

    # WSL
    if uname -a | string match -eq WSL2
        alias dropcache='echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null'
    end
end
