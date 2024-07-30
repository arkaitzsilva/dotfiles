{pkgs, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
          font = "MesloLGS NF:size=10";
          pad = "10x10";
      };
      colors = {
          foreground = "E8EAED";
          background = "202124";

          regular0="202124";
          regular1="EA4335";
          regular2="34A853";
          regular3="FBBC04";
          regular4="4285F4";
          regular5="A142F4";
          regular6="24C1E0";
          regular7="E8EAED";

          bright0="5F6368";
          bright1="EA4335";
          bright2="34A853";
          bright3="FBBC05";
          bright4="4285F4";
          bright5="A142F4";
          bright6="24C1E0";
          bright7="FFFFFF";
      };
    };
  };
}