{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.bottom.catppuccin;
  enable = cfg.enable && config.programs.bottom.enable;
in
{
  options.programs.bottom.catppuccin = lib.ctp.mkCatppuccinOpt "bottom";

  config.programs.bottom = lib.mkIf enable {
    settings = lib.importTOML "${sources.bottom}/themes/${cfg.flavor}.toml";
  };
}
