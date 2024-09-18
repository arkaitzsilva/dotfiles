{ pkgs, ... }: let
  aliases = {
    "crfs" = "cryfs ~/.vault ~/Vault";
    "nx-switch" = "sudo nixos-rebuild switch --flake ~/Projects/dotfiles/ --impure";
    "llama" = "ollama run llama3.1:8b ";
  };
in {
  programs.zsh = {
    shellAliases = aliases;
    enable = true;
    initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  home.packages = with pkgs; [
    meslo-lgs-nf
  ];
}