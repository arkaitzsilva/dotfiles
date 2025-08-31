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
    #./dsdt-override.nix
  ];

  # To prevent freezing when compiling
  nix.settings.cores = 3;

  # Additional packages to install
  environment.systemPackages = with pkgs; [];

  # console.font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus32.psfu.gz";

  shelf.system.networking.bluetooth = true;

  shelf.presets = {
    default = enabled;
    qt = enabled;
    dev = enabled;
  };
}
