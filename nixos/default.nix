# Import shared NixOS modules.

{ ... }: 

{
    imports =
    [
        ./system.nix
        ./nix-minecraft.nix
        ./utils.nix
    ];
}
