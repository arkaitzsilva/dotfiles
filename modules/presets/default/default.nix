{
  config,
  pkgs,
  lib,
  hostName,
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

    shelf.desktop = {
      hyprland = enabled;
    };
  };
}
