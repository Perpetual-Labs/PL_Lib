within PL_Lib.ModelsWIP;

model TestGasFlow1DFV_A_CmprsrTest "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(extent = {{160, 160}, {180, 180}}, rotation = 0)));
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Modelica.SIunits.Length Lhex = 200 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  parameter Modelica.SIunits.MassFlowRate whex = 0.05 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex = 2e5 "initial pressure";
  parameter Modelica.SIunits.Temperature Tinhex = 273.15 + 22 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Touthex = 273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Tgas2in = 273.15 + 200;
  parameter Modelica.SIunits.Temperature Tgas2out = 273.15 + 60;
  
  
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_gas1(redeclare package Medium = Medium, T = 273.15 + 100, p0 = 101325 * 2, use_in_T = false, w0 = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-130, -60}, {-110, -40}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-100, -56}, {-80, -36}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{80, -56}, {100, -36}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_gas1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 100, Tstartin = 273.15 + 100, Tstartout = 273.15 + 100, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(extent = {{-10, -60}, {10, -40}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(extent = {{-42, 64}, {-22, 84}}, rotation = 0)));
  //  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(origin = {42, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_T_gas1in(height = 10, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-150, -30}, {-130, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_valve_gas1out(height = 0, offset = 1, startTime = 0) annotation(
    Placement(visible = true, transformation(extent = {{30, -30}, {50, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(L = Lhex, Nw = Nnodes - 1, Tstart1 = 273.15 + 100, TstartN = 273.15 + 25, Tstartbar(displayUnit = "K") = 273.15 + 62.5, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{110, 30}, {130, 50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{80, 34}, {100, 54}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_gas2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 25, Tstartin = 273.15 + 25, Tstartout = 273.15 + 25, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-100, 34}, {-80, 54}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_gas2(redeclare package Medium = Medium, T = 273.15 + 25, use_in_T = true, use_in_w0 = false, w0 = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-130, 30}, {-110, 50}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_valve_gas2out(height = 0, offset = 1, startTime = 0) annotation(
    Placement(visible = true, transformation(extent = {{30, 60}, {50, 80}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_mdot_gas2in(height = 0.4, offset = 0.1, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{-150, 60}, {-130, 80}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_valve_gas2in annotation(
    Placement(visible = true, transformation(origin = {-80, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_valve_gas1in(height = 0, offset = 1, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_T_gas2in(height = 20, offset = 273.15 + 25, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{-150, 96}, {-130, 116}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_T_gas2in(duration = 30, height = -50, offset = 273.15 + 25, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-140, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas1out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {300, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_gas2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 25, Tstartin = 273.15 + 25, Tstartout = 273.15 + 25, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(origin = {230, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_gas1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 100, Tstartin = 273.15 + 100, Tstartout = 273.15 + 100, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(extent = {{220, 0}, {240, 20}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV2(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(origin = {230, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nw = Nnodes - 1, Tstart1 = 273.15 + 100, TstartN = 273.15 + 25, Tstartbar(displayUnit = "K") = 273.15 + 62.5, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
    Placement(visible = true, transformation(origin = {230, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{288, 80}, {308, 100}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{250, 84}, {270, 104}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{250, 4}, {270, 24}}, rotation = 0)));
equation
  connect(step_T_gas1in.y, sourceMassFlow_gas1.in_T) annotation(
    Line(points = {{-129, -20}, {-120, -20}, {-120, -45}}, color = {0, 0, 127}));
  connect(HEX1_gas1.wall, metalTubeFV1.ext) annotation(
    Line(points = {{0, -45}, {0, -13}}, color = {255, 127, 0}));
  connect(sensT_gas2out.outlet, sinkP_gas2out1.flange) annotation(
    Line(points = {{96, 40}, {110, 40}}, color = {159, 159, 223}));
  connect(stateReader_gas1in.outlet, HEX1_gas1.infl) annotation(
    Line(points = {{-24, -50}, {-10, -50}}, color = {159, 159, 223}));
  connect(HEX1_gas1.outfl, stateReader_gas1out.inlet) annotation(
    Line(points = {{10, -50}, {24, -50}}, color = {159, 159, 223}));
  connect(HEX1_gas2.outfl, stateReader_gas2out.inlet) annotation(
    Line(points = {{10, 40}, {24, 40}}, color = {159, 159, 223}));
  connect(stateReader_gas2in.outlet, HEX1_gas2.infl) annotation(
    Line(points = {{-24, 40}, {-10, 40}}, color = {159, 159, 223}));
  connect(sourceMassFlow_gas2.flange, sensT_gas2in.inlet) annotation(
    Line(points = {{-110, 40}, {-96, 40}}, color = {159, 159, 223}));
  connect(sourceMassFlow_gas1.flange, sensT_gas1in.inlet) annotation(
    Line(points = {{-110, -50}, {-96, -50}}, color = {159, 159, 223}));
  connect(ramp_T_gas2in.y, sourceMassFlow_gas2.in_T) annotation(
    Line(points = {{-129, 140}, {-120, 140}, {-120, 46}}, color = {0, 0, 127}));
  connect(HEX1_gas2.wall, heatExchangerTopologyFV1.side1) annotation(
    Line(points = {{0, 36}, {0, 13}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV1.side2, metalTubeFV1.int) annotation(
    Line(points = {{0, 7}, {0, -6}}, color = {255, 127, 0}));
  connect(stateReader_gas2out.outlet, sensT_gas2out.inlet) annotation(
    Line(points = {{36, 40}, {84, 40}}, color = {159, 159, 223}));
  connect(sensT_gas1in.outlet, stateReader_gas1in.inlet) annotation(
    Line(points = {{-84, -50}, {-36, -50}}, color = {159, 159, 223}));
  connect(stateReader_gas1out.outlet, sensT_gas1out1.inlet) annotation(
    Line(points = {{36, -50}, {84, -50}}));
  connect(flowSplit.outlet2, stateReader_gas2in.inlet) annotation(
    Line(points = {{-64, 36}, {-49, 36}, {-49, 40}, {-36, 40}}, color = {159, 159, 223}));
  connect(sensT_gas2in.outlet, flowSplit.inlet) annotation(
    Line(points = {{-84, 40}, {-76, 40}}, color = {159, 159, 223}));
  connect(flowSplit.outlet1, HEX2_gas2.infl) annotation(
    Line(points = {{-64, 44}, {-50, 44}, {-50, 90}, {220, 90}}, color = {159, 159, 223}));
  connect(HEX2_gas2.wall, heatExchangerTopologyFV2.side1) annotation(
    Line(points = {{230, 86}, {230, 63}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV2.side2, metalTubeFV2.int) annotation(
    Line(points = {{230, 56.9}, {230, 44.9}}, color = {255, 127, 0}));
  connect(metalTubeFV2.ext, HEX2_gas1.wall) annotation(
    Line(points = {{230, 37}, {230, 15}}, color = {255, 127, 0}));
  connect(sensT_gas1out1.outlet, HEX2_gas1.infl) annotation(
    Line(points = {{96, -50}, {180, -50}, {180, 10}, {220, 10}}, color = {159, 159, 223}));
  connect(HEX2_gas2.outfl, sensT_gas2out2.inlet) annotation(
    Line(points = {{240, 90}, {254, 90}}, color = {159, 159, 223}));
  connect(sensT_gas2out2.outlet, sinkP_gas2out2.flange) annotation(
    Line(points = {{266, 90}, {288, 90}}, color = {159, 159, 223}));
  connect(HEX2_gas1.outfl, sensT_gas1out2.inlet) annotation(
    Line(points = {{240, 10}, {254, 10}}, color = {159, 159, 223}));
  connect(sensT_gas1out2.outlet, sinkP_gas1out.flange) annotation(
    Line(points = {{266, 10}, {290, 10}}, color = {159, 159, 223}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {600, 200}}), graphics = {Text(origin = {107, -19}, extent = {{-27, 9}, {27, -9}}, textString = "hoyt", textStyle = {TextStyle.Bold}), Text(origin = {101, 67}, extent = {{-27, 9}, {27, -9}}, textString = "coyld", textStyle = {TextStyle.Bold})}),
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
end TestGasFlow1DFV_A_CmprsrTest;
