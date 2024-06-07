{ config, lib, ... }:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;

  cfg = config.programs.rio.catppuccin;
  enable = cfg.enable && config.programs.rio.enable;
in
{
  options.programs.rio.catppuccin = ctp.mkCatppuccinOpt "rio";

  config.programs.rio = lib.mkIf enable {
    settings = lib.importTOML "${sources.rio}/catppuccin-${cfg.flavor}.toml";
  };
}
