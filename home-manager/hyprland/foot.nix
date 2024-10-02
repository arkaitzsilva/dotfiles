{pkgs, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "MesloLGS NF:size=10";
        pad = "10x10";
      };

      colors = {
        alpha = 0.9;
        foreground = "26C6DA";
        background = "2B2C31"; 

        regular0 = "0D0D0D";
        regular1 = "A55471";
        regular2 = "71A550";
        regular3 = "A58450";
        regular4 = "5071A5";
        regular5 = "8450A5";
        regular6 = "50A584";
        regular7 = "C9C9C9";

        bright0 = "393939";
        bright1 = "EBD5DE";
        bright2 = "EBE3D5";
        bright3 = "EBE3D5";
        bright4 = "D5DEEB";
        bright5 = "E3DDEE";
        bright6 = "D5EBE3";
        bright7 = "D9D9D9";
      };
    };
  };
}