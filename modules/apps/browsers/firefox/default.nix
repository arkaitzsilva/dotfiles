{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.firefox;
in {
  options.shelf.apps.browsers.firefox = with types; {
    enable = mkBoolOpt false "Whether to enable firefox browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.firefox = {
      enable = true;
      profiles = {
        default = {
          name = "default";
          settings = {
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          };
        };
      };
    };
  };
}