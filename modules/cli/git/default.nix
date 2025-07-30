{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.git;
in {
  options.shelf.cli.git = with types; {
    enable = mkBoolOpt false "Whether to enable git.";
    email = mkOption {
      type = str;
      default = "";
      description = ''
        The email adress that will be used.
      '';
    };
    name = mkOption {
      type = str;
      default = "";
      description = ''
        The name that will be used.
      '';
    };
  };

  config = mkIf cfg.enable {
    shelf.home.programs.git = {
      enable = true;
      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        credential.helper = "store";
        github.user = config.shelf.cli.git.name;
        push.autoSetupRemote = true;
      };
      userEmail = config.shelf.cli.git.email;
      userName = config.shelf.cli.git.name;
    };
  };
}
