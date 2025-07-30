{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./antigen.nix
    ./prompt.nix
  ];

  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    oh-my-zsh.enable = true;

    shellAliases = config.home.shellAliases;

    # Add our own binaries to the PATH variable
    initContent = ''
      # Load Antigen as our package manager.
      # The .antigenrc file is copied via the fixtures.nix
      source ${pkgs.antigen.outPath}/share/antigen/antigen.zsh
      antigen init ~/.antigenrc

      export PATH="$HOME/code/hausgold/snippets/bin:$PATH"
      export PATH="$HOME/.bun/bin:$HOME/.npm/bin:$PATH"

      art()
      {
      if [ -f "./vendor/bin/sail" ];
      then
          ./vendor/bin/sail artisan "$@"
      else
          php artisan "$@"
      fi
      }

      sail()
      {
      if [ -f "./vendor/bin/sail" ];
      then
          ./vendor/bin/sail "$@"
      else
          echo "Sail is not installed. Run 'composer require laravel/sail' to install it."
      fi
      }
    '';
  };
}
