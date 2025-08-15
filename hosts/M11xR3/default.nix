{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; {
  imports = [
    ./hardware.nix
  ];

  # To prevent freezing when compiling
  nix.settings.cores = 3;

  # Additional packages to install
  environment.systemPackages = with pkgs; [];

  time.hardwareClockInLocalTime = true;

  shelf.system.networking.bluetooth = true;

  shelf.presets = {
    default = enabled;
    qt = enabled;
    dev = enabled;
  };
}
