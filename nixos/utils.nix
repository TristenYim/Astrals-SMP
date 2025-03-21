# Add useful system utilities here!

{ pkgs, ... }: 

{
    environment.systemPackages = with pkgs; [
        ranger # Curses TUI file manager with similar keybindings to Vim
    ];
}
