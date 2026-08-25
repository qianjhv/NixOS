# modules/kanata.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.myModules.kanata;
in
{
  options.myModules.kanata.enable = lib.mkEnableOption "kanata keyboard remapper";

  config = lib.mkIf cfg.enable {
    hardware.uinput.enable = true;

    services.kanata = {
      enable = true;
      keyboards = {
        # "internalKeyboard" 只是标识符,可以起任何名字
        internalKeyboard = {
          # 留空 = 自动检测并接管所有键盘设备。
          # 只有一个键盘、不打算扩展第二个 profile 时可以这样用;
          # 以后要加外接键盘独立映射时,再写死具体设备路径。
          # devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];

          extraDefCfg = ''
            process-unmapped-keys yes
            concurrent-tap-hold yes
            linux-device-detect-mode keyboard-only
          '';

          # 这里是你的核心键盘映射规则，使用 Kanata 的 KBD 语法
          config = ''
            (defsrc
              l    u    y    ;
              caps a    r    t    h    n    e    i
              k    ,    .
            )
  
            (defalias
              col-caps (tap-hold 160 180 esc lmet)
              col-a (tap-hold 160 180 a lctl)
              col-r (tap-hold 160 180 r lsft)
              col-t-nav (tap-hold 160 180 t (layer-while-held nav))
              col-n (tap-hold 160 180 n rmet)
              col-e (tap-hold 160 180 e rctl)
              col-i (tap-hold 160 180 i rsft)
            )

            (deflayer base
              l         u       y        ;
              @col-caps @col-a  @col-r   @col-t-nav h    @col-n   @col-e   @col-i
              k         ,       .
            )

            (deflayer nav
              pgup     ins      pgdn     prnt
              caps     _        _        _          left down     up       rght
              del      home     end
            )
          '';
        };
      };
    };

    # kanata 的 systemd service 需要读写 uinput 设备

    users.groups.uinput = { };
  };
}
