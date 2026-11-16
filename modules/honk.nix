
{ config, honk, ... }:

{
  # SOPS 基础配置
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  # 敏感信息
  sops.secrets.dae_subscription_url = {};
  sops.secrets.lmq_sub_url = {};

  sops.secrets.TW01 = {};
  sops.secrets.TW02 = {};
  sops.secrets.XJP01 = {};

  # honk 配置
  sops.templates."honk.dae" = {
    mode = "0400";

    content = ''
      global {
        wan_interface: auto
        log_level: info
        dial_mode: domain

        data_dir: '/var/lib/honk'
        auto_config_kernel_parameter: true

        tcp_check_http_method: HEAD

        tls_implementation: utls
        utls_imitate: chrome_auto

        bootstrap_resolver: '223.5.5.5:53'
        store_subscribe: true
      }

      subscription {
        my_sub: '${config.sops.placeholder.dae_subscription_url}' {
          ua: 'clash.meta'
          interval: 3600s
          route: direct
        }

        lmq_sub: '${config.sops.placeholder.lmq_sub_url}' {
          ua: 'clash.meta'
          interval: 3600s
          route: direct
        }
      }

      dns {
        ipversion_prefer: 4

        upstream {
          alidns: 'udp://223.5.5.5:53' -> direct
          googledns: 'tcp+udp://8.8.8.8:53' -> direct
        }

        routing {
          request {
            qtype(HTTPS) -> reject
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
          filter: subtag(lmq_sub) && name(keyword: '新加坡')
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
        domain(geosite:category-ads-all) -> block
        domain(geosite:geolocation-!cn) -> proxy

        fallback: proxy
      }
    '';
  };

  # honk systemd 服务
  systemd.services.honk-core = {
    description = "honk transparent proxy engine";

    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" "sops-install-secrets.service" ];
    after = [ "network-online.target" "sops-install-secrets.service" ];

    serviceConfig = {
      Type = "notify";
      User = "root";

      WorkingDirectory = "/var/lib/honk";
      StateDirectory = "honk";
      StateDirectoryMode = "0700";

      ExecStart = ''
        ${honk}/bin/honk-core \
          --config ${config.sops.templates."honk.dae".path} \
          --disable-timestamp
      '';

      ExecReload = "${honk}/bin/honk-core reload";

      Restart = "on-failure";
      RestartSec = "2s";
      TimeoutStopSec = "30s";

      LimitNOFILE = 1048576;
      LimitMEMLOCK = "infinity";
      UMask = "0077";
    };
  };

}

