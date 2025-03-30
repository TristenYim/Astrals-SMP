# Define nix-minecraft options.
# See https://github.com/Infinidoge/nix-minecraft for information about configuring.

{ pkgs, ... }:

{
    services.minecraft-servers = {
        enable = true;
        eula = true; # Accepting the EULA is required

        servers = {
            Astrals-SMP = let
                modpack = pkgs.fetchPackwizModpack {
                    url = "https://raw.githubusercontent.com/TristenYim/Astrals-SMP/refs/heads/master/Astrals-SMP-Full/pack.toml";
                    packHash = "sha256-xqMAzEU0Y3Mr/Cc5jo2Tr3HLlA4ZHtsNrtJjjqNWMDo=";
                    side = "both";
                };
            in {
                enable = true;

                # Define the server jar version.
                package = pkgs.fabricServers.fabric-1_20_1.override { loaderVersion = "0.16.0"; };

                symlinks = {
                    "mods" = "${modpack}/mods";
                };

                # This option opens up the firewall, allowing users from the local network (or global network if port forwarding is configured) to connect. Be careful!
                # openFirewall = true;
            };
        };
    };
}
