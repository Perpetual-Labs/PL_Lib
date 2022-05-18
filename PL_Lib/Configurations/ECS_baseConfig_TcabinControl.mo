within PL_Lib.Configurations;
model ECS_baseConfig_TcabinControl
  extends PL_Lib.Icons.Configuration_icon;
  extends Templates.PACK.ECS_ideal_mixer(
    redeclare Components.HX_1DCounterFlow PHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.HX_1DCounterFlow SHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine);
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ECS_baseConfig_TcabinControl;
