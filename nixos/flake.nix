{
    description = "NixOS flake for a Minecraft server";

    # Include flakes from the internet
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05"; # Using a stable version to improve the reliability in a server environment
        nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    };

    outputs = { self, nixpkgs, nix-minecraft }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                system = "x86_64-linux";
                overlays = [ nix-minecraft.overlay ];
                config.allowUnfree = true;
            };
            modules = [
                ./configuration.nix
                nix-minecraft.nixosModules.minecraft-servers
            ];
        };
    };
}
