{ config, lib, pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # sops 基础配置
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  # sops.age.keyFile = "/home/jeff/.config/sops/age/keys.txt";
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  sops.secrets.dae_subscription_url = { };
  sops.secrets.lmq_sub_url = {};
  sops.secrets.TW01 = { };
  sops.secrets.TW02 = { };
  sops.secrets.XJP01 = { };

  sops.templates."dae.conf".content = ''
    global {
      wan_interface: auto
      log_level: info
      allow_insecure: false
      auto_config_kernel_parameter: true
      dial_mode: domain
      tcp_check_http_method: HEAD
      tproxy_port_protect: true
      tls_implementation: utls
      utls_imitate: chrome_auto
    }
    subscription {
      my_sub: '${config.sops.placeholder.dae_subscription_url}'
      lmq_sub: '${config.sops.placeholder.lmq_sub_url}'
    }
    dns {
      upstream {
        googledns: 'tcp+udp://dns.google:53'
        alidns: 'udp://dns.alidns.com:53'
      }
      routing {
        request {
          qtype(https) -> reject
          fallback: alidns
        }
        response {
          upstream(googledns) -> accept
          ip(geoip:private) && !qname(geosite:cn) -> googledns
          fallback: accept
        }
      }
    }
    node {
      TW01: '${config.sops.placeholder.TW01}'
      TW02: '${config.sops.placeholder.TW02}'
      XJG01: '${config.sops.placeholder.XJP01}'
    }
    group {
      proxy {
        # filter: name(TW01) [add_latency: -500ms]
        filter: subtag(lmq_sub) && name(keyword: '新加坡')
        filter: name(TW01)
        filter: name(TW02)
        filter: name(XJP01)
        policy: min_moving_avg
      }
    }
    routing {
      pname(NetworkManager) -> direct
      dip(224.0.0.0/3, 'ff00::/8') -> direct
      l4proto(udp) && dport(443) -> block
      dip(geoip:private) -> direct
      domain(geosite:private) -> direct
      dip(geoip:cn) -> direct
      domain(geosite:cn) -> direct
      domain(geosite:github) -> proxy
      domain(geosite:geolocation-!cn) -> proxy
      domain(geosite:category-ads-all) -> block
      fallback: proxy
    }
  '';

  # dae 服务本身
  services.dae = {
    enable = true;
    package = unstable.dae;
    configFile = config.sops.templates."dae.conf".path;
  };

  systemd.services.dae.after = [ "sops-install-secrets.service" ];
  systemd.services.dae.wants = [ "sops-install-secrets.service" ];
}
