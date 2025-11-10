{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = config.home.shellAliases;
  };

  # config = ''
  #   export PATH="$HOME/code/hausgold/snippets/bin:$PATH"
  #   export PATH="$HOME/.bun/bin:$HOME/.npm/bin:$PATH"

  #   art()
  #   {
  #   if [ -f "./vendor/bin/sail" ];
  #   then
  #       ./vendor/bin/sail artisan "$@"
  #   else
  #       php artisan "$@"
  #   fi
  #   }

  #   sail()
  #   {
  #   if [ -f "./vendor/bin/sail" ];
  #   then
  #       ./vendor/bin/sail "$@"
  #   else
  #       echo "Sail is not installed. Run 'composer require laravel/sail' to install it."
  #   fi
  #   }
  # '';
}
