{ config, lib, ... }:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;
  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;

  themePath = "/${cfg.flavor}/${cfg.accent}.yml";
in
{
  options.programs.lazygit.catppuccin = lib.ctp.mkCatppuccinOpt "lazygit" // {
    accent = ctp.mkAccentOpt "lazygit";
  };

  config.programs.lazygit = lib.mkIf enable {
    settings = lib.ctp.fromYaml "${sources.lazygit}/themes-mergable/${themePath}";
  };
}
