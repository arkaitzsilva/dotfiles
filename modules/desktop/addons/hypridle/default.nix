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
  cfg = config.shelf.desktop.addons.hypridle;
in {
  options.shelf.desktop.addons.hypridle = with types; {
    enable = mkBoolOpt false "Whether to enable hypridle.";
  };

  config = mkIf cfg.enable {
    shelf.home.services.hypridle = {
      enable = true;
      package = inputs.hypridle.packages.${pkgs.system}.default;
    };

    shelf.home.configFile."hypr/hypridle.conf".source = "${defaults.configFolder}/hypr/hypridle.conf";
  };
}
