{
    description = "NixOS flake for a Minecraft server";

    # Include flakes from the internet
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05"; # Using a stable version to improve the reliability in a server environment
    };

    outputs = { self, nixpkgs }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };
}
