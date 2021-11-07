within PL_Lib.Configurations;
model ECS_TaxingTest
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  extends Modelica.Icons.Example;
  extends Templates.ECS_lossless(
    redeclare Components.HX_extFun   PHX,
    redeclare Components.HX_1DCoFlow SHX(redeclare package Medium = Medium),
    redeclare Components.Compressor_noMaps compressor(redeclare package Medium = Medium),
    redeclare Components.Turbine_noMaps turbine(redeclare package Medium = Medium));

  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA=101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA=101325*2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA=273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA=273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA=273.15 + 300;
  parameter Modelica.SIunits.Temperature Thex_out_BA=273.15 + 60;

  Modelica.Blocks.Sources.Constant inputT_cold_in(k=273.15 + 20) annotation (Placement(visible=true, transformation(
        origin={-270,110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputP_cold_in(k=101325) annotation (Placement(visible=true, transformation(
        origin={-270,80},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=273.15 + 300) annotation (Placement(transformation(extent={{-280,0},{-260,20}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=101325*2) annotation (Placement(transformation(extent={{-280,-30},{-260,-10}})));
equation
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (Line(points={{-259,110},{-250,110},{-250,59}}, color={0,0,127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (Line(points={{-259,80},{-256,80},{-256,56.4}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-259,80},{-36.45,80},{-36.45,45.95}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkP_RA_SHXout.in_p0) annotation (Line(points={{-259,80},{143.55,80},{143.55,45.95}}, color={0,0,127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-259,-20},{-256,-20},{-256,-33.6}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-259,10},{-250,10},{-250,-31}}, color={0,0,127}));
end ECS_TaxingTest;
