{
    description = "NixOS flake for a Minecraft server";

    # Include flakes from the internet
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05"; # Using a stable version to improve the reliability in a server environment
        home-manager = {
            type = "git";
            url = "https://github.com/nix-community/home-manager";
            ref = "release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-minecraft = {
            url = "github:Infinidoge/nix-minecraft";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nix-minecraft }: 
    let
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-minecraft.overlay ];
            config.allowUnfree = true;
        };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit pkgs;

            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                nix-minecraft.nixosModules.minecraft-servers

                # Home Manager managers userspace packages and configurations
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        
                        users.minecraft-server.imports = [ ./home.nix ];
                    };
                }
            ];
        };
    };
}
