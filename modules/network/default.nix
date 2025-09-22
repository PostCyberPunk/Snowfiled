{
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; {
  options.myConfig.network = {
    networkmanager = mkEnableOption' "Use NetworkManager";
    proxy = {
      proxychains = {
        enable = mkBoolOpt false;
        type = mkOpt str "socks5";
        host = mkOpt str "127.0.0.1";
        port = mkOpt int 9003;
      };
      system = {
        enable = mkBoolOpt false;
        host = mkOpt str "127.0.0.1";
        port = mkOpt int 9003;
      };
      v2raya = {
        enable = mkBoolOpt false;
      };
      dae = {
        enable = mkBoolOpt false;
        config = mkOpt str "";
        secrets = mkOpt (listOf str) [];
        useDaed = mkBoolOpt false;
      };
      mihomo-party = {
        enable = mkBoolOpt false;
      };
      mihomo-core = {
        enable = mkBoolOpt false;
        useTui = mkBoolOpt false;
      };

      webPort = mkOpt int 9000;
      daePort = mkOpt int 9001;
      httpsPort = mkOpt int 9002;
      socksPort = mkOpt int 9003;
      #HACK:
      ports = mkOpt (listOf int) [9000 9001 9002 9003];
    };
    transfer = {enable = mkEnableOption "transfer";};
  };
}
