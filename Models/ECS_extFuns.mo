within PL_Lib.Models;
model ECS_extFuns
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{240, 140}, {260, 160}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {-314, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(duration = 600, height = -74825, offset = 101325, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-314, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = true, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {-290, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-280, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-200, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor1(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-160, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-160, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor2(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.HX_extFun PHX_extFun annotation (
    Placement(visible = true, transformation(origin = {-110, -2}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter4(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {150, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.HX_extFun SHX_extFun annotation (
    Placement(visible = true, transformation(origin = {100, -2}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter4(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {50, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter3(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {150, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter3(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-202, -46}, {-182, -26}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-216, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {270, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{290, -46}, {310, -26}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-228, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {180, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {26, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {284, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {356, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{244, 34}, {264, 54}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin5(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-38, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin6(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {26, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin7(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {176, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {208, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow1(redeclare package Medium = Medium, w0 = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {220, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow2(redeclare package Medium = Medium, w0 = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {-2, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 100) annotation (
    Placement(visible = true, transformation(origin = {110, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium, Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {180, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
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
    Line(points = {{-303, 120}, {-290, 120}, {-290, 59}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation (
    Line(points = {{-303, 90}, {-296, 90}, {-296, 56.4}}, color = {0, 0, 127}));
  connect(flowSplit.outlet2, massFlowToPressureAdaptor1.flange) annotation (
    Line(points = {{-194, 46}, {-180, 46}, {-180, 40}, {-164, 40}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdaptor1.T, PHX_extFun.T_cold_in) annotation (
    Line(points = {{-154, 54}, {-136, 54}, {-136, 22}, {-132, 22}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p, PHX_extFun.p_cold_in) annotation (
    Line(points = {{-154, 48}, {-138, 48}, {-138, 16}, {-132, 16}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.d, PHX_extFun.d_cold_in) annotation (
    Line(points = {{-154, 42}, {-142, 42}, {-142, 4}, {-132, 4}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.d, PHX_extFun.d_hot_in) annotation (
    Line(points = {{-154, -38}, {-136, -38}, {-136, -26}, {-132, -26}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.p, PHX_extFun.p_hot_in) annotation (
    Line(points = {{-154, -32}, {-140, -32}, {-140, -14}, {-132, -14}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.T, PHX_extFun.T_hot_in) annotation (
    Line(points = {{-154, -26}, {-142, -26}, {-142, -8}, {-132, -8}}, color = {0, 0, 127}));
  connect(PHX_extFun.p_cold_out, pressureToMassFlowAdaptor1.p) annotation (
    Line(points = {{-88, 8}, {-70, 8}, {-70, 48}, {-66, 48}}, color = {0, 0, 127}));
  connect(PHX_extFun.T_cold_out, pressureToMassFlowAdaptor1.T) annotation (
    Line(points = {{-88, 16}, {-72, 16}, {-72, 54}, {-66, 54}}, color = {0, 0, 127}));
  connect(PHX_extFun.T_hot_out, pressureToMassFlowAdaptor2.T) annotation (
    Line(points = {{-88, -12}, {-70, -12}, {-70, -26}, {-66, -26}}, color = {0, 0, 127}));
  connect(PHX_extFun.p_hot_out, pressureToMassFlowAdaptor2.p) annotation (
    Line(points = {{-88, -20}, {-72, -20}, {-72, -32}, {-66, -32}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, massFlowToPressureAdaptor1.m_dot) annotation (
    Line(points = {{-66, 26}, {-80, 26}, {-80, 30}, {-140, 30}, {-140, 26}, {-154, 26}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, PHX_extFun.w_cold_in) annotation (
    Line(points = {{-66, 26}, {-80, 26}, {-80, 30}, {-140, 30}, {-140, 10}, {-132, 10}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, PHX_extFun.w_hot_in) annotation (
    Line(points = {{-66, -54}, {-138, -54}, {-138, -20}, {-132, -20}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, massFlowToPressureAdaptor2.m_dot) annotation (
    Line(points = {{-66, -54}, {-154, -54}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter3.T, SHX_extFun.T_cold_in) annotation (
    Line(points = {{56, 54}, {74, 54}, {74, 22}, {78, 22}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter3.p, SHX_extFun.p_cold_in) annotation (
    Line(points = {{56, 48}, {72, 48}, {72, 16}, {78, 16}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter3.d, SHX_extFun.d_cold_in) annotation (
    Line(points = {{56, 42}, {68, 42}, {68, 4}, {78, 4}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.d, SHX_extFun.d_hot_in) annotation (
    Line(points = {{56, -38}, {74, -38}, {74, -26}, {78, -26}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.p, SHX_extFun.p_hot_in) annotation (
    Line(points = {{56, -32}, {70, -32}, {70, -14}, {78, -14}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.T, SHX_extFun.T_hot_in) annotation (
    Line(points = {{56, -26}, {68, -26}, {68, -8}, {78, -8}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter3.m_dot, massFlowToPressureAdapter3.m_dot) annotation (
    Line(points = {{144, 26}, {130, 26}, {130, 30}, {70, 30}, {70, 26}, {56, 26}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter3.m_dot, SHX_extFun.w_cold_in) annotation (
    Line(points = {{144, 26}, {130, 26}, {130, 30}, {70, 30}, {70, 10}, {78, 10}}, color = {0, 0, 127}));
  connect(SHX_extFun.T_hot_out, pressureToMassFlowAdapter4.T) annotation (
    Line(points = {{122, -12}, {140, -12}, {140, -26}, {144, -26}}, color = {0, 0, 127}));
  connect(SHX_extFun.p_hot_out, pressureToMassFlowAdapter4.p) annotation (
    Line(points = {{122, -20}, {138, -20}, {138, -32}, {144, -32}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter4.m_dot, massFlowToPressureAdapter4.m_dot) annotation (
    Line(points = {{144, -54}, {56, -54}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter4.m_dot, SHX_extFun.w_hot_in) annotation (
    Line(points = {{144, -54}, {72, -54}, {72, -20}, {78, -20}}, color = {0, 0, 127}));
  connect(SHX_extFun.p_cold_out, pressureToMassFlowAdapter3.p) annotation (
    Line(points = {{122, 8}, {140, 8}, {140, 48}, {144, 48}}, color = {0, 0, 127}));
  connect(SHX_extFun.T_cold_out, pressureToMassFlowAdapter3.T) annotation (
    Line(points = {{122, 16}, {138, 16}, {138, 54}, {144, 54}}, color = {0, 0, 127}));
  connect(sensT1.outlet, massFlowToPressureAdaptor2.flange) annotation (
    Line(points = {{-186, -40}, {-164, -40}}, color = {159, 159, 223}));
  connect(sensT1.inlet, pressDropLin1.outlet) annotation (
    Line(points = {{-198, -40}, {-206, -40}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, sensT.inlet) annotation (
    Line(points = {{280, -40}, {294, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.flange, pressDropLin3.inlet) annotation (
    Line(points = {{-56, 40}, {-40, 40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdapter3.flange, pressDropLin4.inlet) annotation (
    Line(points = {{154, 40}, {170, 40}}, color = {159, 159, 223}));
  connect(sensT2.outlet, sinkPressure1.flange) annotation (
    Line(points = {{260, 40}, {274, 40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor2.flange, pressDropLin5.inlet) annotation (
    Line(points = {{-56, -40}, {-48, -40}}, color = {159, 159, 223}));
  connect(pressDropLin6.outlet, massFlowToPressureAdapter4.flange) annotation (
    Line(points = {{36, -40}, {46, -40}}, color = {159, 159, 223}));
  connect(pressDropLin7.inlet, pressureToMassFlowAdapter4.flange) annotation (
    Line(points = {{166, -40}, {154, -40}}, color = {159, 159, 223}));
  connect(pressDropLin2.outlet, flowSplit.inlet) annotation (
    Line(points = {{-218, 50}, {-206, 50}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-270, -40}, {-226, -40}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, pressDropLin2.inlet) annotation (
    Line(points = {{-280, 50}, {-238, 50}}, color = {159, 159, 223}));
  connect(flowSplit.outlet1, massFlowToPressureAdapter3.flange) annotation (
    Line(points = {{-194, 54}, {-180, 54}, {-180, 76}, {38, 76}, {38, 40}, {46, 40}}, color = {159, 159, 223}));
  connect(pressDropLin4.outlet, throughMassFlow1.inlet) annotation (
    Line(points = {{190, 40}, {210, 40}}, color = {159, 159, 223}));
  connect(throughMassFlow1.outlet, sensT2.inlet) annotation (
    Line(points = {{230, 40}, {248, 40}}, color = {159, 159, 223}));
  connect(pressDropLin3.outlet, throughMassFlow2.inlet) annotation (
    Line(points = {{-20, 40}, {-12, 40}}, color = {159, 159, 223}));
  connect(throughMassFlow2.outlet, sinkPressure.flange) annotation (
    Line(points = {{8, 40}, {10, 40}, {10, 24}, {16, 24}}, color = {159, 159, 223}));
  connect(pressDropLin5.outlet, Compressor.inlet) annotation (
    Line(points = {{-28, -40}, {-22, -40}, {-22, -84}, {-16, -84}}, color = {159, 159, 223}));
  connect(Compressor.outlet, pressDropLin6.inlet) annotation (
    Line(points = {{16, -84}, {24, -84}, {24, -70}, {6, -70}, {6, -40}, {16, -40}}, color = {159, 159, 223}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{12, -100}, {100, -100}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{120, -100}, {168, -100}}));
  connect(Turbine.outlet, pressDropLin.inlet) annotation (
    Line(points = {{196, -84}, {242, -84}, {242, -40}, {260, -40}}, color = {159, 159, 223}));
  connect(pressDropLin7.outlet, throughMassFlow.inlet) annotation (
    Line(points = {{186, -40}, {198, -40}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, Turbine.inlet) annotation (
    Line(points = {{218, -40}, {230, -40}, {230, -60}, {164, -60}, {164, -84}}, color = {159, 159, 223}));
  connect(sensT.outlet, sinkPressure2.flange) annotation (
    Line(points = {{306, -40}, {328, -40}, {328, -46}, {346, -46}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-300, -140}, {300, 160}}), graphics={  Text(origin = {-284, -20}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)",
            horizontalAlignment =                                                                                                                                                                                              TextAlignment.Left), Text(origin = {-254, 100}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)",
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
end ECS_extFuns;
