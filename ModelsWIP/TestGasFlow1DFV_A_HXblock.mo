within PL_Lib.ModelsWIP;

model TestGasFlow1DFV_A_HXblock "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(extent = {{120, 120}, {140, 140}}, rotation = 0)));
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
  ThermoPower.Gas.SourceMassFlow sourceW_gas1(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas2out(redeclare package Medium = Medium, p0 = 10000, T = 300) annotation(
    Placement(visible = true, transformation(extent = {{100, -70}, {120, -50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-80, -6}, {-60, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{70, -66}, {90, -46}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{44, -70}, {64, -50}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(extent = {{-42, 64}, {-22, 84}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step4(height = 10, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-130, 10}, {-110, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step2(height = -0.2, offset = 1, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{24, -50}, {44, -30}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_gas1out(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation(
    Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas1out(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{60, -6}, {80, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_gas2in(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-80, 34}, {-60, 54}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceW_gas2(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-110, 30}, {-90, 50}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 10 + 50, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-130, 50}, {-110, 70}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas3(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.HXg2g HEX(redeclare package GasMedium1 = Medium, redeclare package GasMedium2 = Medium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom(displayUnit = "kg/m3") = 7800) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_gas2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-34, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput state_gas2in_p annotation(
    Placement(visible = true, transformation(origin = {-15, 75}, extent = {{-5, -5}, {5, 5}}, rotation = 0), iconTransformation(origin = {-34, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput state_gas2in_T annotation(
    Placement(visible = true, transformation(origin = {-15, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0), iconTransformation(origin = {-4, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput state_gas2in_rho annotation(
    Placement(visible = true, transformation(origin = {-15, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0), iconTransformation(origin = {28, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput state_gas2in_mdot annotation(
    Placement(visible = true, transformation(origin = {-15, 65}, extent = {{-5, -5}, {5, 5}}, rotation = 0), iconTransformation(origin = {46, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.HX_extFun hX_extFun annotation(
    Placement(visible = true, transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.StateReader_gas stateReader_gas4(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sourceW_gas1.flange, sensT_gas1in.inlet) annotation(
    Line(points = {{-90, 0}, {-76, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(valve.outlet, sensT_gas2out.inlet) annotation(
    Line(points = {{64, -60}, {74, -60}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT_gas2out.outlet, sinkP_gas2out.flange) annotation(
    Line(points = {{86, -60}, {100, -60}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Step4.y, sourceW_gas1.in_T) annotation(
    Line(points = {{-109, 20}, {-100, 20}, {-100, 5}}, color = {0, 0, 127}));
  connect(Step2.y, valve.cmd) annotation(
    Line(points = {{45, -40}, {54, -40}, {54, -53}}, color = {0, 0, 127}));
//  Mhex = hex.M;
//  der(Mbal) = hex.infl.m_flow + hex.outfl.m_flow;
//  Merr = Mhex - Mbal;
  connect(step.y, sourceW_gas2.in_T) annotation(
    Line(points = {{-109, 60}, {-100, 60}, {-100, 45}}, color = {0, 0, 127}));
  connect(sourceW_gas2.flange, sensT_gas2in.inlet) annotation(
    Line(points = {{-90, 40}, {-76, 40}}, color = {159, 159, 223}));
  connect(sensT_gas1out.outlet, sinkP_gas1out.flange) annotation(
    Line(points = {{76, 0}, {90, 0}}, color = {159, 159, 223}));
  connect(stateReader_gas1.outlet, valve.inlet) annotation(
    Line(points = {{26, -60}, {44, -60}}, color = {159, 159, 223}));
  connect(stateReader_gas3.outlet, sensT_gas1out.inlet) annotation(
    Line(points = {{46, 0}, {64, 0}}, color = {159, 159, 223}));
  connect(HEX.gasOut2, stateReader_gas1.inlet) annotation(
    Line(points = {{0, -20}, {0, -60}, {14, -60}}, color = {159, 159, 223}));
  connect(HEX.gasOut1, stateReader_gas3.inlet) annotation(
    Line(points = {{20, 0}, {34, 0}}, color = {159, 159, 223}));
//initial equation
//  Mbal = Mhex;
  connect(sensT_gas2in.outlet, stateReader_gas2.inlet) annotation(
    Line(points = {{-64, 40}, {-40, 40}}, color = {159, 159, 223}));
  connect(stateReader_gas2.outlet, HEX.gasIn2) annotation(
    Line(points = {{-28, 40}, {0, 40}, {0, 20}}, color = {159, 159, 223}));
  connect(stateReader_gas2.y1, state_gas2in_T) annotation(
    Line(points = {{-41, 47}, {-41, 85}, {-15, 85}}, color = {0, 0, 127}));
  connect(stateReader_gas2.y2, state_gas2in_p) annotation(
    Line(points = {{-37, 47}, {-37, 75}, {-15, 75}}, color = {0, 0, 127}));
  connect(stateReader_gas2.y3, state_gas2in_mdot) annotation(
    Line(points = {{-31, 47}, {-31, 65}, {-15, 65}}, color = {0, 0, 127}));
  connect(stateReader_gas2.y4, state_gas2in_rho) annotation(
    Line(points = {{-27, 47}, {-27, 55}, {-15, 55}}, color = {0, 0, 127}));
  connect(state_gas2in_T, hX_extFun.gas1_state_in) annotation(
    Line(points = {{-15, 85}, {0, 85}, {0, 70}, {10, 70}}, color = {0, 0, 127}));
  connect(state_gas2in_p, hX_extFun.gas1_state_in) annotation(
    Line(points = {{-15, 75}, {0, 75}, {0, 70}, {10, 70}}, color = {0, 0, 127}));
  connect(state_gas2in_mdot, hX_extFun.gas1_state_in) annotation(
    Line(points = {{-15, 65}, {0, 65}, {0, 70}, {10, 70}}, color = {0, 0, 127}));
  connect(state_gas2in_rho, hX_extFun.gas1_state_in) annotation(
    Line(points = {{-15, 55}, {0, 55}, {0, 70}, {10, 70}}, color = {0, 0, 127}));
  connect(sensT_gas1in.outlet, stateReader_gas4.inlet) annotation(
    Line(points = {{-64, 0}, {-46, 0}}, color = {159, 159, 223}));
  connect(stateReader_gas4.outlet, HEX.gasIn1) annotation(
    Line(points = {{-34, 0}, {-20, 0}}, color = {159, 159, 223}));
  connect(stateReader_gas4.y1, hX_extFun.gas2_state_in) annotation(
    Line(points = {{-47, 7}, {-47, 20}, {-58, 20}, {-58, 96}, {20, 96}, {20, 80}}, color = {0, 0, 127}));
  connect(stateReader_gas4.y2, hX_extFun.gas2_state_in) annotation(
    Line(points = {{-43, 7}, {-43, 24}, {-56, 24}, {-56, 94}, {20, 94}, {20, 80}}, color = {0, 0, 127}));
  connect(stateReader_gas4.y3, hX_extFun.gas2_state_in) annotation(
    Line(points = {{-37, 7}, {-37, 26}, {-54, 26}, {-54, 92}, {20, 92}, {20, 80}}, color = {0, 0, 127}));
  connect(stateReader_gas4.y4, hX_extFun.gas2_state_in) annotation(
    Line(points = {{-33, 7}, {-33, 28}, {-52, 28}, {-52, 90}, {20, 90}, {20, 80}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-160, -160}, {160, 160}})),
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
end TestGasFlow1DFV_A_HXblock;
