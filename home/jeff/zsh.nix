{ ... }:
{
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true; 

    shellAliases = {
      dotfiles = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
      ffetch = "fastfetch -c neofetch";
      fzp = "fzf --popup=80%,70% --preview 'bat -n --color=always {} 2>/dev/null || cat {}'";

      ls = "eza";
      la = "eza -lah --git";
      tree = "eza --tree";
    };

    initContent = ''
      # fzf 配置
      export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
      export FZF_DEFAULT_OPTS="--popup=80%,70% --bind 'resize:refresh-preview'"
      export FZF_CTRL_R_OPTS="--layout=reverse"
      export FZF_CTRL_T_OPTS="--layout=reverse --preview 'bat -n --color=always {} 2>/dev/null || cat {}'"
      export FZF_ALT_C_OPTS="--layout=reverse --preview 'tree -C {} | head -100'"

      # 防止误触 Ctrl+D 退出 shell
      setopt IGNORE_EOF
    '';

    oh-my-zsh = {
      enable = true;
      # theme = "robbyrussell";
      plugins = [
        # "git"
        # "docker"
        "zoxide"
        "fzf"
        "colored-man-pages"
      ];
    };
  };

  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
  };
}
