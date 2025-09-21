{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop.xdg.userDirs;
  _xdg = config.myConfig.desktop.xdg;
  _home = "${_xdg.home or"/home/${config.mUser.name}"}";
  # Utility to coerce a path to string, for compatibility
  toPathString = v:
    if builtins.isPath v
    then toString v
    else v;

  # Compose the directories attribute set
  directories =
    (filterAttrs (n: v: !isNull v) {
      XDG_DESKTOP_DIR = cfg.desktop;
      XDG_DOCUMENTS_DIR = cfg.documents;
      XDG_DOWNLOAD_DIR = cfg.download;
      XDG_MUSIC_DIR = cfg.music;
      XDG_PICTURES_DIR = cfg.pictures;
      XDG_PUBLICSHARE_DIR = cfg.publicShare;
      XDG_TEMPLATES_DIR = cfg.templates;
      XDG_VIDEOS_DIR = cfg.videos;
    })
    // cfg.extraConfig;
  # Wrap all values in double quotes for user-dirs.dirs
  quotedDirs = mapAttrs (_: v: ''\"${toPathString v}\"'') directories;
in {
  options.myConfig.desktop.xdg.userDirs = {
    enable = mkEnableOption "Whether to manage $XDG_CONFIG_HOME/user-dirs.dirs and export related environment variables.";

    desktop = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Desktop";
      description = "The Desktop directory.";
    };

    documents = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Documents";
      description = "The Documents directory.";
    };

    download = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Downloads";
      description = "The Downloads directory.";
    };

    music = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Music";
      description = "The Music directory.";
    };

    pictures = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Pictures";
      description = "The Pictures directory.";
    };

    publicShare = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Public";
      description = "The Public share directory.";
    };

    templates = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Templates";
      description = "The Templates directory.";
    };

    videos = mkOption {
      type = with types; nullOr (coercedTo path toPathString str);
      default = "${_home}/Videos";
      description = "The Videos directory.";
    };

    extraConfig = mkOption {
      type = with types; attrsOf (coercedTo path toPathString str);
      default = {};
      description = "Other user directories.";
    };

    createDirectories = mkEnableOption "automatic creation of the XDG user directories";
  };

  config = mkIf cfg.enable {
    # Optionally create the directories
    #REFT: standalone script maybe , so we don't have to run this everytime
    systemd.user.services.create-xdg-user-dirs = let
      # Write user-dirs.dirs to $XDG_CONFIG_HOME (or ~/.config)
      configDir = _xdg.configHome or "${_xdg.home or"/home/${config.mUser.name}"}/.config";
      dirFile = "${configDir}/user-dirs.dirs";
      dirFileText = lib.generators.toKeyValue {} quotedDirs;
      dirConfFile = "${configDir}/user-dirs.conf";
      createXdgDir = pkgs.writeShellScript "create-xdg-user-dirs" ''
            #!/bin/sh
            set -e \n
        echo "${dirFileText}" > "${dirFile}"
        echo "enabled=False" > "${dirConfFile}"
            echo "Creating xdg user dirs"
                ${lib.concatStringsSep "\n" (map (dir: ''
          [[ -L "${toPathString dir}" ]] || mkdir -p "${toPathString dir}"
        '') (attrValues directories))}
      '';
    in
      mkIf cfg.createDirectories {
        description = "Create XDG user directories";
        after = ["default.target"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = [createXdgDir];
        };
        wantedBy = ["default.target"];
      };
    # Add environment variables for each directory
    environment.variables = directories;
  };
}
