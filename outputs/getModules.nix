lib:
with lib;
  dir:
    filter
    (
      path: let
        filename = builtins.baseNameOf path;
      in
        hasSuffix ".nix" filename
        && !hasPrefix "_" filename
    )
    (filesystem.listFilesRecursive dir)
