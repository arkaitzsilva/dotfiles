{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.neovim;
in {
  options.shelf.desktop.addons.neovim = {
    enable = mkBoolOpt false "Whether to enable neovim editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ];

    shelf.home.programs = {
      neovim = {
        enable = true;
        #extraConfig = lib.fileContents "${default.configFolder}/nvim/init.vim";
      };
    };
    
    shelf.home.configFile."nvim/init.vim".source = "${default.configFolder}/nvim/init.vim";
    shelf.home.configFile."nvim/colors/nord.vim".source = "${default.configFolder}/nvim/nord.vim";
  };
}
