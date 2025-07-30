{
  config,
  pkgs,
  lib,
  default,
  hostName,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.system.networking;
in {
  options.shelf.system.networking = {
    bluetooth = mkBoolOpt false "Whether to enable bluetooth.";
  };

  config = {
    networking = {
      hostName = hostName;
      networkmanager.enable = true;
    };

    hardware.bluetooth.enable = cfg.bluetooth;
    services.blueman.enable = cfg.bluetooth;
  };
}
