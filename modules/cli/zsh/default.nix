{
  config,
  pkgs,
  lib,
  default,
  hostName,
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
        nx-switch = "sudo nixos-rebuild switch --flake ~/Projects/dotfiles#${hostName}";
      };
      enableCompletion = true;
      syntaxHighlighting = enabled;
    };
  };
}
