within PL_Lib.Configurations;
model ECS_hybridConfig
  extends PL_Lib.Icons.ConfigurationHybrid_icon;
  extends Templates.PACK.ECS_ideal_mixer(
    redeclare Components.HX_extFun       PHX,
    redeclare Components.HX_1DCoFlow SHX(
      Nnodes=11,
      Lhex=1,
      pstart_h=101325*5,
      Tstartbar_wall=273.15 + 140),
    redeclare Components.Compressor_noMaps compressor(
      pstart_in=200000,
      pstart_out=500000,
      Tdes_in=573.15),
    redeclare Components.Turbine_noMaps turbine(
      pstart_in=500000,
      pstart_out=100000,
      phic_set=6e-7));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-100},{300,100}})));
end ECS_hybridConfig;
