{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.user;
  username = cfg.name;
in
  mkIf (username == "SnowMan") {
    mUser = {
      name = username;
      description = "Guest User";
      #TODO: keyd and audio for jack
      extraGroups = ["wheel" "input" "keyd"]; # Enable ‘sudo’ for the user.
    };
    nix.settings = {
      trusted-users = ["${username}"];
      allowed-users = ["${username}"];
    };
    # Set your time zone.
    time.timeZone = "Asia/Shanghai";
  }
