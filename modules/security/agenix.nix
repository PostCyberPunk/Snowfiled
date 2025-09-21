{
  lib,
  mLib,
  config,
  system,
  agenix,
  mySecrets,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.security.agenix;
  daeCfg = config.myConfig.network.proxy.dae;
  rcloneCfg = config.myConfig.network.transfer;

  noaccess = {
    mode = "0000";
    owner = "root";
  };
  high_security = {
    mode = "0500";
    owner = "root";
  };
  user_readable = {
    mode = "0500";
    owner = "${config.mUser.name}";
  };
in {
  options.myConfig.security.agenix = {
    enable = mkEnableOption "use agenix";
    rclone = mkOpt file null;
  };
  # options.myConfig.security.agenix.config = mkOpt attrsets {};
  config = mkIf cfg.enable {
    environment.systemPackages = [agenix.packages.${system}.default];
    #NOTE: Don't install secrets on untrusted host!
    #TODO: it's better to have a toggle for agenix
    #TODO: mkIf with options
    age.secrets = mkMerge [
      (mkIf rcloneCfg.enable {
        rcloneConfig = {file = "${mySecrets}/rclone.conf.age";} // user_readable;
      })
      ##dae secrets
      (
        mkIf (daeCfg.enable && daeCfg.secrets != [])
        (builtins.listToAttrs (
          map
          (fileName: {
            name = "${fileName}.dae";
            value = {file = "${mySecrets}/dae/${fileName}.dae.age";} // user_readable;
          })
          daeCfg.secrets
        ))
      )
    ];

    environment.etc = mkMerge [
      (mkIf (daeCfg.enable && daeCfg.secrets != [])
        ######## dae files
        (
          builtins.listToAttrs (
            map
            (fileName: {
              name = "dae/config.d/${fileName}.dae";
              value = {
                source = config.age.secrets."${fileName}.dae".path;
                # hardly need write
                mode = "0600";
              };
            })
            daeCfg.secrets
          )
        ))
    ];
    ######## other files

    ####end of config
  };
}
