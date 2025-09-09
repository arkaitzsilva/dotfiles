{
  config,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.presets.dev;
in {
  options.shelf.presets.dev = {
    enable = mkBoolOpt false "Whether to enable the dev suite.";
  };

  config = mkIf cfg.enable {
    shelf.cli = {
      ssh = enabled;
      git = enabled;
      oh-my-posh = enabled;
      docker = enabled;
      ollama = enabled;
      python = enabled;
    };
  };
}
