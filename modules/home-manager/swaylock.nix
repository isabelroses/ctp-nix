{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.swaylock.catppuccin;
  enable = cfg.enable && config.programs.swaylock.enable;
in
{
  options.programs.swaylock.catppuccin = lib.ctp.mkCatppuccinOpt "swaylock";

  config.programs.swaylock = lib.mkIf enable {
    settings = lib.ctp.fromINI "${sources.swaylock}/themes/${cfg.flavor}.conf";
  };
}
