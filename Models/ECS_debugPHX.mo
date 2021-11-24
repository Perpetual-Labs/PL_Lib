within PL_Lib.Models;

model ECS_debugPHX
  //   extends PL_Lib.Interfaces.ConfigurationBase;
  extends Modelica.Icons.Example;
  import SI = Modelica.SIunits;
  parameter SI.Time t_takeoff = 300;
  parameter SI.Time t_startCruise = 600;
  parameter SI.MassFlowRate whex_RA = 0.025 "nominal (and initial) mass flow rate";
  parameter SI.MassFlowRate whex_BA = 0.025 "nominal (and initial) mass flow rate";
  parameter SI.Pressure phex_RA_00km = 101325 "Initial pressure";
  parameter SI.Pressure phex_RA_10km = 26500 "Atmospheric pressure at 10km elevation";
  parameter SI.Pressure phex_BA_00km = 206843 "Bleed air pressure (minimum)";
  parameter SI.Pressure phex_BA_10km = 344748 "Bleed air pressure (maximum)";
  parameter SI.Temperature Thex_in_RA_00km = 273.15 + 20 "initial inlet temperature at ground level";
  parameter SI.Temperature Thex_in_RA_10km = 273.15 - 25 "Inlet ram air temperature at 10km elevation";
  parameter SI.Temperature Thex_in_BA_00km = 273.15 + 300 "Bleed air temperature (minimum)";
  parameter SI.Temperature Thex_in_BA_10km = 273.15 + 400 "Bleed air temperature (maximum)";
  //  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  //  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";
  //   replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  //   replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
    
  replaceable PL_Lib.Components.HX_extFun_dummy PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) constrainedby Interfaces.HeatExchangerBase(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation(
     choicesAllMatching = true,
     Placement(transformation(extent = {{-150, -18}, {-110, 22}})));
  replaceable PL_Lib.Components.HX_1DCoFlow SHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid, Lhex = 1, Nnodes = 11, Tstartbar_wall = 413.15, pstart_h = 499999.9999999999) constrainedby Interfaces.HeatExchangerBase(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation(
     choicesAllMatching = true,
     Placement(transformation(extent = {{70, -20}, {110, 20}})));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, p0 = 10000, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, p0 = 10000, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(extent = {{190, 30}, {210, 50}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{330, -20}, {350, 0}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(origin = {-80, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(origin = {140, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(origin = {40, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{-190, -46}, {-170, -26}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(origin = {-180, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{-90, 34}, {-70, 54}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(origin = {140, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_SHXin(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{30, 34}, {50, 54}}, rotation = 0)));
  replaceable Modelica.Blocks.Sources.Ramp inputT_cold_in(height = Thex_in_RA_10km - Thex_in_RA_00km, duration = t_startCruise, offset = Thex_in_RA_00km, startTime = t_takeoff) constrainedby Modelica.Blocks.Sources.Ramp annotation(
     Placement(transformation(extent = {{-280, 110}, {-260, 130}})));
  replaceable Modelica.Blocks.Sources.Ramp inputP_cold_in(height = phex_RA_10km - phex_RA_00km, duration = t_startCruise, offset = phex_RA_00km, startTime = t_takeoff) constrainedby Modelica.Blocks.Sources.Ramp annotation(
     Placement(transformation(extent = {{-280, 70}, {-260, 90}})));
  replaceable Modelica.Blocks.Sources.Constant inputT_hot_in(k = Thex_in_BA_00km) constrainedby Modelica.Blocks.Sources.Constant annotation(
     Placement(transformation(extent = {{-280, 10}, {-260, 30}})));
  replaceable Modelica.Blocks.Sources.Constant inputP_hot_in(k = phex_BA_00km) constrainedby Modelica.Blocks.Sources.Constant annotation(
     Placement(transformation(extent = {{-280, -28}, {-260, -8}})));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(extent = {{280, 80}, {300, 100}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_PHXin(redeclare package Medium = ColdFluid, p0 = 101325, use_in_T = true, w0 = whex_RA) annotation(
    Placement(visible = true, transformation(origin = {-220, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_SHXin(redeclare package Medium = ColdFluid, T = Thex_in_RA_10km, p0 = 101325, use_in_T = true, w0 = whex_RA) annotation(
    Placement(visible = true, transformation(origin = {10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps compressor(redeclare package Medium = HotFluid, Tdes_in = 573.15, Tstart_out = 573.15, pstart_in = 101325 * 2, pstart_out = 101325 * 5) annotation(
    Placement(visible = true, transformation(extent = {{-60, -90}, {-20, -50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J_shaft, w(fixed = false, start = w0)) annotation(
    Placement(visible = true, transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps turbine(redeclare package Medium = HotFluid, Tdes_in = 573.15, Tstart_out = 573.15, phic_set = 7e-7, pstart_in = 101325 * 5, pstart_out = 101325) annotation(
    Placement(visible = true, transformation(extent = {{160, -90}, {200, -50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(origin = {220, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_BA_PACKout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{210, -20}, {230, 0}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = HotFluid, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-240, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Tcabin_set(height = 4, offset = 273.15 + 22, startTime = 500) annotation(
    Placement(visible = true, transformation(origin = {288, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Mixer mixer(redeclare package Medium = HotFluid, V = 0.01, pstart = 101325) annotation(
    Placement(visible = true, transformation(origin = {270, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = HotFluid, T = Thex_in_BA_00km, use_in_w0 = true)  annotation(
    Placement(visible = true, transformation(origin = {244, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(origin = {306, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID(Td = 0,Ti = 60, k = 0.4, limitsAtInit = true, yMax = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {330, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  ThermoPower.Gas.SensP sensP_RA_PHXin(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{-190, 10}, {-170, 30}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_RA_PHXout(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{-90, 10}, {-70, 30}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_RA_SHXin(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{30, 10}, {50, 30}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_RA_SHXout(redeclare package Medium = ColdFluid) annotation(
    Placement(visible = true, transformation(extent = {{130, 10}, {150, 30}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_BA_PHXin(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{-190, -20}, {-170, 0}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_BA_PHXout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{-90, -20}, {-70, 0}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_BA_SHXin(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{30, -20}, {50, 0}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP_BA_SHXout(redeclare package Medium = HotFluid) annotation(
    Placement(visible = true, transformation(extent = {{130, -20}, {150, 0}}, rotation = 0)));
  parameter Modelica.SIunits.Inertia J_shaft = 1000;
  parameter Modelica.SIunits.AngularVelocity w0 = 523.3;
equation
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation(
    Line(points = {{-110, 12}, {-100, 12}, {-100, 16}, {-96, 16}, {-96, 40}, {-86, 40}}, color = {159, 159, 223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation(
    Line(points = {{-110, -8}, {-100, -8}, {-100, -14}, {-96, -14}, {-96, -40}, {-86, -40}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation(
    Line(points = {{-174, 40}, {-160, 40}, {-160, 12}, {-150, 12}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation(
    Line(points = {{-174, -40}, {-160, -40}, {-160, -8}, {-150, -8}}, color = {159, 159, 223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation(
    Line(points = {{110, 10}, {120, 10}, {120, 40}, {134, 40}}, color = {159, 159, 223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation(
    Line(points = {{110, -10}, {120, -10}, {120, -40}, {134, -40}}, color = {159, 159, 223}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation(
    Line(points = {{46, -40}, {60, -40}, {60, -10}, {70, -10}}, color = {159, 159, 223}));
  connect(sensT_RA_SHXin.outlet, SHX.infl_1) annotation(
    Line(points = {{46, 40}, {60, 40}, {60, 10}, {70, 10}}, color = {159, 159, 223}));
  connect(PHX.outfl_2, sensP_BA_PHXout.flange) annotation(
    Line(points = {{-110, -8}, {-100, -8}, {-100, -14}, {-96, -14}, {-96, -22}, {-64, -22}, {-64, -14}, {-80, -14}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, sensP_BA_PHXin.flange) annotation(
    Line(points = {{-174, -40}, {-160, -40}, {-160, -14}, {-180, -14}}, color = {159, 159, 223}));
  connect(sensT_BA_SHXin.outlet, sensP_BA_SHXin.flange) annotation(
    Line(points = {{46, -40}, {60, -40}, {60, -14}, {40, -14}}, color = {159, 159, 223}));
  connect(SHX.outfl_2, sensP_BA_SHXout.flange) annotation(
    Line(points = {{110, -10}, {120, -10}, {120, -14}, {140, -14}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, sensP_RA_PHXin.flange) annotation(
    Line(points = {{-174, 40}, {-160, 40}, {-160, 16}, {-180, 16}}, color = {159, 159, 223}));
  connect(PHX.outfl_1, sensP_RA_PHXout.flange) annotation(
    Line(points = {{-110, 12}, {-100, 12}, {-100, 16}, {-96, 16}, {-96, 32}, {-68, 32}, {-68, 16}, {-80, 16}}, color = {159, 159, 223}));
  connect(sensT_RA_SHXin.outlet, sensP_RA_SHXin.flange) annotation(
    Line(points = {{46, 40}, {60, 40}, {60, 16}, {40, 16}}, color = {159, 159, 223}));
  connect(SHX.outfl_1, sensP_RA_SHXout.flange) annotation(
    Line(points = {{110, 10}, {120, 10}, {120, 16}, {140, 16}}, color = {159, 159, 223}));
  connect(sourceMassFlow_RA_PHXin.flange, sensT_RA_PHXin.inlet) annotation(
    Line(points = {{-210, 40}, {-186, 40}}, color = {159, 159, 223}));
  connect(sourceMassFlow_RA_SHXin.flange, sensT_RA_SHXin.inlet) annotation(
    Line(points = {{20, 40}, {34, 40}}, color = {159, 159, 223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation(
    Line(points = {{-28, -70}, {80, -70}}));
  connect(inertia.flange_b, turbine.shaft_a) annotation(
    Line(points = {{100, -70}, {168, -70}}));
  connect(turbine.outlet, sensT_BA_PACKout.inlet) annotation(
    Line(points = {{196, -54}, {196, -40}, {214, -40}}, color = {159, 159, 223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation(
    Line(points = {{-24, -54}, {-24, -40}, {34, -40}}, color = {159, 159, 223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation(
    Line(points = {{146, -40}, {164, -40}, {164, -54}}, color = {159, 159, 223}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation(
    Line(points = {{-259, 20}, {-240, 20}, {-240, -31}}, color = {0, 0, 127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation(
    Line(points = {{-259, -18}, {-246, -18}, {-246, -33.6}}, color = {0, 0, 127}));
  connect(sensT_BA_PHXout.outlet, compressor.inlet) annotation(
    Line(points = {{-74, -40}, {-56, -40}, {-56, -54}}, color = {159, 159, 223}));
  connect(turbine.outlet, sensP_BA_PACKout.flange) annotation(
    Line(points = {{196, -54}, {196, -40}, {208, -40}, {208, -14}, {220, -14}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, sensT_BA_PHXin.inlet) annotation(
    Line(points = {{-230, -40}, {-186, -40}}, color = {159, 159, 223}));
  connect(inputT_cold_in.y, sourceMassFlow_RA_PHXin.in_T) annotation(
    Line(points = {{-259, 120}, {-220, 120}, {-220, 45}}, color = {0, 0, 127}));
  connect(inputT_cold_in.y, sourceMassFlow_RA_SHXin.in_T) annotation(
    Line(points = {{-259, 120}, {10, 120}, {10, 45}}, color = {0, 0, 127}));
  connect(inputP_cold_in.y, sinkP_RA_PHXout.in_p0) annotation(
    Line(points = {{-259, 80}, {-266, 80}, {-266, 86}, {-26.45, 86}, {-26.45, 45.95}}, color = {0, 0, 127}));
  connect(inputP_cold_in.y, sinkP_RA_SHXout.in_p0) annotation(
    Line(points = {{-259, 80}, {-266, 80}, {-266, 86}, {193.55, 86}, {193.55, 45.95}}, color = {0, 0, 127}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation(
    Line(points = {{-74, 40}, {-30, 40}}, color = {159, 159, 223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation(
    Line(points = {{146, 40}, {190, 40}}, color = {159, 159, 223}));
  connect(sourceMassFlow.flange, mixer.in1) annotation(
    Line(points = {{254, 22}, {262, 22}, {262, -4}}, color = {159, 159, 223}));
  connect(sensT_BA_PACKout.outlet, mixer.in2) annotation(
    Line(points = {{226, -40}, {262, -40}, {262, -16}}, color = {159, 159, 223}));
  connect(mixer.out, sensT.inlet) annotation(
    Line(points = {{280, -10}, {300, -10}}, color = {159, 159, 223}));
  connect(sensT.outlet, sinkP_PACKout.flange) annotation(
    Line(points = {{312, -10}, {330, -10}}, color = {159, 159, 223}));
  connect(Tcabin_set.y, PID.u_s) annotation(
    Line(points = {{300, 32}, {318, 32}}, color = {0, 0, 127}));
  connect(sensT.T, PID.u_m) annotation(
    Line(points = {{314, 0}, {330, 0}, {330, 20}}, color = {0, 0, 127}));
  connect(PID.y, sourceMassFlow.in_w0) annotation(
    Line(points = {{342, 32}, {352, 32}, {352, 54}, {238, 54}, {238, 28}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}}), graphics = {Text(origin = {-230, -60}, lineColor = {238, 46, 47}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Left), Text(origin = {-230, 30}, lineColor = {28, 108, 200}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)", textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Left)}),
    experiment(StartTime = 0, StopTime = 1500, Tolerance = 1e-06, Interval = 3));
end ECS_debugPHX;
