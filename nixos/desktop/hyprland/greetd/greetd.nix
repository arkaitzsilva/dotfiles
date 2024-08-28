{ pkgs, config, ... }: {
  services.greetd = {
    enable = true;
    #settings.default_session.command = pkgs.writeShellScript "greeter" ''
    #  export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
    #  export XCURSOR_THEME=Luv-Dark
    #'';
  };
}