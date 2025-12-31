{ hostName, overrides ? {} }:

let
  perHostDefaults = {
    M11xR3 = {
      wallpaperResolution = "768p";    
      hostName = "M11xR3";
      username = "alienware";
    };
    Alienware13 = {
      wallpaperResolution = "1800p";
      hostName = "Alienware13";
      username = "alienware";
    };
  };

  base = perHostDefaults.${hostName} or {
    wallpaperResolution = "1080p";    
    hostName = "host";
    username = "user";
  } // {
    system = "x86_64-linux";

    stateVersion = "26.05";

    configFolder = ./dotfiles/config;
    templateFolder = ./dotfiles/templates;
    dataFolder = ./dotfiles/local/share;
    
    colorSchemeVariant = "nord-dark";

    colorVariant = "dark";

    gitEmail = "arkaitz.develop@gmail.com";
    gitName = "arkaitzsilva";
  };
in
  base // overrides
