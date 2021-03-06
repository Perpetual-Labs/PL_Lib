within PL_Lib.Configurations;
model ECS_baseConfig
  extends PL_Lib.Icons.Configuration_icon;
  //   parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  //   parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";
  // throughMassFlow_RAin(w0=whex_cold*2),
  // throughMassFlow_RA_SHXin(w0=whex_cold),
  // throughMassFlow_BAin(w0=whex_hot
  extends Templates.PACK.ECS_ideal(
    redeclare Components.HX_1DCounterFlow PHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.HX_1DCounterFlow SHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine);
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ECS_baseConfig;
