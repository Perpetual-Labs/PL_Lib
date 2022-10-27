within PL_Lib.Components;
model Compressor_supplied
  extends PL_Lib.Icons.Compressor_icon;
  extends ecs_case_study_mo.Compressor;
  PL_Lib.Components.Compressor_noMaps compressor(
    redeclare package Medium = compressorMedium,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (Placement(transformation(extent={{50,-10},{70,10}}), iconTransformation(extent={{50,-10},{70,10}})));
equation
  connect(CompressorInlet, compressor.inlet) annotation (Line(points={{-100,50},{-32,50},{-32,32}}, color={0,0,0}));
  connect(CompressorOutlet, compressor.outlet) annotation (Line(points={{100,50},{32,50},{32,32}}, color={0,0,0}));
  connect(compressor.shaft_b, shaft_b) annotation (Line(points={{24,0},{60,0}}, color={0,0,0}));
end Compressor_supplied;
