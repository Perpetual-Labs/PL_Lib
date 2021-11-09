within PL_Lib.Models;
model ECS_HEX_extFun_dummy
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{280, 140}, {300, 160}}, rotation = 0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
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
    Placement(visible = true, transformation(origin = {-300, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(duration = 600, height = -74825, offset = 101325, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-300, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = true, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {-280, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-280, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-180,40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-180,-40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare package Medium = Medium, T0=293.15) annotation (Placement(visible=true, transformation(
        origin={-80,40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Utilities.HX_extFun_dummy PHX_extFun(T_cold_out(displayUnit = "K"), T_hot_out(displayUnit = "K"), p_cold_out(displayUnit = "Pa"), p_hot_out(displayUnit = "Pa"))  annotation (
    Placement(visible = true, transformation(origin = {-130, -2}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_PHX_hot_in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-230, -46}, {-210, -26}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-250, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {250, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_Turbine_out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{270, -46}, {290, -26}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-250, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {150, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, use_in_T = false, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {210, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {310, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_SHX_cold_out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{170, 34}, {190, 54}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin5(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-58, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin6(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin7(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {150, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 100) annotation (
    Placement(visible = true, transformation(origin = {120, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium, Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {0, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {210, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 20, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, noInitialPressure = false, omega = omegahex, pstart = phex_RA, wnom = whex_RA) annotation (
    Placement(visible = true, transformation(origin = {120, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstartbar(displayUnit = "K") = 273.15 + 100, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {120, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{110, -50}, {130, -30}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {120, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor2(
    redeclare package Medium = Medium,
    T0=473.15,
    p0=200000) annotation (Placement(visible=true, transformation(
        origin={-80,-40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_PHX_cold_in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-230, 44}, {-210, 64}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_PHX_cold_out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-40, 34}, {-20, 54}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_PHX_hot_out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-40, -46}, {-20, -26}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_SHX_hot_in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{20, -46}, {40, -26}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_SHX_hot_out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{170, -46}, {190, -26}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow1(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow2(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Line(points = {{-289, 110}, {-280, 110}, {-280, 59}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation (
    Line(points = {{-289, 80}, {-286, 80}, {-286, 56.4}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.T, PHX_extFun.T_cold_in) annotation (
    Line(points = {{-174, 54}, {-156, 54}, {-156, 22}, {-152, 22}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p, PHX_extFun.p_cold_in) annotation (
    Line(points = {{-174, 48}, {-158, 48}, {-158, 16}, {-152, 16}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.d, PHX_extFun.d_cold_in) annotation (
    Line(points = {{-174, 42}, {-162, 42}, {-162, 4}, {-152, 4}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.d, PHX_extFun.d_hot_in) annotation (
    Line(points = {{-174, -38}, {-156, -38}, {-156, -26}, {-152, -26}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.p, PHX_extFun.p_hot_in) annotation (
    Line(points = {{-174, -32}, {-160, -32}, {-160, -14}, {-152, -14}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.T, PHX_extFun.T_hot_in) annotation (
    Line(points = {{-174, -26}, {-162, -26}, {-162, -8}, {-152, -8}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, massFlowToPressureAdaptor1.m_dot) annotation (
    Line(points = {{-86, 26}, {-100, 26}, {-100, 30}, {-160, 30}, {-160, 26}, {-174, 26}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, PHX_extFun.w_cold_in) annotation (
    Line(points = {{-86, 26}, {-100, 26}, {-100, 30}, {-160, 30}, {-160, 10}, {-152, 10}}, color = {0, 0, 127}));
  connect(sensT_PHX_hot_in.outlet, massFlowToPressureAdaptor2.flange) annotation (
    Line(points = {{-214, -40}, {-184, -40}}, color = {159, 159, 223}));
  connect(sensT_PHX_hot_in.inlet, pressDropLin1.outlet) annotation (
    Line(points = {{-226, -40}, {-240, -40}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, sensT_Turbine_out.inlet) annotation (
    Line(points = {{260, -40}, {274, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.flange, pressDropLin3.inlet) annotation (
    Line(points = {{-76, 40}, {-70, 40}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-270, -40}, {-260, -40}}, color = {159, 159, 223}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{12, -80}, {110, -80}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{130, -80}, {198, -80}}));
  connect(sensT_Turbine_out.outlet, sinkPressure2.flange) annotation (
    Line(points = {{286, -40}, {300, -40}}, color = {159, 159, 223}));
  connect(HEX2_RA.outfl, pressDropLin4.inlet) annotation (
    Line(points = {{130, 40}, {140, 40}}, color = {159, 159, 223}));
  connect(HEX2_RA.wall, heatExchangerTopologyFV.side1) annotation (
    Line(points={{120,35},{120,13}},      color = {255, 127, 0}));
  connect(heatExchangerTopologyFV.side2, metalTubeFV2.int) annotation (
    Line(points={{120,6.9},{120,-7}},        color = {255, 127, 0}));
  connect(metalTubeFV2.ext, HEX2_BA.wall) annotation (
    Line(points={{120,-13.1},{120,-35}},        color = {255, 127, 0}));
  connect(HEX2_BA.outfl, pressDropLin7.inlet) annotation (
    Line(points = {{130, -40}, {140, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor2.flange, pressDropLin5.inlet) annotation (
    Line(points = {{-76, -40}, {-68, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor2.m_dot, massFlowToPressureAdaptor2.m_dot) annotation (
    Line(points = {{-86, -54}, {-174, -54}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, PHX_extFun.w_hot_in) annotation (
    Line(points = {{-86, -54}, {-158, -54}, {-158, -20}, {-152, -20}}, color = {0, 0, 127}));
  connect(pressDropLin4.outlet, sensT_SHX_cold_out.inlet) annotation (
    Line(points = {{160, 40}, {174, 40}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, pressDropLin2.inlet) annotation (
    Line(points = {{-270, 50}, {-260, 50}}, color = {159, 159, 223}));
  connect(pressDropLin6.outlet, throughMassFlow.inlet) annotation (
    Line(points = {{70, -40}, {80, -40}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, HEX2_BA.infl) annotation (
    Line(points = {{100, -40}, {110, -40}}, color = {159, 159, 223}));
  connect(PHX_extFun.T_hot_out, pressureToMassFlowAdaptor2.T) annotation (
    Line(points = {{-108, -12}, {-90, -12}, {-90, -26}, {-86, -26}}, color = {0, 0, 127}));
  connect(PHX_extFun.p_hot_out, pressureToMassFlowAdaptor2.p) annotation (
    Line(points = {{-108, -20}, {-92, -20}, {-92, -32}, {-86, -32}}, color = {0, 0, 127}));
  connect(PHX_extFun.p_cold_out, pressureToMassFlowAdaptor1.p) annotation (
    Line(points = {{-108, 8}, {-90, 8}, {-90, 48}, {-86, 48}}, color = {0, 0, 127}));
  connect(PHX_extFun.T_cold_out, pressureToMassFlowAdaptor1.T) annotation (
    Line(points = {{-108, 16}, {-92, 16}, {-92, 54}, {-86, 54}}, color = {0, 0, 127}));
  connect(Turbine.outlet, pressDropLin.inlet) annotation (
    Line(points = {{226, -64}, {234, -64}, {234, -40}, {240, -40}}, color = {159, 159, 223}));
  connect(pressDropLin2.outlet, sensT_PHX_cold_in.inlet) annotation (
    Line(points = {{-240, 50}, {-226, 50}}, color = {159, 159, 223}));
  connect(sensT_PHX_cold_in.outlet, massFlowToPressureAdaptor1.flange) annotation (
    Line(points = {{-214, 50}, {-200, 50}, {-200, 40}, {-184, 40}}, color = {159, 159, 223}));
  connect(pressDropLin3.outlet, sensT_PHX_cold_out.inlet) annotation (
    Line(points = {{-50, 40}, {-36, 40}}, color = {159, 159, 223}));
  connect(pressDropLin5.outlet, sensT_PHX_hot_out.inlet) annotation (
    Line(points = {{-48, -40}, {-36, -40}}, color = {159, 159, 223}));
  connect(sensT_PHX_hot_out.outlet, Compressor.inlet) annotation (
    Line(points = {{-24, -40}, {-20, -40}, {-20, -64}, {-16, -64}}, color = {159, 159, 223}));
  connect(Compressor.outlet, sensT_SHX_hot_in.inlet) annotation (
    Line(points = {{16, -64}, {20, -64}, {20, -40}, {24, -40}}, color = {159, 159, 223}));
  connect(sensT_SHX_hot_in.outlet, pressDropLin6.inlet) annotation (
    Line(points = {{36, -40}, {50, -40}}, color = {159, 159, 223}));
  connect(pressDropLin7.outlet, sensT_SHX_hot_out.inlet) annotation (
    Line(points = {{160, -40}, {174, -40}}, color = {159, 159, 223}));
  connect(sensT_SHX_hot_out.outlet, Turbine.inlet) annotation (
    Line(points = {{186, -40}, {194, -40}, {194, -64}}, color = {159, 159, 223}));
  connect(ramp_P_RAin.y, sinkPressure.in_p0) annotation (
    Line(points={{-289,80},{203.55,80},{203.55,45.95}},
                                                      color = {0, 0, 127}));
  connect(sensT_PHX_cold_out.outlet, throughMassFlow1.inlet) annotation (
    Line(points = {{-24, 40}, {-10, 40}}, color = {159, 159, 223}));
  connect(throughMassFlow2.outlet, HEX2_RA.infl) annotation (
    Line(points = {{100, 40}, {110, 40}}, color = {159, 159, 223}));
  connect(sensT_SHX_cold_out.outlet, sinkPressure.flange) annotation (
    Line(points = {{186, 40}, {200, 40}}, color = {159, 159, 223}));
  connect(sensT_PHX_cold_in.outlet, throughMassFlow2.inlet) annotation (
    Line(points = {{-214, 50}, {-200, 50}, {-200, 66}, {70, 66}, {70, 40}, {80, 40}}, color = {159, 159, 223}));
  connect(throughMassFlow1.outlet, sinkPressure1.flange) annotation (
    Line(points = {{10, 40}, {30, 40}}, color = {159, 159, 223}));
  connect(ramp_P_RAin.y, sinkPressure1.in_p0) annotation (
    Line(points={{-289,80},{33.55,80},{33.55,45.95}},
                                                    color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-300, -140}, {300, 160}}), graphics={  Text(origin = {-240, -20}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)",
            horizontalAlignment =                                                                                                                                                                                              TextAlignment.Left), Text(origin = {-240, 70}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)",
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
end ECS_HEX_extFun_dummy;
