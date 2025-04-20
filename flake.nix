# Flakes ensure that not only are the same packages installed
# whenever the configuration is rebuilt, the same versions of
# each package is installed regardless of when the configuration
# was rebuilt.

{
    description = "NixOS flake for a Minecraft server";

    # Import external flakes
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11"; # Using a stable version to improve the reliability in a server environment

        # Enables keeping files between reboots
        impermanence.url = "github:nix-community/impermanence";

        # Manages userspace packages and configurations
        home-manager = {
            type = "git";
            url = "https://github.com/nix-community/home-manager";
            ref = "release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Makes configuring Minecraft with Nix language far easier
        nix-minecraft = {
            url = "github:Infinidoge/nix-minecraft";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, impermanence, nix-minecraft}: 
    let
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-minecraft.overlay ];
            config.allowUnfree = true;
        };
    in
    {
        # This host is setup for testing inside a QEMU VM
        nixosConfigurations.mc-server-qemu = nixpkgs.lib.nixosSystem {
            inherit pkgs;

            system = "x86_64-linux";
            modules = [
                # Import system configuration
                ./hosts/mc-server-qemu/configuration.nix
                nix-minecraft.nixosModules.minecraft-servers

                # Import home-manager configuration
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        
                        users.starry-sysadmin.imports = [ ./home-manager/home.nix ];
                    };
                }
            ];
        };

        nixosConfigurations.astrals-oracle = nixpkgs.lib.nixosSystem {
            pkgs = import nixpkgs {
                system = "aarch64-linux";
                overlays = [ nix-minecraft.overlay ];
                config.allowUnfree = true;
            };

            system = "aarch64-linux";
            modules = [
                # Import system configuration
                ./hosts/astrals-oracle/configuration.nix
                nix-minecraft.nixosModules.minecraft-servers
                impermanence.nixosModules.impermanence

                # Import home-manager configuration
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        
                        users.starry-sysadmin.imports = [ ./home-manager/home.nix ];
                    };
                }
            ];
        };
    };
}
