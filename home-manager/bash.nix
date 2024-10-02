{ ... }: let
  aliases = {
    "crfs" = "cryfs ~/.vault ~/Vault";
    "nx-switch" = "sudo nixos-rebuild switch --flake ~/Projects/dotfiles/ --impure";
    "cls" = "clear";
  };
in {
  programs = {
    bash = {
      enable = true;
      shellAliases = aliases;
    };

    oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      useTheme = "tokyonight_storm";
    };
  };
}