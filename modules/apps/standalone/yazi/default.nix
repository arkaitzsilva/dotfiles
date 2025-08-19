{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.yazi;
in {
  options.shelf.apps.standalone.yazi = {
    enable = mkBoolOpt false "Whether to enable yazi file manager.";
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;

    shelf.home.packages = with pkgs; [
      trash-cli
    ];
    
    shelf.home.programs.yazi = {
      enable = true;
      plugins = with pkgs.yaziPlugins; {
        mount = mount;
        git = git;
        full-border = full-border;
        restore = restore;
      };
    };

    shelf.home.configFile."yazi/init.lua".source = "${defaults.configFolder}/yazi/init.lua";
    shelf.home.configFile."yazi/yazi.toml".source = "${defaults.configFolder}/yazi/yazi.toml";
    shelf.home.configFile."yazi/keymap.toml".source = "${defaults.configFolder}/yazi/keymap.toml";
    shelf.home.configFile."yazi/theme.toml".source = "${defaults.configFolder}/yazi/color-scheme-variants/${defaults.colorSchemeVariant}.toml";
  };
}
