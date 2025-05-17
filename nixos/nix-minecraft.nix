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
                    packHash = "COwINVg9h6HR4WFIrRMKXGruqUWsqp/cVSK93DIrrQU=";
                };
            in {
                enable = true;

                # Define the server jar version.
                package = pkgs.fabricServers.fabric-1_20_1;

                symlinks = {
                    "mods" = "${modpack}/mods";
                };

                files = {
                    "config" = "${modpack}/config";
                };

                # This option opens up the firewall, allowing users from the local network (or global network if port forwarding is configured) to connect. Be careful!
                openFirewall = true;
            };
        };
    };
}
