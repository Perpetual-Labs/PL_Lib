within PL_Lib.Configurations;
model PACK_simpleConfig
  extends Templates.PACK.PACK_simpleTemplate(redeclare Components.HX_1DCoFlow      PHX, redeclare Components.Compressor_noMaps      compressor);
end PACK_simpleConfig;
