within PL_Lib.Models;
model ECS_HEX1_extFun_wip
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{240, 140}, {260, 160}}, rotation = 0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  //  HX Geometry Parameters:
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Integer Nt = 20 "Number of tubes in parallel";
  parameter Modelica.SIunits.Length Lhex = 10 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA = 101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA = 101325 * 2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA = 273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA = 273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA = 273.15 + 200;
  parameter Modelica.SIunits.Temperature Thex_out_BA = 273.15 + 60;
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  Modelica.Blocks.Sources.Ramp ramp_T_RAin(duration = 600, height = -45, offset = Thex_in_RA, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-274, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(duration = 600, height = -74825, offset = 101325, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-274, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-250, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-208, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium, Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {12, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{150, -20}, {170, 0}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 20, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex_RA, wnom = whex_RA) annotation (
    Placement(visible = true, transformation(origin = {160, 70}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {160, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {160, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {132, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{180, -110}, {200, -90}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.8) annotation (
    Placement(visible = true, transformation(origin = {70, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-100,70},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-100,-10},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={40,70},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={40,-10},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Utilities.HX_extFun hX_extFun annotation (
    Placement(visible = true, transformation(origin = {-20, 30}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex_RA, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{60, -110}, {80, -90}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{60, -84}, {80, -64}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step1(height = 500, startTime = 20) annotation (
    Placement(visible = true, transformation(extent = {{40, -60}, {60, -40}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-180, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {94, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {194, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-154, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {94, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT5(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {192, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {264, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow1(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {250, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-214, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {66, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {66, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-180, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow2(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {144, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure1(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {116, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePRC[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
initial equation
  inertia.w = 523.3;
equation
  connect(ramp_T_RAin.y, sourceP_RAin.in_T) annotation (
    Line(points = {{-263, 150}, {-250, 150}, {-250, 89}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation (
    Line(points = {{-263, 120}, {-256, 120}, {-256, 86.4}}, color = {0, 0, 127}));
  connect(HEX2_BA.wall, metalTubeFV2.ext) annotation (
    Line(points = {{160, -5}, {160, 16.9}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV.side2, metalTubeFV2.int) annotation (
    Line(points = {{160, 36.9}, {160, 23}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV.side1, HEX2_RA.wall) annotation (
    Line(points = {{160, 43}, {160, 65}}, color = {255, 127, 0}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{18, -130}, {60, -130}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{80, -130}, {126, -130}}));
  connect(hX_extFun.p_cold_out, pressureToMassFlowAdaptor1.p) annotation (
    Line(points = {{2, 40}, {26, 40}, {26, 78}, {34, 78}}, color = {0, 0, 127}));
  connect(hX_extFun.T_cold_out, pressureToMassFlowAdaptor1.T) annotation (
    Line(points = {{2, 48}, {24, 48}, {24, 84}, {34, 84}}, color = {0, 0, 127}));
  connect(hX_extFun.T_hot_out, pressureToMassFlowAdaptor2.T) annotation (
    Line(points = {{2, 20}, {26, 20}, {26, 4}, {34, 4}}, color = {0, 0, 127}));
  connect(hX_extFun.p_hot_out, pressureToMassFlowAdaptor2.p) annotation (
    Line(points = {{2, 12}, {24, 12}, {24, -2}, {34, -2}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.T, hX_extFun.T_cold_in) annotation (
    Line(points = {{-94, 84}, {-46, 84}, {-46, 54}, {-42, 54}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p, hX_extFun.p_cold_in) annotation (
    Line(points = {{-94, 78}, {-48, 78}, {-48, 48}, {-42, 48}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.d, hX_extFun.d_cold_in) annotation (
    Line(points = {{-94, 72}, {-52, 72}, {-52, 36}, {-42, 36}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.d, hX_extFun.d_hot_in) annotation (
    Line(points = {{-94, -8}, {-46, -8}, {-46, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.p, hX_extFun.p_hot_in) annotation (
    Line(points = {{-94, -2}, {-50, -2}, {-50, 18}, {-42, 18}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.T, hX_extFun.T_hot_in) annotation (
    Line(points = {{-94, 4}, {-52, 4}, {-52, 24}, {-42, 24}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, hX_extFun.w_hot_in) annotation (
    Line(points = {{34, -24}, {-48, -24}, {-48, 12}, {-42, 12}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, massFlowToPressureAdaptor2.m_dot) annotation (
    Line(points = {{34, -24}, {-94, -24}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, hX_extFun.w_cold_in) annotation (
    Line(points = {{34, 56}, {18, 56}, {18, 72}, {-50, 72}, {-50, 42}, {-42, 42}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, massFlowToPressureAdaptor1.m_dot) annotation (
    Line(points = {{34, 56}, {18, 56}, {18, 72}, {-50, 72}, {-50, 56}, {-94, 56}}, color = {0, 0, 127}));
  connect(Step1.y, heatSource1.power) annotation (
    Line(points = {{61, -50}, {70, -50}, {70, -70}}, color = {0, 0, 127}));
  connect(heatSource1.wall, HEX1.wall) annotation (
    Line(points = {{70, -77}, {70, -95}}, color = {255, 127, 0}));
  connect(Compressor.outlet, HEX1.infl) annotation (
    Line(points = {{20, -122}, {32, -122}, {32, -100}, {60, -100}}, color = {159, 159, 223}));
  connect(HEX1.outfl, Turbine.inlet) annotation (
    Line(points = {{80, -100}, {110, -100}, {110, -122}, {124, -122}}, color = {159, 159, 223}));
  connect(sourcePressure.flange, Compressor.inlet) annotation (
    Line(points = {{-20, -100}, {-10, -100}, {-10, -122}, {4, -122}}, color = {159, 159, 223}));
  connect(Turbine.outlet, sinkPressure.flange) annotation (
    Line(points = {{140, -122}, {152, -122}, {152, -100}, {180, -100}}, color = {159, 159, 223}));
  connect(HEX2_RA.outfl, sensT2.inlet) annotation (
    Line(points = {{170, 70}, {188, 70}}, color = {159, 159, 223}));
  connect(sensT3.outlet, massFlowToPressureAdaptor2.flange) annotation (
    Line(points = {{-148, -10}, {-104, -10}}, color = {159, 159, 223}));
  connect(HEX2_BA.outfl, sensT5.inlet) annotation (
    Line(points = {{170, -10}, {186, -10}}, color = {159, 159, 223}));
  connect(sensT5.outlet, sinkMassFlow1.flange) annotation (
    Line(points = {{198, -10}, {240, -10}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, pressDropLin2.inlet) annotation (
    Line(points = {{-240, 80}, {-224, 80}}, color = {159, 159, 223}));
  connect(pressDropLin2.outlet, sensT.inlet) annotation (
    Line(points = {{-204, 80}, {-186, 80}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.flange, pressDropLin.inlet) annotation (
    Line(points = {{44, 70}, {56, 70}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, sensT1.inlet) annotation (
    Line(points = {{76, 70}, {88, 70}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor2.flange, pressDropLin1.inlet) annotation (
    Line(points = {{44, -10}, {56, -10}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensT4.inlet) annotation (
    Line(points = {{76, -10}, {88, -10}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, pressDropLin3.inlet) annotation (
    Line(points = {{-198, -10}, {-190, -10}}, color = {159, 159, 223}));
  connect(pressDropLin3.outlet, sensT3.inlet) annotation (
    Line(points = {{-170, -10}, {-160, -10}}, color = {159, 159, 223}));
  connect(sensT4.outlet, sinkMassFlow2.flange) annotation (
    Line(points = {{100, -10}, {114, -10}, {114, -42}, {134, -42}}, color = {159, 159, 223}));
  connect(sourcePressure1.flange, HEX2_BA.infl) annotation (
    Line(points = {{126, 16}, {138, 16}, {138, -10}, {150, -10}}, color = {159, 159, 223}));
  connect(sensT2.outlet, sinkMassFlow.flange) annotation (
    Line(points = {{200, 70}, {222, 70}, {222, 80}, {254, 80}}, color = {159, 159, 223}));
  connect(sensT.outlet, massFlowToPressureAdaptor1.flange) annotation (
    Line(points = {{-174, 80}, {-144, 80}, {-144, 70}, {-104, 70}}, color = {159, 159, 223}));
  connect(sensT1.outlet, HEX2_RA.infl) annotation (
    Line(points = {{100, 70}, {150, 70}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-240, -140}, {260, 160}}), graphics={  Text(origin = {-198, 10}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)",
            horizontalAlignment =                                                                                                                                                                                             TextAlignment.Left), Text(origin = {-214, 130}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)",
            horizontalAlignment =                                                                                                                                                                                                        TextAlignment.Left)}),
    experiment(StopTime = 3000, Tolerance = 1e-06, StartTime = 0, Interval = 6),
    Documentation(info = "<html>
<p>The model is designed to test the component <code>Gas.Flow1DFV</code> (fluid side of a heat exchanger, finite volumes). A uniform prescribed heat flux is applied to the lateral boundary. The working fluid is pure nitrogen.</p>
<p>The model starts at steady state. </p>
<p><ul>
<li>At t = 10 s, step variation of the temperature of the fluid entering the heat exchanger. The temperature change is propagated at the outlet with a delay approximately equal to the residence time</li>
<li>At t = 20 s, a thermal power flow W is applied to the heat exchanger lateral surface. The outlet temperature undergoes a ramp change, whose duration is approximately equal to the residence time, and whose amplitude is equal to W/(whex*cp)</li>
<li>At t = 50 s, step reduction of the outlet valve opening</li>
</ul></p>
<p>Simulation Interval = [0...80] sec </p>
<p>Integration Algorithm = DASSL </p>
<p>Algorithm Tolerance = 1e-6 </p>
</html>"),
    __Dymola_experimentSetupOutput);
end ECS_HEX1_extFun_wip;
