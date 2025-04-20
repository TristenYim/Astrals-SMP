# Add useful system utilities here!

{ pkgs, ... }: 

{
    # Enables the Zsh interactive shell
    programs.zsh.enable = true;

    # Enable the OpenSSH daemon
    services.openssh = {
        enable = true;

        # Disable password authentication since passwords are less secure than keys
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
        };
    };

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [
        ranger # Curses TUI file manager with similar keybindings to Vim
        tmux # Allows for connecting to the server console
    ];
}
