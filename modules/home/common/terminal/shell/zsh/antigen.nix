{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.antigen];

  # Antigen (Zsh Plugin Manager)
  home.file.".antigenrc".text = ''
    # Load oh-my-zsh
    antigen use oh-my-zsh

    # Load bundles from the default oh-my-zsh repo
    antigen bundle git
    antigen bundle docker
    antigen bundle command-not-found
    # antigen bundle vi-mode
    # antigen bundle gh # gh autocompletion
    # antigen bundle 1password
    # antigen bundle marlonrichert/zsh-autocomplete@main
    # antigen bundle supercrabtree/k
    antigen bundle fzf
    antigen bundle zoxide
    antigen bundle safe-paste
    antigen bundle colored-man-pages
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions

    # Configure a default theme
    THEME="https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train"

    # Enable the configured theme
    # eval "antigen theme $THEME"
    # eval "$(starship init zsh)"

    # And we're done
    antigen apply
  '';
}
