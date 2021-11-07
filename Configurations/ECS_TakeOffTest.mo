within PL_Lib.Configurations;
model ECS_TakeOffTest
  extends Modelica.Icons.Example;
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA=101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA=101325*2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA=273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA=273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA=273.15 + 300;
  parameter Modelica.SIunits.Temperature Thex_out_BA=273.15 + 60;

  extends Templates.ECS_lossless(
    redeclare package HotFluid = HotFluid,
    redeclare package ColdFluid = ColdFluid,
    redeclare Components.HX_1DCoFlow PHX(HX_hotSide(wnom=whex_BA), HX_coldSide(wnom=whex_RA)),
    redeclare Components.HX_1DCoFlow SHX(HX_hotSide(wnom=whex_BA), HX_coldSide(wnom=whex_RA)),
    redeclare Components.Compressor_noMaps compressor(
      Ndesign=523.3,
      PR_set=2.5,
      Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
      Tdes_in=363.15,
      Tstart_in=273.15 + 90,
      Tstart_out=273.15 + 200,
      eta_set=0.9,
      pstart_in=200000,
      pstart_out=500000),
    redeclare Components.Turbine_noMaps turbine(
      Ndesign=523.3,
      Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
      Tdes_in=1400,
      Tstart_in=1270,
      Tstart_out=883,
      pstart_in=785000,
      pstart_out=152000),
    throughMassFlow_RAin(w0=0.5),
    throughMassFlow_RA_SHXin(w0=0.25),
    throughMassFlow_BAin(w0=0.25),
    sourceP_BAin(T(displayUnit="K")),
    sourceP_RAin(T(displayUnit="K")));

  // INPUTS
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=273.15 + 300) annotation (Placement(transformation(extent={{-290,0},{-270,20}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=101325*2) annotation (Placement(transformation(extent={{-290,-30},{-270,-10}})));
  Modelica.Blocks.Sources.Ramp inputT_cold_in(
    duration=600,
    height=-45,
    offset=273.15 + 20,
    startTime=300) annotation (Placement(visible=true, transformation(
        origin={-280,110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp inputP_cold_in(
    duration=600,
    height=-74825,
    offset=101325,
    startTime=300) annotation (Placement(visible=true, transformation(
        origin={-280,80},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(inputP_cold_in.y, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-269,80},{-36,80},{-36,45.95},{-36.45,45.95}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkP_RA_SHXout.in_p0) annotation (Line(points={{-269,80},{144,80},{144,45.95},{143.55,45.95}}, color={0,0,127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (Line(points={{-269,80},{-256,80},{-256,56.4}}, color={0,0,127}));
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (Line(points={{-269,110},{-250,110},{-250,59}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-269,10},{-250,10},{-250,-31}}, color={0,0,127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-269,-20},{-256,-20},{-256,-33.6}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-260,-100},{240,100}})));
end ECS_TakeOffTest;
