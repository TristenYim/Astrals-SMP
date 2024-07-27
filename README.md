!THIS IS A TEMPORARY README!
This will serve as my personal TODO list and notes until the modpack is in a more ready state.

TODO:

Modpack:
  Add everything from 1.0.1
    Add EndAnchor or a suitable alternative
    Add the config files
  Updating
    Update version to 1.20.4 (if possible)
    Add extra optimization mods such as Starlight
    Add any additional mods people want
  Test the modpack
  Alternative versions
    Add a client-only version (to the number of mods loaded)
    Add a server-only version (to the number of mods loaded)
    
Server:
  Make the server automatically restart during the night (to clear memory leaks)
  Startup Script
    Add automatic backups
    Setup tmux in fewer commands
  NixOS
    Create a NixOS configuration for the server box on another machine or VM
    Backup the current server
    Backup other files on the ssd
    Install nixos onto the ubuntu partition and import the configuration
    Copy the server folder back onto the ssd
    Setup playit
    Test the server
