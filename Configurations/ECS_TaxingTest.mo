within PL_Lib.Configurations;
model ECS_TaxingTest
  extends Modelica.Icons.Example;
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";

  parameter Modelica.SIunits.Pressure phex_RA=101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA=101325*2 "initial pressure";

  parameter Modelica.SIunits.Temperature Thex_in_RA=273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA=273.15 + 300;

  extends Templates.ECS_lossless(
    redeclare package HotFluid = HotFluid,
    redeclare package ColdFluid = ColdFluid,
    redeclare Components.HX_extFun_dummy
                                   PHX,
    redeclare Components.HX_1DCoFlow SHX(HX_hotSide(wnom=whex_BA), HX_coldSide(wnom=whex_RA)),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine,
    throughMassFlow_BAin(w0=whex_BA),
    throughMassFlow_RAin(w0=whex_RA*2),
    throughMassFlow_RA_SHXin(w0=whex_RA));

  Modelica.Blocks.Sources.Constant inputT_cold_in(k=Thex_in_RA) annotation (Placement(visible=true, transformation(
        origin={-240,110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputP_cold_in(k=phex_RA) annotation (Placement(visible=true, transformation(
        origin={-240,80},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=Thex_in_BA) annotation (Placement(transformation(extent={{-250,0},{-230,20}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=phex_BA) annotation (Placement(transformation(extent={{-250,-30},{-230,-10}})));
equation
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (Line(points={{-229,110},{-210,110},{-210,59}}, color={0,0,127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (Line(points={{-229,80},{-216,80},{-216,56.4}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-229,80},{-16.45,80},{-16.45,45.95}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkP_RA_SHXout.in_p0) annotation (Line(points={{-229,80},{163.55,80},{163.55,45.95}}, color={0,0,127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-229,-20},{-216,-20},{-216,-33.6}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-229,10},{-210,10},{-210,-31}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ECS_TaxingTest;
