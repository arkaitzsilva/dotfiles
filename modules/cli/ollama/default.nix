{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.ollama;
in {
  options.shelf.cli.ollama = {
    enable = mkBoolOpt false "Whether to enable ollama.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    services.ollama = {
      enable = true;
      # Optional: preload models, see https://ollama.com/library
      loadModels = [ "llama2-uncensored:latest"];
    };
  };
}
