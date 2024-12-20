{lib, ...}:
with lib; rec {
  ## Create a NixOS module option.
  ##
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt = type: default: description:
    mkOption {inherit type default description;};

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  ## Create a boolean NixOS module option.
  ##
  ## ```nix
  ## lib.mkBoolOpt true "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt = mkOpt types.bool;

  ## Create a boolean NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkBoolOpt true
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt' = mkOpt' types.bool;

  enabled = {
    ## Quickly enable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ true
    enable = true;
  };

  disabled = {
    ## Quickly disable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ false
    enable = false;
  };

  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  getDir = dir:
    mapAttrs
    (
      file: type:
        if type == "directory"
        then getDir "${dir}/${file}"
        else type
    )
    (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  files = dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  validFiles = dir:
    map
    (file: dir + "/${file}")
    (filter
      (file:
        hasSuffix ".nix" file
        && file != "default.nix"
        && ! lib.hasPrefix "x/taffybar/" file
        && ! lib.hasSuffix "-hm.nix" file)
      (files dir));

  fetchImage = url: sha256: let
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };

  ## Merge files into a single file
  mergeFiles = files: let
    # Subfunción local para crear un archivo temporal
    writeText = name: content: builtins.toFile name content;

    # Concatenar el contenido de los archivos
    content = builtins.concatStringsSep "\n" (map builtins.readFile files);
  in
    writeText "merged-file" content;


  mergeConfigMatugenColors = file1: file2: let
    # Local function to create a temporary file
    writeText = name: content: builtins.toFile name content;

    # Read a file as a list of lines
    readFileLines = file: lib.strings.splitString "\n" (builtins.readFile file);

    # Parse a line into key and value based on the presence of "{{"
    parseLine = line:
      let
        # Split the line by the literal string "{{"
        parts = lib.strings.splitString "{{" line;
        _ = builtins.trace "Split result: ${toString parts}" parts;
      in if builtins.length parts > 1 then {
        key = lib.strings.trim (builtins.head parts); # Everything before "{{"
        value = "{{" + builtins.concatStringsSep "{{" (builtins.tail parts); # Include from "{{"
      } else null;

    # Create a mapping from keys to values using file2
    file2Map = builtins.listToAttrs (lib.lists.filter (x: x != null) (map (line:
      let parsed = parseLine line;
      in if parsed != null then { name = parsed.key; value = parsed.value; } else null
    ) (readFileLines file2)));

    # Process lines in file1
    processLines = file1Lines:
      let
        replaceLine = line:
          let
            parsed = parseLine line;
            key = if parsed != null then parsed.key else null;
          in if key != null && builtins.hasAttr key file2Map
             then key + file2Map.${key} # Replace value
             else line; # Keep original line
      in
        builtins.concatStringsSep "\n" (map replaceLine file1Lines);

    # Read and process the input files
    file1Lines = readFileLines file1;
    mergedContent = processLines file1Lines;
  in
    # Write the merged content to a temporary file
    writeText "merged-by-keys" mergedContent;

}
