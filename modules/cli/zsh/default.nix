{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.zsh;
in {
  options.shelf.cli.zsh = with types; {
    enable = mkBoolOpt false "Whether to enable zsh.";
  };

  config = mkIf (cfg.enable || config.shelf.system.defaultShell == pkgs.zsh) {
    environment.systemPackages = with pkgs; [];

    programs.zsh.enable = true;

    shelf.home.programs.zsh = {
      enable = true;
      shellAliases = {
        cls = "clear";
        crfs = "cryfs ~/.vault ~/Vault";
      };
      enableCompletion = true;
      syntaxHighlighting = enabled;
    };
  };
}
