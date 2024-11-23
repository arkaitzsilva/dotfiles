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
      font-awesome
      meslo-lgs-nf
    ];
  };
}
