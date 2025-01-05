{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.discord;
in {
  options.shelf.apps.gtk.discord = {
    enable = mkBoolOpt false "Whether to enable discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
