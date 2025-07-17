{
  config,
  pkgs,
  ...
}: {
  config = {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      google-fonts
      meslo-lgs-nf
    ];
  };
}
