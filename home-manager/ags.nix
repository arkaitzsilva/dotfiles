{ pkgs, inputs, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    esbuild
    sass
    fd
  ];

  programs.ags = {
    enable = true;
    configDir = ../ags;
    extraPackages = with pkgs; [ ];
  };
}