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

  iconThemePkg = inputs.icon-themes.packages.${pkgs.stdenv.hostPlatform.system}.icon-theme-luv.Luv-Dark;
  cursorThemePkg = inputs.cursor-themes.packages.${pkgs.stdenv.hostPlatform.system}.cursor-theme-nx.Nx-Snow;

  aggregated = if config.shelf.desktop.addons.flatpak.enable then pkgs.buildEnv {
    name = "system-icons";
    paths = [
      iconThemePkg
      cursorThemePkg
    ];
    pathsToLink = [
      "/share/icons"
    ];
  } else null;
in {
  options.shelf.desktop.addons.theme = with types; {
    enable = mkBoolOpt false "Whether to enable theme packages.";
  };

  config = mkIf cfg.enable {
    fileSystems = lib.mkMerge [
      (if config.shelf.desktop.addons.flatpak.enable then
        { "/usr/share/icons" = lib.shelf.mkRoSymBind "${aggregated}/share/icons"; }
      else
        {})
    ];

    shelf.home.packages = [
      iconThemePkg
      cursorThemePkg
    ];
  };
}
