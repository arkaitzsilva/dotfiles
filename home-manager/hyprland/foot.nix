{pkgs, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "MesloLGS NF:size=10";
        pad = "10x10";
      };

      colors = {
        alpha = 1;
        foreground = "54FFFF";
        background = "2B3238"; 

        regular0 = "000000";
        regular1 = "FA4B4B";
        regular2 = "18B218";
        regular3 = "B26818";
        regular4 = "5CA7FB";
        regular5 = "E11EE1";
        regular6 = "18B2B2";
        regular7 = "B2B2B2";

        bright0 = "686868";
        bright1 = "FF5454";
        bright2 = "54FF54";
        bright3 = "FFFF54";
        bright4 = "5454FF";
        bright5 = "FF54FF";
        bright6 = "54FFFF";
        bright7 = "FFFFFF";
      };
    };
  };
}