{ ... }: 

{
    programs = {
        # Lazygit is a git TUI, far improved from the CLI
        lazygit.enable = true;

        # Zsh as an interactive shell offers many niceties over bash
        zsh = {
            enable = true;
    
            # Highlights the command that will be completed
            autosuggestion = {
                enable = true;
                # strategy = [ "completion" ];
            };
    
            # Allows jumping using shift-tab like in bash
            initExtra = ''
                bindkey "^[[1;5D" backward-word
                bindkey "^[[1;5C" forward-word
                bindkey "^H" backward-kill-word
                bindkey "^[^?" backward-kill-word
            '';
        };
    };

    # Useful aliases
    home.shellAliases = {
        sudo = "sudo ";
        nrb = "nixos-rebuild boot --flake $FLAKE";
        nrs = "nixos-rebuild switch --flake $FLAKE";
        nrt = "nixos-rebuild test --flake $FLAKE";
        ngl = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
        ngd = "nix-env --delete-generations --profile /nix/var/nix/profiles/system";
    };
}
