{ ... }:
let
    # Makes ZFS dataset mountpoints
    mkZfsMount = dataset: {
        device = "zroot/${dataset}";
        fsType = "zfs";
        neededForBoot = true;
    };
in
{
    swapDevices = [ ];

    networking.hostId = "1e53be76"; # A completely random, arbitrary ID for making ZFS work

    fileSystems = {
        "/" = { 
            device = "none";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [ "defaults" "size=500M" "mode=755" ];
        };

        "/boot" = { 
            device = "/dev/disk/by-uuid/37C8-9B10";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
        };

        "/nix" = mkZfsMount "nix";

        "/pers" = mkZfsMount "persistent"; # A place for arbitrary persistent data

        "/srv/minecraft" = mkZfsMount "minecraft"; # Where the Minecraft server directories go
    };

    # Files and directories which should persist between reboots
    environment.persistence."/pers" = {
        directories = [
            "/etc/nixos" # NixOS configuration
            "/var/lib/nixos" # Important NixOS cache

            "/etc/ssh" # ssh host information
            "/var/log" # System logs
            "/var/lib/systemd/coredump" # Systemd coredump logs
        ];

        files = [
            "/etc/machine-id" # Public machine ID
        ];

        users.starry-sysadmin = {
            directories = [
                ".ssh" # ssh user information
            ];
            files = [
                ".zsh_history" # Command history
            ];
        };
    };
}
