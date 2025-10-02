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
      nerd-fonts.fira-code
    ];
  };
}
