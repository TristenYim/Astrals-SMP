{ ... }:
let
    mkZfsMount = dataset: {
        device = "zroot/${dataset}";
        fsType = "zfs";
        neededForBoot = true;
    };
in
{
    swapDevices = [ ];

    networking.hostId = "1692dc66"; # A completely random, arbitrary ID for making ZFS work

    fileSystems = {
        "/" = { 
            device = "none";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [ "defaults" "size=500M" "mode=755" ];
        };

        "/boot" = { 
            device = "/dev/sda1";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
        };

        "/nix" = mkZfsMount "nix";

        "/pers" = mkZfsMount "persistent"; # A place for arbitrary persistent data

        "/srv/minecraft" = mkZfsMount "minecraft"; # Where the Minecraft server directories go
    };
}
