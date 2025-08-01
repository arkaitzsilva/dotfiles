{ hostName, overrides ? {} }:

let
  perHostDefaults = {
    M11xR3 = {
      wallpaperResolution = "768p";    
      hostName = "M11xR3";
      username = "alienware";
      enableDiscreteGraphics = true;
    };
    Alienware13 = {
      wallpaperResolution = "1080p";    
      hostName = "Alienware13";
      username = "alienware";
      enableDiscreteGraphics = true;
    };
  };

  base = perHostDefaults.${hostName} or {
    wallpaperResolution = "1080p";    
    hostName = "host";
    username = "user";
    enableDiscreteGraphics = false;
  } // {
    system = "x86_64-linux";

    stateVersion = "25.05";

    configFolder = ./dotfiles/config;
    templateFolder = ./dotfiles/templates;
    dataFolder = ./dotfiles/local/share;

    colorSchemeVariant = "nord";

    colorVariant = "dark";

    gitEmail = "arkaitz.develop@gmail.com";
    gitName = "arkaitzsilva";
  };
in
  base // overrides
