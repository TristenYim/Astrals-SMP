# Define host-specific configuration here.

{ ... }: 

{
    imports =
    [
        ../../nixos/default.nix # Import shared modules
        ./hardware-configuration.nix
        ./filesystem.nix
    ];

    networking.hostName = "mc-server-qemu"; # Define your hostname
}
