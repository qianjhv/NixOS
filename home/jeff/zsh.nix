{ ... }:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      dotfiles = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
    };

    # aliases
    # completion
    # history
    # initContent
    # plugins
    # ...
  };
}
