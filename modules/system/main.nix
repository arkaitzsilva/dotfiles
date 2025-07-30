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
  cfg = config.shelf.system;
in {
  options.shelf.system = {
    diffScript = mkBoolOpt true "Enables showing what packages changes between generations on rebuild.";
    defaultShell = mkOpt (types.enum [pkgs.bash pkgs.zsh]) pkgs.bash "Which shell to set the default as.";
  };

  config = {
    users.users.${defaults.username} = {
      shell = cfg.defaultShell;
    };

    system.stateVersion = defaults.stateVersion;

    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # To prevent firefox from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";
        XDG_DOCUMENTS_DIR = "$HOME/docs";

        NIXOS_OZONE_WL = "1";
      };
    };

    shelf.home.extraOptions.xdg.userDirs = {
      createDirectories = true;
      enable = true;
      documents = "$HOME/Documentos";
      download = "$HOME/Descargas";
      pictures = "$HOME/Imágenes";
      videos = "$HOME/Vídeos";
      desktop = "$HOME/Escritorio";
      music = "$HOME/Música";
      templates = "$HOME/Plantillas";
      publicShare = "$HOME/Público";
    };
  };
}
