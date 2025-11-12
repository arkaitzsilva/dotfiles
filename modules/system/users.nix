{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.system.users;
in {
  options.shelf.system.users = {
  };

  config = {
    users.users.${defaults.username} = {
      createHome = true;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "input"
      ];
    };
  };
}
