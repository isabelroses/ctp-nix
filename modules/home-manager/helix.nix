{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.helix.catppuccin;
  enable = cfg.enable && config.programs.helix.enable;
in
{
  options.programs.helix.catppuccin = lib.ctp.mkCatppuccinOpt "helix" // {
    useItalics = lib.mkEnableOption "Italics in Catppuccin theme for Helix";
  };

  config.programs.helix =
    let
      subdir = if cfg.useItalics then "default" else "no_italics";
    in
    lib.mkIf enable {
      settings = {
        theme = "catppuccin-${cfg.flavor}";
        editor.color-modes = lib.mkDefault true;
      };

      themes."catppuccin-${cfg.flavor}" = lib.importTOML "${sources.helix}/themes/${subdir}/catppuccin_${cfg.flavor}.toml";
    };
}
