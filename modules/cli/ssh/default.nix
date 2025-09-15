{
  config,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.ssh;
in {
  options.shelf.cli.ssh = {
    enable = mkBoolOpt false "Whether to enable ssh.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      enableDefaultConfig = false;
    };

    shelf.home.services.ssh-agent = {
      enable = true;
    };
  };
}
