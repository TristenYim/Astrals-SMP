# Define basic home manager settings here.

{ pkgs, ... }: 

{
    imports = [
       ./terminal.nix 
    ];

    home = {
        # Some useful utilities
        packages = with pkgs; [
            btop
        ];

        username = "starry-sysadmin";
        homeDirectory = "/home/starry-sysadmin";

        # Helpful for cding to the config and making rebuild aliases
        sessionVariables = {
            FLAKE = "/etc/nixos";
        };

        stateVersion = "24.11";
    };

    # Git configuration
    programs.git = {
        enable = true;
        extraConfig = {
            "safe" = {
                directory = "/etc/nixos";
            };
        };
    };
}
