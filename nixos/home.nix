{ pkgs, ... }: 

{
    imports = [
       ./terminal.nix 
    ];

    home = {
        packages = with pkgs; [
            btop
            git
        ];

        username = "minecraft-server";
        homeDirectory = "/home/minecraft-server";

        sessionVariables = {
            FLAKE = "/etc/nixos";
        };

        stateVersion = "24.05";
    };
}
