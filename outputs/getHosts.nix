with builtins; let
  getPath = dir: file: "${toString dir}/${file}";
  getHostDirs = dir:
    filter
    (file: pathExists "${getPath dir file}/default.nix")
    (attrNames (readDir dir));
in
  dir: inputs:
    listToAttrs
    (map
      (file: {
        name = file;
        value = import (getPath dir file) inputs;
      })
      (getHostDirs dir))
