{ pkgs, ... }:
{
  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans     # 官方 Noto 中文字体（无衬线）
    noto-fonts-cjk-serif    # 衬线版，可选
    noto-fonts-color-emoji
    source-han-sans
    source-han-serif
    source-han-mono
    inter

    #
    sarasa-gothic
    lxgw-wenkai
    maple-mono.NF-CN
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.mononoki
    nerd-fonts.roboto-mono
    nerd-fonts.iosevka
  ];

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
    defaultFonts = {
      sansSerif = [ "Sarasa UI SC" "Noto Sans CJK SC" ];
      serif = [ "Noto Serif CJK SC" ];
      monospace = [ "Sarasa Mono SC" "Noto Sans Mono CJK SC" ];
      emoji = [ "Noto Color Emoji" ];
    };

    # defaultFonts = {
    #   sansSerif = [ "Inter" "Source Han Sans SC" "Sarasa UI SC" "Noto Sans CJK SC" ];
    #   serif = [ "Source Han Serif SC" "LXGW WenKai" "Noto Serif CJK SC" ];
    #   monospace = [ "Source Han Mono SC" "JetBrainsMono Nerd Font" "Sarasa Mono SC" ];
    #   emoji = [ "Noto Color Emoji" ];
    # };

    # localConf = ''
    #   <?xml version="1.0"?>
    #   <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    #   <fontconfig>
    #     <match target="font">
    #       <edit name="antialias" mode="assign"><bool>true</bool></edit>
    #       <edit name="hinting" mode="assign"><bool>true</bool></edit>
    #       <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
    #       <edit name="rgba" mode="assign"><const>rgb</const></edit>
    #       <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>
    #     </match>
    #   </fontconfig>
    # '';
  };
}
