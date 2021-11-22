within PL_Lib.Configurations;
model ECS_hybridConfig
  extends PL_Lib.Icons.ConfigurationHybrid_icon;
  //   parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  //   parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";
  // throughMassFlow_RAin(w0=whex_cold*2),
  // throughMassFlow_RA_SHXin(w0=whex_cold),
  // throughMassFlow_BAin(w0=whex_hot)
  // redeclare Components.HX_1DCounterFlow SHX(wnom_c=whex_cold, wnom_h=whex_hot),
  extends Templates.ECS_lossless(
    redeclare Components.HX_extFun PHX,
    redeclare Components.HX_1DCounterFlow SHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.Compressor_noMaps compressor(Tdes_in=573.15, eta_set=0.8),
    redeclare Components.Turbine_noMaps turbine);
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}})));
end ECS_hybridConfig;
