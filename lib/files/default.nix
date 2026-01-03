{lib, ...}: rec {

  ## Create home file links from a directory, filtered by a predicate function.
  ##
  ## ```nix
  ## lib.mkHomeFileLinksFromDirFiltered ./src ./target (file: lib.hasSuffix ".txt" file)
  ## ```
  ##
  ## This function takes:
  ## - `src`: The source directory.
  ## - `target`: The target directory.
  ## - `filterFn`: A function `(String -> Bool)` to select which files to link.
  ## It reads all files in `src`, filters them with `filterFn`, and
  ## produces an attribute set mapping file names to `{ source, target }` pairs.
  ##
  #@ Path -> Path -> (String -> Bool) -> AttrSet { source :: Path; target :: Path; }
  mkHomeFileLinksFromDirFiltered = src: target: filterFn: let
    files = builtins.attrNames (builtins.readDir src);
    filteredFiles = lib.filter filterFn files;
  in
    lib.genAttrs filteredFiles (file: {
      source = "${src}/${file}";
      target = "${target}/${file}";
    });

  ## Create home file links for all files in a directory.
  ##
  ## ```nix
  ## lib.mkHomeFileLinksFromDir ./src ./target
  ## ```
  ##
  ## This is a convenience wrapper around `mkHomeFileLinksFromDirFiltered`
  ## that includes all files (no filtering).
  ##
  #@ Path -> Path -> AttrSet { source :: Path; target :: Path; }
  mkHomeFileLinksFromDir = src: target: mkHomeFileLinksFromDirFiltered src target (_: true);
}
