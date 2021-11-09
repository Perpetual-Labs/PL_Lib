within PL_Lib.Configurations;
model ECS_TakeOffTest
//   extends Modelica.Icons.Example;
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.Time t_takeoff=300;
  parameter Modelica.SIunits.Time t_startCruise=600;

  parameter Modelica.SIunits.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";

  parameter Modelica.SIunits.Pressure phex_RA_00km=101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_RA_10km=26500 "Atmospheric pressure at 10km elevation";
  parameter Modelica.SIunits.Pressure phex_BA=101325*2 "initial pressure";

  parameter Modelica.SIunits.Temperature Thex_in_RA_00km=273.15 + 20 "initial inlet temperature at ground level";
  parameter Modelica.SIunits.Temperature Thex_in_RA_10km=273.15 - 25 "Inlet ram air temperature at 10km elevation";
  parameter Modelica.SIunits.Temperature Thex_in_BA=273.15 + 300;

  extends Templates.ECS_lossless(
    redeclare package HotFluid = HotFluid,
    redeclare package ColdFluid = ColdFluid,
    redeclare Components.HX_1DCounterFlow PHX(HX_hotSide(wnom=whex_BA), HX_coldSide(wnom=whex_RA)),
    redeclare Components.HX_1DCounterFlow SHX(HX_hotSide(wnom=whex_BA), HX_coldSide(wnom=whex_RA)),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine,
    throughMassFlow_BAin(w0=whex_BA),
    throughMassFlow_RAin(w0=whex_RA*2),
    throughMassFlow_RA_SHXin(w0=whex_RA));

  Modelica.Blocks.Sources.Constant inputT_hot_in(k=Thex_in_BA) annotation (Placement(transformation(extent={{-250,0},{-230,20}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=phex_BA) annotation (Placement(transformation(extent={{-250,-30},{-230,-10}})));
  Modelica.Blocks.Sources.Ramp inputT_cold_in(
    duration=t_startCruise,
    height=Thex_in_RA_10km - Thex_in_RA_00km,
    offset=Thex_in_RA_00km,
    startTime=t_takeoff) annotation (Placement(visible=true, transformation(
        origin={-240,110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp inputP_cold_in(
    duration=t_startCruise,
    height=phex_RA_10km - phex_RA_00km,
    offset=phex_RA_00km,
    startTime=t_takeoff) annotation (Placement(visible=true, transformation(
        origin={-240,80},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Interfaces.SignalBus signalBus annotation (Placement(visible = true, transformation(extent = {{260, 20}, {300, 60}}, rotation = 0), iconTransformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
equation
  connect(inputP_cold_in.y, sinkP_RA_SHXout.in_p0) annotation (
    Line(points = {{-229, 80}, {164, 80}, {164, 45.95}, {163.55, 45.95}}, color = {0, 0, 127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (
    Line(points = {{-229, 80}, {-216, 80}, {-216, 56.4}}, color = {0, 0, 127}));
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (
    Line(points = {{-229, 110}, {-210, 110}, {-210, 59}}, color = {0, 0, 127}));
  connect(inputP_cold_in.y, sinkP_RA_PHXout.in_p0) annotation (
    Line(points = {{-229, 80}, {-16.45, 80}, {-16.45, 45.95}}, color = {0, 0, 127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (
    Line(points = {{-229, 10}, {-210, 10}, {-210, -31}}, color = {0, 0, 127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (
    Line(points = {{-229, -20}, {-216, -20}, {-216, -33.6}}, color = {0, 0, 127}));
  connect(sensT_BA_PHXin.T, signalBus.T_BA_PHXin) annotation (Line(points={{-133,-30},{-130,-30},{-130,-120},{280,-120},{280,40}}, color={0,0,127}));
  connect(sensT_RA_PHXin.T, signalBus.T_RA_PHXin) annotation (Line(points={{-133,50},{-128,50},{-128,-118},{280,-118},{280,40}}, color={0,0,127}));
  connect(sensT_BA_PHXout.T, signalBus.T_BA_PHXout) annotation (Line(points={{-33,-34},{-30,-34},{-30,-116},{280,-116},{280,40}}, color={0,0,127}));
  connect(sensT_RA_PHXout.T, signalBus.T_RA_PHXout) annotation (Line(points={{-33,50},{-28,50},{-28,-114},{280,-114},{280,40}}, color={0,0,127}));
  connect(sensT_BA_SHXin.T, signalBus.T_BA_SHXin) annotation (Line(points={{47,-34},{50,-34},{50,-112},{280,-112},{280,40}}, color={0,0,127}));
  connect(sensT_BA_SHXout.T, signalBus.T_BA_SHXout) annotation (Line(points={{147,-34},{150,-34},{150,-110},{280,-110},{280,40}}, color={0,0,127}));
  connect(sensT_RA_SHXout.T, signalBus.T_RA_SHXout) annotation (Line(points={{147,50},{152,50},{152,-108},{280,-108},{280,40}}, color={0,0,127}));
  connect(sensT_BA_PACKout.T, signalBus.T_BA_PACKout) annotation (Line(points={{227,-34},{230,-34},{230,-106},{280,-106},{280,40}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-6, Interval = 2));
end ECS_TakeOffTest;
