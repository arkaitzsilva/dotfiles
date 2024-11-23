{
  config,
  pkgs,
  lib,
  default,
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

    shelf.system.hosts.${default.host} = {
      variant = "dark";
      type = "scheme-neutral";
    };

    shelf.cli.git = {
      email = "arkaitz.develop@gmail.com";
      name = "arkaitzsilva";
    };

    shelf.desktop = {
      hyprland = enabled;
    };
  };
}
