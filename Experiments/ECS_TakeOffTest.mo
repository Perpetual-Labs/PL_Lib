within PL_Lib.Experiments;
model ECS_TakeOffTest
  extends Modelica.Icons.Example;
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

  replaceable Configurations.ECS_hybridConfig
                                            ecs_lossless_config(
    redeclare package HotFluid = HotFluid,
    redeclare package ColdFluid = ColdFluid,
    whex_hot=whex_BA,
    whex_cold=whex_RA) constrainedby Templates.ECS_lossless(redeclare package HotFluid = HotFluid, redeclare package ColdFluid = ColdFluid) annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

  Modelica.Blocks.Sources.Constant inputT_hot_in(k=Thex_in_BA) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=phex_BA) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.Ramp inputT_cold_in(
    duration=t_startCruise,
    height=Thex_in_RA_10km - Thex_in_RA_00km,
    offset=Thex_in_RA_00km,
    startTime=t_takeoff) annotation (Placement(visible=true, transformation(
        origin={-70,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp inputP_cold_in(
    duration=t_startCruise,
    height=phex_RA_10km - phex_RA_00km,
    offset=phex_RA_00km,
    startTime=t_takeoff) annotation (Placement(visible=true, transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Utilities.DataLogger dataLogger annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(inputT_cold_in.y, ecs_lossless_config.T_cold_in) annotation (Line(points={{-59,50},{-40,50},{-40,24},{-30,24}}, color={0,0,127}));
  connect(inputP_cold_in.y, ecs_lossless_config.p_cold_in) annotation (Line(points={{-59,20},{-42,20},{-42,9},{-30,9}}, color={0,0,127}));
  connect(inputT_hot_in.y, ecs_lossless_config.T_hot_in) annotation (Line(points={{-59,-20},{-42,-20},{-42,-9},{-30,-9}}, color={0,0,127}));
  connect(inputP_hot_in.y, ecs_lossless_config.p_hot_in) annotation (Line(points={{-59,-50},{-40,-50},{-40,-24},{-30,-24}}, color={0,0,127}));
  connect(ecs_lossless_config.signalBus, dataLogger.signalBus) annotation (Line(
      points={{30,0},{40,0}},
      color={255,204,51},
      thickness=0.5));
end ECS_TakeOffTest;
