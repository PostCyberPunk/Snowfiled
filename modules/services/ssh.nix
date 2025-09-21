{
  config,
  mLib,
  lib,
  pkgs,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.services.ssh;
in {
  options = {
    myConfig.services.ssh.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    programs.ssh = {
      # Known vulnerability. See
      # https://security.stackexchange.com/questions/110639/how-exploitable-is-the-recent-useroaming-ssh-vulnerability
      extraConfig = ''
        Host *
          UseRoaming no
      '';
    };
    environment.systemPackages = with pkgs; [
      sshfs
    ];
  };
}
