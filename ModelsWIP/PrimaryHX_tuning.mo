within PL_Lib.ModelsWIP;
model PrimaryHX_tuning
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{-200, 180}, {-180, 200}}, rotation = 0)));

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
  parameter Modelica.SIunits.Pressure phex_BA = 101325 *2 "initial pressure";

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
  ThermoPower.Gas.Flow1DFV HEX1_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{-40, -50}, {-20, -30}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_RA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_RA) annotation (
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstart1 = Thex_in_BA, TstartN = Thex_in_BA, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_BAin1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_BAout1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_RAout1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_RAin1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Sources.Ramp ramp_T_RAin(duration = 600, height = -45, offset = Thex_in_RA, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-200, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(duration = 600, height = -74825, offset = 101325, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-200, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  ThermoPower.Gas.SinkPressure sinkP_RAout1(redeclare package Medium = Medium, p0 = 101325, use_in_p0 = false)  annotation (
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = false, use_in_p0 = false)  annotation (
    Placement(visible = true, transformation(origin = {-176, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = Medium, w0 = 0.5)  annotation (
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-180, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-150, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium,Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout2(redeclare package Medium = Medium, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(extent = {{180, 30}, {200, 50}}, rotation = 0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  ThermoPower.Gas.Flow1DFV HEX2_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{120, -50}, {140, -30}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 20, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex_RA, wnom = whex_RA) annotation (
    Placement(visible = true, transformation(origin = {130, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {130, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  PL_Lib.Components.StateReader_gas stateReader_RAin2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_RAout2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {160, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_BAin2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_BAout2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {160, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {190, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{240, -72}, {260, -52}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_BAout3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {220, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.8)  annotation (
    Placement(visible = true, transformation(origin = {128, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePRC[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
initial equation
    inertia.w = 523.3;
equation
  connect(HEX1_BA.wall, metalTubeFV1.ext) annotation(
    Line(points = {{-30, -35}, {-30, -13}}, color = {255, 127, 0}, thickness = 1));
  connect(stateReader_BAin1.outlet, HEX1_BA.infl) annotation(
    Line(points = {{-114, -40}, {-40, -40}}, color = {159, 159, 223}));
  connect(HEX1_BA.outfl, stateReader_BAout1.inlet) annotation(
    Line(points = {{-20, -40}, {-6, -40}}, color = {159, 159, 223}));
  connect(HEX1_RA.outfl, stateReader_RAout1.inlet) annotation(
    Line(points = {{-20, 40}, {-6, 40}}, color = {159, 159, 223}));
  connect(stateReader_RAin1.outlet, HEX1_RA.infl) annotation(
    Line(points = {{-54, 40}, {-40, 40}}, color = {159, 159, 223}, thickness = 1));
  connect(HEX1_RA.wall, heatExchangerTopologyFV1.side1) annotation(
    Line(points = {{-30, 35}, {-30, 13}}, color = {255, 127, 0}, thickness = 1));
  connect(heatExchangerTopologyFV1.side2, metalTubeFV1.int) annotation(
    Line(points = {{-30, 7}, {-30, -6.1}}, color = {255, 127, 0}));
  connect(ramp_T_RAin.y, sourceP_RAin.in_T) annotation(
    Line(points = {{-189, 100}, {-176, 100}, {-176, 59}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation(
    Line(points = {{-189, 70}, {-182, 70}, {-182, 56}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sinkP_RAout1.in_p0) annotation(
    Line(points = {{-189, 70}, {24, 70}, {24, 46}}, color = {0, 0, 127}));
  connect(throughMassFlow_BAin.outlet, stateReader_BAin1.inlet) annotation(
    Line(points = {{-140, -40}, {-126, -40}}, color = {159, 159, 223}));
  connect(HEX2_BA.wall, metalTubeFV2.ext) annotation(
    Line(points = {{130, -35}, {130, -14}}, color = {255, 127, 0}));
  connect(throughMassFlow_RAin.outlet, flowSplit.inlet) annotation(
    Line(points = {{-110, 50}, {-96, 50}}, color = {159, 159, 223}));
  connect(heatExchangerTopologyFV.side2, metalTubeFV2.int) annotation(
    Line(points = {{130, 6.9}, {130, -6.1}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV.side1, HEX2_RA.wall) annotation(
    Line(points = {{130, 13}, {130, 35}}, color = {255, 127, 0}));
  connect(flowSplit.outlet1, throughMassFlow.inlet) annotation(
    Line(points = {{-84, 54}, {-80, 54}, {-80, 60}, {50, 60}}, color = {159, 159, 223}));
  connect(flowSplit.outlet2, stateReader_RAin1.inlet) annotation(
    Line(points = {{-84, 46}, {-80, 46}, {-80, 40}, {-66, 40}}, color = {159, 159, 223}));
  connect(ramp_P_RAin.y, sinkP_RAout2.in_p0) annotation(
    Line(points = {{-188, 70}, {184, 70}, {184, 46}}, color = {0, 0, 127}));
  connect(stateReader_RAin2.outlet, HEX2_RA.infl) annotation(
    Line(points = {{106, 40}, {120, 40}}, color = {159, 159, 223}));
  connect(stateReader_BAin2.outlet, HEX2_BA.infl) annotation(
    Line(points = {{106, -40}, {120, -40}}, color = {159, 159, 223}));
  connect(HEX2_RA.outfl, stateReader_RAout2.inlet) annotation(
    Line(points = {{140, 40}, {154, 40}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation(
    Line(points = {{-166, 50}, {-130, 50}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation(
    Line(points = {{-170, -40}, {-160, -40}}, color = {159, 159, 223}));
  connect(stateReader_RAout1.outlet, sinkP_RAout1.flange) annotation(
    Line(points = {{6, 40}, {20, 40}}, color = {159, 159, 223}));
  connect(stateReader_BAout1.outlet, Compressor.inlet) annotation(
    Line(points = {{6, -40}, {62, -40}, {62, -62}}, color = {159, 159, 223}));
  connect(Compressor.outlet, stateReader_BAin2.inlet) annotation(
    Line(points = {{78, -62}, {78, -40}, {94, -40}}, color = {159, 159, 223}));
  connect(HEX2_BA.outfl, stateReader_BAout2.inlet) annotation(
    Line(points = {{140, -40}, {154, -40}}, color = {159, 159, 223}));
  connect(stateReader_RAout2.outlet, sinkP_RAout2.flange) annotation(
    Line(points = {{166, 40}, {180, 40}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, stateReader_RAin2.inlet) annotation(
    Line(points = {{70, 60}, {80, 60}, {80, 40}, {94, 40}}, color = {159, 159, 223}));
  connect(stateReader_BAout2.outlet, Turbine.inlet) annotation(
    Line(points = {{166, -40}, {174, -40}, {174, -62}, {182, -62}}, color = {159, 159, 223}));
  connect(Turbine.outlet, stateReader_BAout3.inlet) annotation(
    Line(points = {{198, -62}, {214, -62}}, color = {159, 159, 223}));
  connect(stateReader_BAout3.outlet, sinkPressure.flange) annotation(
    Line(points = {{226, -62}, {240, -62}}, color = {159, 159, 223}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation(
    Line(points = {{76, -70}, {118, -70}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation(
    Line(points = {{138, -70}, {184, -70}}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics = {Text(origin = {-170, -20}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", horizontalAlignment = TextAlignment.Left), Text(origin = {-140, 80}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)", horizontalAlignment = TextAlignment.Left)}),
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
end PrimaryHX_tuning;
