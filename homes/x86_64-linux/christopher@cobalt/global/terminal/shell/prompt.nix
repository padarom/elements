{...}: let
  unicode = code: builtins.fromJSON ''"${code}" '';
in {
  programs.oh-my-posh = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

    # Original settings taken from `catppuccin_frappe`, and adjusted to my
    # likings and usage.
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      version = 3;
      final_space = true;

      palette = {
        os = "#acb0be";
        closer = "p:blue";
        pink = "#f4b8e4";
        lavender = "#babbf1";
        blue = "#8caaee";
        red = "#e78284";
        surface = "#414559";
      };

      blocks = [
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = [
            {
              foreground = "p:os";
              style = "plain";
              template = "{{ .Icon }} ";
              type = "os";
            }
            {
              foreground = "p:pink";
              style = "plain";
              template = "{{ .Path }} ";
              type = "path";
              properties = {
                home_icon = "~";
                style = "full";
                mapped_locations = {
                  "~/code/hausgold/env/projects" = "hg-env";
                  "~/code/hausgold" = "hg";
                  "~/code/opensource" = "oss";
                  "~/code/own" = "own";
                };
              };
            }
            {
              foreground = "p:blue";
              style = "plain";
              template = "{{ .UserName }}@{{ .HostName }} ";
              type = "session";
            }
            {
              foreground = "p:lavender";
              template = "{{ .HEAD }} ";
              style = "plain";
              type = "git";
              properties = {
                branch_icon = unicode "\\ue725 ";
                cherry_pick_icon = unicode "\\ue29b ";
                commit_icon = unicode "\\uf417 ";
                merge_icon = unicode "\\ue727 ";
                no_commits_icon = unicode "\\uef0c3 ";
                rebase_icon = unicode "\\ue728 ";
                revert_icon = unicode "\\uf0e2 ";
                tag_icon = unicode "\\uf412 ";
                fetch_status = false;
                fetch_upstream_icon = false;
              };
            }
          ];
        }
        {
          alignment = "right";
          type = "prompt";
          segments = [
            {
              foreground = "p:red";
              background = "p:surface";
              style = "plain";
              template = unicode "{{ if .Error }}\\uf06d {{ .String }}{{ end }}";
              type = "status";
              properties = {
                always_enabled = true;
              };
            }
            {
              foreground = "p:pink";
              style = "plain";
              template = " {{ .FormattedMs }}";
              type = "executiontime";
              properties = {
                style = "austin";
              };
            }
          ];
        }
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = [
            {
              foreground = "p:closer";
              template = "#";
              style = "plain";
              type = "text";
            }
          ];
        }
      ];
    };
  };
}
