{ pkgs, inputs, ...}:
{
  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # 可选：传入额外参数给 greeter 会话，例如设置默认会话为 niri
    greeter-args = "--session niri";

    # 可选：完全声明式的配置，会写入 /var/lib/noctalia-greeter/greeter.toml
    settings = {
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 16;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        layout = "us"; # 根据你的键盘布局修改
      };
      # 可以添加 idle.timeout 等更多设置
    };
  };
}
