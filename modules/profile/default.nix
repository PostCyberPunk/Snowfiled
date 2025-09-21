{
  lib,
  mLib,
  config,
  options,
  ...
}:
with lib;
with mLib;
with types; {
  options = {
    myConfig.profile = {
      kernel = {
        preset = mkOpt str "";
      };
      disk = {
        useDisko = mkOpt bool false;
        rootDisk = mkOpt str "";
        diskoPreset = mkOpt str "";
      };
      user = {
        name = mkOpt' str "SnowMan" "The user name.";
        key = mkOpt' str "" "The user ssh pub key.";
      };
    };
    mUser = mkOpt attrs {name = "";};
  };
  config = {
    #------------
    assertions = [
      {
        assertion = config.mUser ? name;
        message = "config.mUser.name is not set!";
      }
    ];
    #------------
    users.users.${config.mUser.name} = mkAliasDefinitions options.mUser;
    mUser = {
      description = mkDefault "The primary user account";
      isNormalUser = true;
      home = "/home/${config.mUser.name}";
      group = "users";
      uid = 1000;
    };
  };
}
