within PL_Lib.ModelsWIP;
model TestingAdapters "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{180, 80}, {200, 100}}, rotation = 0)));
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
  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";

  Modelica.Blocks.Sources.Step Step1(height = W, startTime = 20) annotation (
    Placement(visible = true, transformation(extent = {{-30, 60}, {-10, 80}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step3(height = 10, offset = Tinhex, startTime = 10) annotation (
    Placement(visible = true, transformation(extent = {{-200, 60}, {-180, 80}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step2(height = -0.2, offset = 1, startTime = 40) annotation (
    Placement(visible = true, transformation(extent = {{60, 60}, {80, 80}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation (
    Placement(visible = true, transformation(extent = {{-170, 10}, {-150, 30}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium, p0 = 10000, T = 300) annotation (
    Placement(visible = true, transformation(extent = {{152, 10}, {172, 30}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, 14}, {-90, 34}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, 14}, {140, 34}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1(redeclare package Medium = Medium, N = Nnodes, L = Lhex, A = Ahex, omega = omegahex, Dhyd = Dihex, wnom = whex, Cfnom = Cfhex, Tstartin = Tinhex, Tstartout = Touthex, pstart = phex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, initOpt = ThermoPower.Choices.Init.Options.steadyState, dpnom = 1000) annotation (
    Placement(visible = true, transformation(extent = {{-10, 10}, {10, 30}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{-10, 36}, {10, 56}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve1(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, 10}, {110, 30}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow2(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation (
    Placement(visible = true, transformation(extent = {{-170, -60}, {-150, -40}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource2(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{-10, -34}, {10, -14}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(extent = {{-10, -60}, {10, -40}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve2(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, -60}, {110, -40}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure2(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation (
    Placement(visible = true, transformation(extent = {{150, -60}, {170, -40}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, -56}, {140, -36}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, -56}, {-90, -36}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor1(redeclare
      package Medium =                                                                             Medium) annotation (
    Placement(visible = true, transformation(origin = {-70, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare
      package Medium =                                                                             Medium) annotation (
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor2(redeclare
      package Medium =                                                                             Medium) annotation (
    Placement(visible = true, transformation(origin = {70, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare
      package Medium =                                                                             Medium) annotation (
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(sensT1.outlet, HEX1.infl) annotation (
    Line(points = {{-94, 20}, {-10, 20}}, color = {159, 159, 223}, thickness = 0.5));
  connect(HEX1.outfl, valve1.inlet) annotation (
    Line(points = {{10, 20}, {90, 20}}, color = {159, 159, 223}, thickness = 0.5));
  connect(valve1.outlet, sensT2.inlet) annotation (
    Line(points = {{110, 20}, {124, 20}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT2.outlet, sinkPressure1.flange) annotation (
    Line(points = {{136, 20}, {152, 20}}, color = {159, 159, 223}, thickness = 0.5));
  connect(heatSource1.wall, HEX1.wall) annotation (
    Line(points = {{0, 43}, {0, 25}}, color = {255, 127, 0}));
  connect(Step1.y, heatSource1.power) annotation (
    Line(points = {{-9, 70}, {0, 70}, {0, 50}}, color = {0, 0, 127}));
  connect(Step2.y, valve1.cmd) annotation (
    Line(points = {{81, 70}, {100, 70}, {100, 27}}, color = {0, 0, 127}));
  connect(sourceMassFlow1.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-150, 20}, {-140, 20}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensT1.inlet) annotation (
    Line(points = {{-120, 20}, {-106, 20}}, color = {159, 159, 223}));
  connect(sourceMassFlow2.flange, pressDropLin2.inlet) annotation (
    Line(points = {{-150, -50}, {-140, -50}}, color = {159, 159, 223}));
  connect(heatSource2.wall, HEX2.wall) annotation (
    Line(points = {{0, -27}, {0, -45}}, color = {255, 127, 0}));
  connect(valve2.outlet, sensT4.inlet) annotation (
    Line(points = {{110, -50}, {124, -50}}, color = {159, 159, 223}));
  connect(sensT4.outlet, sinkPressure2.flange) annotation (
    Line(points = {{136, -50}, {150, -50}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdaptor1.T, pressureToMassFlowAdaptor1.T) annotation (
    Line(points = {{-64, -36}, {-36, -36}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p, pressureToMassFlowAdaptor1.p) annotation (
    Line(points = {{-64, -42}, {-36, -42}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, massFlowToPressureAdaptor1.m_dot) annotation (
    Line(points = {{-36, -64}, {-64, -64}}, color = {0, 0, 127}));
  connect(valve2.inlet, pressureToMassFlowAdaptor2.flange) annotation (
    Line(points = {{90, -50}, {74, -50}}, color = {159, 159, 223}));
  connect(HEX2.outfl, massFlowToPressureAdaptor2.flange) annotation (
    Line(points = {{10, -50}, {26, -50}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdaptor2.T, pressureToMassFlowAdaptor2.T) annotation (
    Line(points = {{36, -36}, {64, -36}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.p, pressureToMassFlowAdaptor2.p) annotation (
    Line(points = {{36, -42}, {64, -42}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot, massFlowToPressureAdaptor2.m_dot) annotation (
    Line(points = {{64, -64}, {36, -64}}, color = {0, 0, 127}));
  connect(Step1.y, heatSource2.power) annotation (
    Line(points={{-9,70},{20,70},{20,0},{0,0},{0,-20}},            color = {0, 0, 127}));
  connect(Step2.y, valve2.cmd) annotation (
    Line(points={{81,70},{116,70},{116,0},{100,0},{100,-43}},            color = {0, 0, 127}));
  connect(pressDropLin2.outlet, sensT3.inlet) annotation (
    Line(points = {{-120, -50}, {-106, -50}}, color = {159, 159, 223}));
  connect(sensT3.outlet, massFlowToPressureAdaptor1.flange) annotation (
    Line(points = {{-94, -50}, {-74, -50}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.flange, HEX2.infl) annotation (
    Line(points = {{-26, -50}, {-10, -50}}, color = {159, 159, 223}));
  connect(Step3.y, sourceMassFlow1.in_T) annotation (
    Line(points={{-179,70},{-160,70},{-160,25}},        color = {0, 0, 127}));
  connect(Step3.y, sourceMassFlow2.in_T) annotation (
    Line(points={{-179,70},{-146,70},{-146,0},{-160,0},{-160,-45}},            color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}), graphics={  Rectangle(origin = {-0.02, -45.25}, lineColor = {0, 170, 0}, fillColor = {234, 255, 230},
            fillPattern =                                                                                                                                                              FillPattern.Solid,
            lineThickness =                                                                                                                                                                                               0.5, extent = {{-49.98, 35.2}, {49.98, -35.2}})}),
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
end TestingAdapters;
