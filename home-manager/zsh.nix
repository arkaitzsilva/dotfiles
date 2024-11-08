{ ... }: let
  aliases = {
    "cls" = "clear";
    "crfs" = "cryfs ~/.vault ~/Vault";
    "nx-switch" = "sudo nixos-rebuild switch --flake ~/Projects/dotfiles/ --impure";
  };
in {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      #syntaxHighlighting.enable = true;
      shellAliases = aliases;
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      #useTheme = "tokyonight_storm";
      settings = 
      {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
        version = 2;
        finalSpace = true;
        consoleTitleTemplate = "{{ .Shell }} in {{ .Folder }}";

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
          purple = "#FF54FF";
          red = "#FF5454";
          yellow = "#FFFF54";
          blue = "#5CA7FB";
          grey = "#B2B2B2";
          green = "#54FF54";
        };
      };
    };
  };
}