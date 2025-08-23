{
  config,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.git;
in {
  options.shelf.cli.git = with types; {
    enable = mkBoolOpt false "Whether to enable git.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.git = {
      enable = true;
      lfs.enable = true;
      extraConfig = {
        color.ui = true;
        core.editor = "nano";
        credential.helper = "store";
        github.user = defaults.gitName;
        push.autoSetupRemote = true;
      };
      userEmail = defaults.gitEmail;
      userName = defaults.gitName;
    };
  };
}
