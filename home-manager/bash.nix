{ ... }: let
  aliases = {
    "cls" = "clear";
    "crfs" = "cryfs ~/.vault ~/Vault";
    "nx-switch" = "sudo nixos-rebuild switch --flake ~/Projects/dotfiles/ --impure";
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
      #settings = {};
    };
  };
}