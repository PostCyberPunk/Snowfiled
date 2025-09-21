{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy;
in {
  config = mkMerge [
    (mkIf cfg.dae.enable {
      services.dae = {
        enable = true;
        openFirewall = {
          enable = true;
          port = cfg.daePort;
        };
        #TODO:use global config and includes
        # if cfg.dae.useConfig
        # then config.age.secrets."config.dae".path
        # else "/etc/dae/config.dae";
        #FIX: geo-ip should updated with nixpkgs-unstable, or add my own repo
        assets = with pkgs; [v2ray-geoip v2ray-domain-list-community];
        #NOTE: this is not working
        # assetsPath = "/etc/dae";
      };
    })
    (mkIf cfg.dae.useDaed {
      services.daed = {
        enable = true;
        openFirewall = {
          enable = true;
          port = cfg.webPort;
        };
        listen = "127.0.0.1:${builtins.toString cfg.webPort}";
      };
    })
    (mkIf (cfg.dae.config == "single") {
      services.dae.configFile = "/etc/dae/config.dae";
    })
    (mkIf (cfg.dae.config == "global") {
      #REFT: to var
      services.dae.config = ''
        include {
            config.d/*.dae
        }
        global {
          wan_interface: auto
          log_level: info
        	check_interval:300000s
          allow_insecure: false
          auto_config_kernel_parameter: true
        }
        dns {
        	upstream {
        		alidns: 'udp://dns.alidns.com:53'
        		googledns: 'tcp+udp://dns.google.com:53'
        	}
        	routing {
        		request {
        			fallback: alidns
        		}
        		response {
        			upstream(googledns) -> accept
        			!qname(geosite:cn) && ip(geoip:private) -> googledns
        			fallback: accept
        		}
        	}
        }
      '';
    })
  ];
}
