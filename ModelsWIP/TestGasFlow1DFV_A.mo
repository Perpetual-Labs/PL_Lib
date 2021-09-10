within PL_Lib.ModelsWIP;

model TestGasFlow1DFV_A "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.IdealGases.SingleGases.N2 constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Modelica.SIunits.Length Lhex = 200 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  parameter Modelica.SIunits.MassFlowRate whex = 0.05 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex = 3e5 "initial pressure";
  parameter Modelica.SIunits.Temperature Tinhex = 300 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Touthex = 300 "initial outlet temperature";
  // parameter Temperature deltaT=10 "height of temperature step";
  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  ThermoPower.Gas.SourceMassFlow Source(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-80, -80}, {-60, -60}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure Sink(redeclare package Medium = Medium, p0 = 10000, T = 300) annotation(
    Placement(visible = true, transformation(extent = {{80, -80}, {100, -60}}, rotation = 0)));
  ThermoPower.Gas.SensT SensT1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-50, -76}, {-30, -56}}, rotation = 0)));
  ThermoPower.Gas.SensT SensT2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{50, -76}, {70, -56}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV hex(redeclare package Medium = Medium, N = Nnodes, L = Lhex, A = Ahex, omega = omegahex, Dhyd = Dihex, wnom = whex, Cfnom = Cfhex, Tstartin = Tinhex, Tstartout = Touthex, pstart = phex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, initOpt = ThermoPower.Choices.Init.Options.steadyState, dpnom = 1000) annotation(
    Placement(visible = true, transformation(extent = {{-20, -80}, {0, -60}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{20, -80}, {40, -60}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(extent = {{-42, 64}, {-22, 84}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step4(height = 10, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-100, -60}, {-80, -40}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step2(height = -0.2, offset = 1, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{0, -60}, {20, -40}}, rotation = 0)));
  inner ThermoPower.System system annotation(
    Placement(transformation(extent = {{80, 80}, {100, 100}})));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV(L = Lhex, Nw = Nnodes - 1, Tstartbar(displayUnit = "K"), lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
    Placement(visible = true, transformation(origin = {-10, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation(
    Placement(visible = true, transformation(extent = {{80, 20}, {100, 40}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valveLin(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{20, 20}, {40, 40}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{50, 24}, {70, 44}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV flow1DFV(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-50, 24}, {-30, 44}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-80, 20}, {-60, 40}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 10 + 50, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-100, 40}, {-80, 60}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = -0.2, offset = 1, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{0, 40}, {20, 60}}, rotation = 0)));
equation
  connect(Source.flange, SensT1.inlet) annotation(
    Line(points = {{-60, -70}, {-46, -70}}, color = {159, 159, 223}, thickness = 0.5));
  connect(SensT1.outlet, hex.infl) annotation(
    Line(points = {{-34, -70}, {-20, -70}}, color = {159, 159, 223}, thickness = 0.5));
  connect(hex.outfl, valve.inlet) annotation(
    Line(points = {{0, -70}, {20, -70}}, color = {159, 159, 223}, thickness = 0.5));
  connect(valve.outlet, SensT2.inlet) annotation(
    Line(points = {{40, -70}, {54, -70}}, color = {159, 159, 223}, thickness = 0.5));
  connect(SensT2.outlet, Sink.flange) annotation(
    Line(points = {{66, -70}, {80, -70}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Step4.y, Source.in_T) annotation(
    Line(points = {{-79, -50}, {-70, -50}, {-70, -65}}, color = {0, 0, 127}));
  connect(Step2.y, valve.cmd) annotation(
    Line(points = {{21, -50}, {30, -50}, {30, -63}}, color = {0, 0, 127}));
  Mhex = hex.M;
  der(Mbal) = hex.infl.m_flow + hex.outfl.m_flow;
  Merr = Mhex - Mbal;
  connect(hex.wall, metalTubeFV.ext) annotation(
    Line(points = {{-10, -65}, {-10, -23}}, color = {255, 127, 0}));
  connect(counterCurrentFV.side2, metalTubeFV.int) annotation(
    Line(points = {{-10, -3}, {-10, -17}}, color = {255, 127, 0}));
  connect(step.y, sourceMassFlow.in_T) annotation(
    Line(points = {{-79, 50}, {-70, 50}, {-70, 35}}, color = {0, 0, 127}));
  connect(sourceMassFlow.flange, sensT1.inlet) annotation(
    Line(points = {{-60, 30}, {-46, 30}}, color = {159, 159, 223}));
  connect(sensT1.outlet, flow1DFV.infl) annotation(
    Line(points = {{-34, 30}, {-20, 30}}, color = {159, 159, 223}));
  connect(flow1DFV.outfl, valveLin.inlet) annotation(
    Line(points = {{0, 30}, {20, 30}}, color = {159, 159, 223}));
  connect(valveLin.outlet, sensT.inlet) annotation(
    Line(points = {{40, 30}, {54, 30}}, color = {159, 159, 223}));
  connect(sensT.outlet, sinkPressure.flange) annotation(
    Line(points = {{66, 30}, {80, 30}}, color = {159, 159, 223}));
  connect(step1.y, valveLin.cmd) annotation(
    Line(points = {{21, 50}, {30, 50}, {30, 37}}, color = {0, 0, 127}));
  connect(flow1DFV.wall, counterCurrentFV.side1) annotation(
    Line(points = {{-10, 25}, {-10, 3}}, color = {255, 127, 0}));
initial equation
  Mbal = Mhex;
  annotation(
    Diagram(graphics),
    experiment(StopTime = 80, Tolerance = 1e-06, StartTime = 0, Interval = 0.16),
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
end TestGasFlow1DFV_A;
