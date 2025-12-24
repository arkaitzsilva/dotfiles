{
  config,
  pkgs,
  lib,
  hostName,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.presets.default;
in {
  options.shelf.presets.default = {
    enable = mkBoolOpt false "Whether to enable the default suite.";
  };

  config = mkIf cfg.enable { 
    shelf.system = {
      diffScript = true;
      locale.timeZone = "Europe/Madrid";
      defaultShell = pkgs.zsh;
      sound = enabled;
    };

    shelf.system.hosts.${hostName} = {
      variant = "dark";
      type = "scheme-neutral";
    };

    shelf.presets = {
      dev = enabled;
    };

    shelf.desktop = {
      hyprland = mkIf (defaults.wm == "hyprland") enabled;
      niri = mkIf (defaults.wm == "niri") enabled;
    };
  };
}
