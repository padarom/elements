{
  pkgs,
  config,
  ...
}: {
  programs.zoxide.enable = true;
  programs.zoxide.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;

    shellAliases = config.home.shellAliases;

    plugins = with pkgs; [
      nushellPlugins.query
      nushellPlugins.gstat
      nushellPlugins.skim
      # nushellPlugins.net
      # nushellPlugins.units
    ];

    environmentVariables = config.home.sessionVariables;

    extraConfig = ''
      let carapace_completer = { |spans|
        carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
      }

      # zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
      let zoxide_completer = { |spans|
        $spans | skip 1 | zoxide query -l ...$in | lines | where { |x| $x != $env.PWD }
      }

      # https://www.nushell.sh/cookbook/external_completers.html#alias-completions
      let multiple_completers = { |spans|
        ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
        let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

        let spans = if $expanded_alias != null {
          $spans
          | skip 1
          | prepend ($expanded_alias | split row ' ' | take 1)
        } else {
          $spans
        }
        ## alias fixer end

        match $spans.0 {
          __zoxide_z | __zoxide_zi => $zoxide_completer
          _ => $carapace_completer
        } | do $in $spans
      }

      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false # case-sensitive completions
          quick: true           # set to false to prevent auto-selecting completions
          partial: true         # set to false to prevent partial filling of the prompt
          algorithm: "fuzzy"    # prefix or fuzzy
          external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true
            # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100
            completer: $multiple_completers
          }
        }
      }

      def agx [search] {
        hx (ag $search | fzf | cut -d : -f 1,2)
      }
    '';

    envFile.text = ''
      $env.PATH = (
        $env.PATH
          | split row (char esep)
          | append $"($env.HOME)/code/hausgold/snippets/bin"
          | append $"($env.HOME)/.bun/bin"
          | append $"($env.HOME)/.npm/bin"
          | append /usr/bin/env
      )
    '';
  };

  # Shell completions
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
