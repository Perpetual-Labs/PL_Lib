within PL_Lib.Configurations;
model ECS_CruisingTest
  extends Modelica.Icons.Example;
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  extends Templates.ECS_lossless(
    redeclare Components.HX_1DCounterFlow
                                   PHX,
    redeclare Components.HX_1DCoFlow SHX,
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine);
  Modelica.Blocks.Sources.Constant inputT_cold_in(k=273.15 + 20) annotation (Placement(visible=true, transformation(
        origin={-228,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputP_cold_in(k=101325) annotation (Placement(visible=true, transformation(
        origin={-260,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=273.15 + 300) annotation (Placement(transformation(extent={{-240,2},{-220,22}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=101325*2) annotation (Placement(transformation(extent={{-260,-30},{-240,-10}})));
equation
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (Line(points={{-217,90},{-210,90},{-210,59}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-219,12},{-210,12},{-210,-31}},   color={0,0,127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (Line(points={{-249,70},{-216,70},{-216,56.4}}, color={0,0,127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-239,-20},{-216,-20},{-216,-33.6}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ECS_CruisingTest;
