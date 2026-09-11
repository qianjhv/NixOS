{ ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    historyWidgetOptions = [
      "--popup=80%,80%"
      "--layout=reverse"
    ];
  };
}
