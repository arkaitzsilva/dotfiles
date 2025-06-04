{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.hyprshell;
in {
  options.shelf.desktop.addons.hyprshell = with types; {
    enable = mkBoolOpt false "Whether to enable hyprshell.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libdbusmenu-gtk3
      inputs.hyprshell.packages.${pkgs.system}.default
    ];

    services = {
      upower.enable = true;
    };
  };
}
