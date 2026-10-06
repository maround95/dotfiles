{ inputs, ... }:
let
  getAttrPathOr = path: default: set:
    let
      go = remaining: current:
        if remaining == [ ] then
          current
        else
          let
            key = builtins.head remaining;
          in
          if builtins.isAttrs current && builtins.hasAttr key current then
            go (builtins.tail remaining) current.${key}
          else
            default;
    in
    go path set;

  asModuleList = value:
    if value == null then [ ]
    else if builtins.isList value then value
    else [ value ];

  getModules = path:
    if inputs ? secrets then
      asModuleList (getAttrPathOr path null inputs.secrets)
    else
      [ ];
in
{
  flake.lib.core.secretsModulesFor =
    { family
    , system
    , outputName ? null
    , user ? null
    }:
    let
      basePath = [ "modules" "secrets" family system ];
      common = getModules (basePath ++ [ "common" ]);
      output =
        if outputName == null || family == "home" then
          [ ]
        else
          getModules (basePath ++ [ "outputs" outputName ]);
      homeUser =
        if family != "home" || outputName == null || user == null then
          [ ]
        else
          getModules (basePath ++ [ "outputs" outputName "users" user ]);
    in
    common ++ output ++ homeUser;
}
