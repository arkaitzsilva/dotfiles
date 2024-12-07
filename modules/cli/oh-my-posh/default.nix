{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.oh-my-posh;
  zshEnabled = config.shelf.cli.zsh.enable || config.shelf.system.defaultShell == pkgs.zsh;
in {
  options.shelf.cli.oh-my-posh = {
    enable = mkBoolOpt false "Whether to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = zshEnabled;
      #useTheme = "tokyonight_storm";
      settings = 
      {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
        version = 2;
        finalSpace = true;
        consoleTitleTemplate = "{{.Folder}}{{if .Root}} :: root{{end}} :: {{.Shell}}";

        blocks = [
          {
            type = "prompt";
            alignment = "left";
            newline = true;

            segments = [
              {
                type = "path";
                style = "plain";
                background = "transparent";
                foreground = "p:blue";
                template = "{{ .Path }}";
                properties = {
                  style = "full";
                };
              }
              {
                type = "git";
                style = "plain";
                foreground = "p:grey";
                background = "transparent";
                template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</> ";
                properties = {
                  branch_icon = "";
                  commit_icon = "@";
                  fetch_status = true;
                };
              }
            ];
          }
          {
            type = "rprompt";
            overflow = "hidden";

            segments = [
              {
                type = "executiontime";
                style = "plain";
                foreground = "p:yellow";
                background = "transparent";
                template = " {{ .FormattedMs }} ";
                properties = {
                  style = "round";
                  threshold = 5000;
                };
              }
            ];
          }
          {
            type = "prompt";
            alignment = "left";
            newline = true;

            segments = [
              {
                type = "text";
                style = "plain";
                foreground_templates = [
                  "{{if gt .Code 0}}p:red{{end}}"
                  "{{if eq .Code 0}}p:green{{end}}"
                ];
                background = "transparent";
                template = "❯ ";
              }
            ];  
          }
        ];  

        transient_prompt = {
          foreground_templates = [
            "{{if gt .Code 0}}p:red{{end}}"
            "{{if eq .Code 0}}p:green{{end}}"
          ];
          background = "transparent";
          template = "❯ ";
        };

        secondary_prompt = {
          foreground = "p:green";
          background = "transparent";
          template = "❯❯ ";
        };

        palette = {
          red = "#FAA5AB";
          green = "#A5CD84";
          yellow = "#EFBD58";
          blue = "#8DC3F1";
          grey = "#CACCD3";          
        };
      };
    };
  };
}
