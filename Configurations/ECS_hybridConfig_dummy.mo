within PL_Lib.Configurations;
model ECS_hybridConfig_dummy
  extends PL_Lib.Icons.ConfigurationHybrid_icon;
  extends Templates.ECS_lossless(
    redeclare Components.HX_extFun_dummy PHX,
    redeclare Components.HX_1DShellTube SHX(
      Nnodes=11,
      wnom_c=whex_cold,
      wnom_h=whex_hot),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-140},{300,140}})));
end ECS_hybridConfig_dummy;
