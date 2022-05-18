within PL_Lib.Configurations;
model PACK_simple
  extends Templates.PACK.PACK_simpleTemplate(redeclare Components.HX_1DCoFlow_mass PHX, redeclare Components.Compressor_noMaps_mass compressor);
end PACK_simple;
