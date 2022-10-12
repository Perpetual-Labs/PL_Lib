within PL_Lib.Configurations;
model PACK_idealSimpleConfig
  extends PL_Lib.Icons.Configuration_icon;
  extends PL_Lib.Templates.PACK.PACK_idealSimple(redeclare Components.HX_1DCoFlow PHX, redeclare Components.Compressor_noMaps compressor);
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end PACK_idealSimpleConfig;
