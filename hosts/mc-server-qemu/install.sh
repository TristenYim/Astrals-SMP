#!/usr/bin/env bash

main() {
    exit_if_not_sudo
    warn_user

    read -p " ?] " choice
    if [ "$choice" == "Yes, do as I say!" ]; then
        install
    else
        printf "\nAborting install..."
    fi
}

exit_if_not_sudo() {
    if [[ $(/usr/bin/env id -u) != 0 ]]; then
        echo "Please run this script as root."
        exit
    fi
}

warn_user() {
    clear
    echo 'This script will erase /dev/sda and install the mc-server-qemu NixOS host on it.
It is meant for automating the install process on VMs. DO NOT run it on a production machine.
Once it starts, it will not ask for more input or confirmation unless something goes wrong.
This should NOT be done unless you know exactly what you are doing!

The following operations will executed onto /dev/sda:
  Mount a 100 MiB tmpfs to /mnt (to prevent overwriting anything else mounted there)
  Mount the nixos-conf virtiofs to /mnt/etc/nixos
  Allocate first 100 MiB to the EFI system partition, format as fat32, and mount to /mnt/boot
  Allocate rest of the drive to a zpool (zroot)
  Setup and mount ZFS datasets zroot/[nix, persistent, minecraft]
  Install the mc-server-qemu host from the flake provided by nixos-conf
  Unmount everything mounted during this install script

You are about to do something potentially harmful.
To continue type in the phrase '\''Yes, do as I say!'\'''
}

install() {
    # Cover /mnt
    mount --types tmpfs -o size=1G tmpfs /mnt

    # Mount nixos-conf (provided by the QEMU host)
    mount --mkdir --types virtiofs nixos-conf /mnt/etc/nixos

    # Create, format, and mount EFI partition
    parted /dev/sda mktable gpt mkpart logical fat32 2048s 206847s set 1 boot on &>/dev/null
    mkfs.fat -F 32 /dev/sda1 >/dev/null
    mount /dev/sda1 -m /mnt/boot

    # Setup ZFS pool and datasets
    parted /dev/sda mkpart logical ext4 206848s 100% &>/dev/null # Note this doesn't actually create an ext4 partition
    zpool create -o ashift=12 -o autotrim=on -O atime=off -O xattr=sa -O normalization=formD -O mountpoint=none zroot /dev/sda2

    zfs create -o mountpoint=legacy zroot/nix
    mount --mkdir --types zfs zroot/nix /mnt/nix

    zfs create -o mountpoint=legacy zroot/persistent
    mount --mkdir --types zfs zroot/persistent /mnt/pers

    zfs create -o mountpoint=legacy zroot/minecraft
    mount --mkdir --types zfs zroot/minecraft /mnt/srv/minecraft

    printf "\nDone setting up the drive! Installing now...\n\n"

    # Install
    nixos-install --flake /mnt/etc/nixos#mc-server-qemu --no-root-password

    # Unmount everything
    umount /mnt/srv/minecraft /mnt/pers /mnt/nix /mnt/boot /mnt/etc/nixos /mnt

    printf "\nCompleted install. You may now restart the computer."
}

main
