{ config, pkgs, ... }: 

{
    environment.systemPackages = with pkgs; [
        ranger # Include ranger, a curses TUI file manager with similar keybindings to Vim
        git # Include git to sync the configuration and modpack
    ];
}
