# Define host-specific configuration here.

{ lib, ... }:

{
    imports = [ 
        ../../nixos/default.nix
        ./hardware-configuration.nix
        ./filesystem.nix
    ];

    boot.kernelParams = [ "net.ifnames=0" ]; # Make it use predictable interface names starting with eth0

    networking = {
        hostName = "astrals-oracle"; # Define your hostname

        # Manually configure networking information
        defaultGateway = "10.0.0.1";

        nameservers = [ "9.9.9.9" "9.9.9.11" ];

        interfaces.eth0.ipv4.addresses = [
            {
                address = "10.0.0.34";
                prefixLength = 24;
            }
        ];

        firewall.allowedTCPPorts = [ 22 ]; # Open the SSH port

        networkmanager.enable = lib.mkForce false; # NetworkManager interferes with our manual configuration
    };

    users.users.starry-sysadmin = {
        # Set the password to something stronger than 123456
        initialPassword = lib.mkForce null;
        initialHashedPassword = "$y$j9T$SvoT2vWkVltyTJ5TAo7.N1$uxTe7z1itMHZgxhNGNbak/MxvhuDs/T2iO9tHfxlze3";

        # Allow authorized users to connect
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEDI5uQnw4iNsCUwB6vigqtN3KSl8zIsRmFPQXu0WA6I"
        ];
    };
}
