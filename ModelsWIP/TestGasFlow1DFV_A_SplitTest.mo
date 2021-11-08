within PL_Lib.ModelsWIP;
model TestGasFlow1DFV_A_SplitTest "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{-200, 180}, {-180, 200}}, rotation = 0)));
  parameter Integer Nnodes = 2 "number of Nodes";
  parameter Modelica.SIunits.Length Lhex = 10 "total length";
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
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_gas1(redeclare package Medium = Medium, T = 273.15 + 200, p0 = 101325 * 2, use_in_T = false, w0 = 0.25) annotation (
    Placement(visible = true, transformation(extent = {{-160, -60}, {-140, -40}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-130, -56}, {-110, -36}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{20, -56}, {40, -36}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_gas1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, Kfnom = 0.1, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 200, Tstartin = 273.15 + 200, Tstartout = 273.15 + 200, dpnom = 999.9999999999999, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(extent = {{-40, -60}, {-20, -40}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(extent = {{-42, 64}, {-22, 84}}, rotation = 0)));
  //  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(origin = {42, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_T_gas1in(height = 10, offset = Tinhex, startTime = 10) annotation (
    Placement(visible = true, transformation(extent = {{-180, -40}, {-160, -20}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(L = Lhex, Nw = Nnodes - 1, Tstart1 = 273.15 + 200, TstartN = 273.15 + 200, Tstartbar(displayUnit = "K") = 273.15 + 200, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{20, 34}, {40, 54}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_gas2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, Kfnom = 0.1, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 25, Tstartin = 273.15 + 25, Tstartout = 273.15 + 25, dpnom = 0.01, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-130, 44}, {-110, 64}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_gas2(redeclare package Medium = Medium, T = 273.15 + 20, use_in_T = true, use_in_w0 = false, w0 = 0.01) annotation (
    Placement(visible = true, transformation(extent = {{-160, 40}, {-140, 60}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step_mdot_gas2in(height = 0.4, offset = 0.1, startTime = 40) annotation (
    Placement(visible = true, transformation(extent = {{-180, 90}, {-160, 110}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2out(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2in(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_T_gas2in(duration = 600, height = -45, offset = 273.15 + 20, startTime = 200) annotation (
    Placement(visible = true, transformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_gas2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 25, Tstartin = 273.15 + 25, Tstartout = 273.15 + 25, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2_gas1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, Kfnom = 0.1, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 200, Tstartin = 273.15 + 200, Tstartout = 273.15 + 200, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(extent = {{100, -60}, {120, -40}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV2(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nw = Nnodes - 1, Tstart1 = 273.15 + 200, TstartN = 273.15 + 200, Tstartbar(displayUnit = "K") = 273.15 + 200, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{160, 30}, {180, 50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{130, 34}, {150, 54}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{130, -56}, {150, -36}}, rotation = 0)));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow_gas1out(redeclare package Medium = Medium, p0 = 101325 * 5, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {170, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Compressor Compressor(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 70, Tstart_in = 273.15 + 70, Tstart_out = 273.15 + 200, explicitIsentropicEnthalpy = false, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {70, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed = 400) annotation (
    Placement(visible = true, transformation(origin = {40, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 273.15 + 200, p0 = 5e5)  annotation (
    Placement(visible = true, transformation(origin = {130, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, T = 273.15 + 70, p0 = 200000)  annotation (
    Placement(visible = true, transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{50, 30}, {70, 50}}, rotation = 0)));
protected
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePRC[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  //initial equation
  //  inertia.w = 500;
equation
  connect(step_T_gas1in.y, sourceMassFlow_gas1.in_T) annotation (
    Line(points = {{-159, -30}, {-150, -30}, {-150, -45}}, color = {0, 0, 127}));
  connect(HEX1_gas1.wall, metalTubeFV1.ext) annotation (
    Line(points={{-30,-45},{-30,-13.1}},    color = {255, 127, 0}, thickness = 1));
  connect(stateReader_gas1in.outlet, HEX1_gas1.infl) annotation (
    Line(points = {{-54, -50}, {-40, -50}}, color = {159, 159, 223}));
  connect(HEX1_gas1.outfl, stateReader_gas1out.inlet) annotation (
    Line(points = {{-20, -50}, {-6, -50}}, color = {159, 159, 223}));
  connect(HEX1_gas2.outfl, stateReader_gas2out.inlet) annotation (
    Line(points = {{-20, 40}, {-6, 40}}, color = {159, 159, 223}));
  connect(stateReader_gas2in.outlet, HEX1_gas2.infl) annotation (
    Line(points = {{-54, 40}, {-40, 40}}, color = {159, 159, 223}, thickness = 1));
  connect(sourceMassFlow_gas2.flange, sensT_gas2in.inlet) annotation (
    Line(points = {{-140, 50}, {-126, 50}}, color = {159, 159, 223}));
  connect(sourceMassFlow_gas1.flange, sensT_gas1in.inlet) annotation (
    Line(points = {{-140, -50}, {-126, -50}}, color = {159, 159, 223}));
  connect(HEX1_gas2.wall, heatExchangerTopologyFV1.side1) annotation (
    Line(points = {{-30, 35}, {-30, 13}}, color = {255, 127, 0}, thickness = 1));
  connect(heatExchangerTopologyFV1.side2, metalTubeFV1.int) annotation (
    Line(points={{-30,6.9},{-30,-7}},      color = {255, 127, 0}));
  connect(stateReader_gas2out.outlet, sensT_gas2out.inlet) annotation (
    Line(points = {{6, 40}, {24, 40}}, color = {159, 159, 223}));
  connect(sensT_gas1in.outlet, stateReader_gas1in.inlet) annotation (
    Line(points = {{-114, -50}, {-66, -50}}, color = {159, 159, 223}, thickness = 1));
  connect(stateReader_gas1out.outlet, sensT_gas1out1.inlet) annotation (
    Line(points = {{6, -50}, {24, -50}}));
  connect(flowSplit.outlet2, stateReader_gas2in.inlet) annotation (
    Line(points = {{-94, 46}, {-80, 46}, {-80, 40}, {-66, 40}}, color = {159, 159, 223}, thickness = 1));
  connect(sensT_gas2in.outlet, flowSplit.inlet) annotation (
    Line(points = {{-114, 50}, {-106, 50}}, color = {159, 159, 223}));
  connect(HEX2_gas2.wall, heatExchangerTopologyFV2.side1) annotation (
    Line(points = {{110, 35}, {110, 13}}, color = {255, 127, 0}, thickness = 1));
  connect(heatExchangerTopologyFV2.side2, metalTubeFV2.int) annotation (
    Line(points={{110,6.9},{110,-7}},        color = {255, 127, 0}));
  connect(metalTubeFV2.ext, HEX2_gas1.wall) annotation (
    Line(points={{110,-13.1},{110,-45}},        color = {255, 127, 0}, thickness = 1));
  connect(HEX2_gas2.outfl, sensT_gas2out2.inlet) annotation (
    Line(points = {{120, 40}, {134, 40}}, color = {159, 159, 223}));
  connect(sensT_gas2out2.outlet, sinkP_gas2out2.flange) annotation (
    Line(points = {{146, 40}, {160, 40}}, color = {159, 159, 223}));
  connect(HEX2_gas1.outfl, sensT_gas1out2.inlet) annotation (
    Line(points = {{120, -50}, {134, -50}}, color = {159, 159, 223}));
  connect(flowSplit.outlet1, HEX2_gas2.infl) annotation (
    Line(points = {{-94, 54}, {-80, 54}, {-80, 60}, {90, 60}, {90, 40}, {100, 40}}, color = {159, 159, 223}, thickness = 1));
  connect(ramp_T_gas2in.y, sourceMassFlow_gas2.in_T) annotation (
    Line(points={{-159,70},{-150,70},{-150,55}},        color = {0, 0, 127}));
  connect(sensT_gas1out2.outlet, sinkMassFlow_gas1out.flange) annotation (
    Line(points = {{146, -50}, {160, -50}}, color = {159, 159, 223}));
  connect(constantSpeed.flange, Compressor.shaft_a) annotation (
    Line(points = {{50, -108}, {59, -108}, {59, -98}, {64, -98}}));
  connect(sourcePressure.flange, Compressor.inlet) annotation (
    Line(points = {{20, -90}, {62, -90}}, color = {159, 159, 223}));
  connect(sinkPressure.flange, Compressor.outlet) annotation (
    Line(points = {{120, -90}, {78, -90}}, color = {159, 159, 223}));
  connect(sensT_gas1out1.outlet, HEX2_gas1.infl) annotation (
    Line(points = {{36, -50}, {100, -50}}, color = {159, 159, 223}));
  connect(sensT_gas2out.outlet, sinkP_gas2out1.flange) annotation (
    Line(points = {{36, 40}, {50, 40}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics={  Text(origin = {-120, -20}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)"), Text(origin = {-120, 80}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)")}),
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
end TestGasFlow1DFV_A_SplitTest;
