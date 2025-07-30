{
  environment.pathsToLink = ["/share/zsh"];

  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = {
          "rm -rf *" = "fg=black,bg=red";
        };
        styles = {
          "aliases" = "fg=magenta";
        };
        highlighters = [
          "main"
          "brackets"
          "pattern"
        ];
      };
    };
  };
}
