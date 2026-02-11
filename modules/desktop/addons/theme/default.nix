{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.theme;
in {
  options.shelf.desktop.addons.theme = with types; {
    enable = mkBoolOpt false "Whether to enable theme packages.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = [
      inputs.cursor-themes.packages.${pkgs.stdenv.hostPlatform.system}.cursor-theme-nx.Nx-Snow
      inputs.icon-themes.packages.${pkgs.stdenv.hostPlatform.system}.icon-theme-luv.Luv-Dark
    ];
  };
}
