{lib, ...}: let
  inherit (lib) mkOption types;
in {
  #options
  mkOpt = type: default:
    mkOption {inherit type default;};

  mkOpt' = type: default: description:
    mkOption {inherit type default description;};

  mkBoolOpt = default:
    mkOption {
      inherit default;
      type = types.bool;
      example = true;
    };
  mkEnableOption' = description:
    mkOption {
      default = true;
      type = types.bool;
      example = true;
      description = description;
    };
  # HACK: emmm...
  # quickAppOpt = {
  #   cfg,
  #   apps,
  #   lib,
  #   config,
  #   ...
  # }:
  #   with lib; {
  #     options.myConfig.${cfg} = mkBoolOpt false;
  #     config = mkIf config.myConfig.${cfg} {
  #       environment.systemPackages = apps;
  #     };
  #   };
}
