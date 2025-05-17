{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.system.users;
in {
  options.shelf.system.users = {
  };

  config = {
    users.users.${default.username} = {
      createHome = true;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
        "docker"
        "audio"
      ];
    };
  };
}
