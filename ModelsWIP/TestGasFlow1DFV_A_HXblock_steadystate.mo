within PL_Lib.ModelsWIP;

model TestGasFlow1DFV_A_HXblock_steadystate "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation(
    Placement(transformation(extent = {{80, 80}, {100, 100}})));
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Modelica.SIunits.Length Lhex = 200 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  parameter Modelica.SIunits.MassFlowRate whex = 0.05 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex = 2e5 "initial pressure";
  parameter Modelica.SIunits.Temperature Tinhex = 300 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Touthex = 300 "initial outlet temperature";
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  ThermoPower.Gas.SourceMassFlow sourceW_gas1(redeclare package Medium = Medium, T = 273.15 + 200, p0 = phex, use_in_T = false, use_in_w0 = false, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out(redeclare package Medium = Medium, T = 273.15 + 30) annotation(
    Placement(visible = true, transformation(extent = {{90, -70}, {110, -50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-80, -6}, {-60, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{60, -66}, {80, -46}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(extent = {{-42, 64}, {-22, 84}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step4(height = 10, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-132, 10}, {-112, 30}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas1out(redeclare package Medium = Medium, T = 273.15 + 200) annotation(
    Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{60, -6}, {80, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-80, 34}, {-60, 54}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceW_gas2(redeclare package Medium = Medium, T = 273.15 + 30, p0 = phex, use_in_T = false, use_in_w0 = false, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-110, 30}, {-90, 50}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 10 + 50, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-130, 50}, {-110, 70}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {36, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas3(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.HXg2g HEX(redeclare package GasMedium1 = Medium, redeclare package GasMedium2 = Medium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom(displayUnit = "kg/m3") = 7800) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(sourceW_gas1.flange, sensT_gas1in.inlet) annotation(
    Line(points = {{-90, 0}, {-76, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT_gas2out.outlet, sinkP_gas2out.flange) annotation(
    Line(points = {{76, -60}, {90, -60}}, color = {159, 159, 223}, thickness = 0.5));
//  Mhex = hex.M;
//  der(Mbal) = hex.infl.m_flow + hex.outfl.m_flow;
//  Merr = Mhex - Mbal;
  connect(sourceW_gas2.flange, sensT_gas2in.inlet) annotation(
    Line(points = {{-90, 40}, {-76, 40}}, color = {159, 159, 223}));
  connect(sensT_gas1out.outlet, sinkP_gas1out.flange) annotation(
    Line(points = {{76, 0}, {90, 0}}, color = {159, 159, 223}));
  connect(sensT_gas1in.outlet, stateReader_gas.inlet) annotation(
    Line(points = {{-64, 0}, {-46, 0}}, color = {159, 159, 223}));
  connect(stateReader_gas3.outlet, sensT_gas1out.inlet) annotation(
    Line(points = {{46, 0}, {64, 0}}, color = {159, 159, 223}));
  connect(sensT_gas2in.outlet, stateReader_gas2.inlet) annotation(
    Line(points = {{-64, 40}, {-46, 40}}, color = {159, 159, 223}));
  connect(stateReader_gas2.outlet, HEX.gasIn2) annotation(
    Line(points = {{-34, 40}, {0, 40}, {0, 20}}, color = {159, 159, 223}));
  connect(HEX.gasOut2, stateReader_gas1.inlet) annotation(
    Line(points = {{0, -20}, {0, -60}, {30, -60}}, color = {159, 159, 223}));
  connect(stateReader_gas.outlet, HEX.gasIn1) annotation(
    Line(points = {{-34, 0}, {-20, 0}}, color = {159, 159, 223}));
  connect(HEX.gasOut1, stateReader_gas3.inlet) annotation(
    Line(points = {{20, 0}, {34, 0}}, color = {159, 159, 223}));
//initial equation
//  Mbal = Mhex;
  connect(stateReader_gas1.outlet, sensT_gas2out.inlet) annotation(
    Line(points = {{42, -60}, {64, -60}}, color = {159, 159, 223}));
  connect(step.y, sourceW_gas2.in_T) annotation(
    Line(points = {{-109, 60}, {-100, 60}, {-100, 46}}, color = {0, 0, 127}));
  connect(Step4.y, sourceW_gas1.in_T) annotation(
    Line(points = {{-111, 20}, {-100, 20}, {-100, 6}}, color = {0, 0, 127}));
  annotation(
    Diagram,
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
end TestGasFlow1DFV_A_HXblock_steadystate;
