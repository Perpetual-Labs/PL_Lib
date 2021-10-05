within PL_Lib.ModelsWIP;

model ExtFun_adaptors "Test case for Gas.Flow1DFV"
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
  parameter Modelica.SIunits.Pressure phex = 3e5 "initial pressure";
  parameter Modelica.SIunits.Temperature Tinhex = 300 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Touthex = 300 "initial outlet temperature";
  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";

  Modelica.Blocks.Sources.Step Step1(height = W, startTime = 20) annotation(
    Placement(transformation(extent = {{-40, 40}, {-20, 60}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step4(height = 10, offset = Tinhex, startTime = 10) annotation(
    Placement(visible = true, transformation(extent = {{-260, 40}, {-240, 60}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step2(height = -0.2, offset = 1, startTime = 40) annotation(
    Placement(visible = true, transformation(extent = {{20, 40}, {40, 60}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow Source(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-130, -10}, {-110, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure Sink(redeclare package Medium = Medium, p0 = 10000, T = 300) annotation(
    Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT SensT1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-60, -6}, {-40, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT SensT2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{70, -6}, {90, 14}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV hex(redeclare package Medium = Medium, N = Nnodes, L = Lhex, A = Ahex, omega = omegahex, Dhyd = Dihex, wnom = whex, Cfnom = Cfhex, Tstartin = Tinhex, Tstartout = Touthex, pstart = phex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, initOpt = ThermoPower.Choices.Init.Options.steadyState, dpnom = 1000) annotation(
    Placement(transformation(extent = {{-20, -10}, {0, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV flow1DFV(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(extent = {{-20, -90}, {0, -70}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1DFV(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(extent = {{-20, -60}, {0, -40}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource(Nw = Nnodes - 1) annotation(
    Placement(transformation(extent = {{-20, 16}, {0, 36}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valveLin(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{190, -90}, {210, -70}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-240, -90}, {-220, -70}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation(
    Placement(visible = true, transformation(extent = {{250, -90}, {270, -70}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{220, -86}, {240, -66}}, rotation = 0)));
  ThermoPower.Gas.SensW sensW(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-170, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-170, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = Medium, R = 1000) annotation(
    Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation(
    Placement(visible = true, transformation(origin = {-200, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, use_in_w0 = true) annotation(
    Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-140, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {60, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensW sensW1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure2(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {90, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow1(redeclare package Medium = Medium, use_in_w0 = true) annotation(
    Placement(visible = true, transformation(origin = {160, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure1(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {130, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP2(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {170, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensP sensP3(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-30, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation(
    Placement(visible = true, transformation(origin = {-130, -160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation(
    Placement(visible = true, transformation(extent = {{-170, -170}, {-150, -150}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1DFV1(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(extent = {{-20, -144}, {0, -124}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV flow1DFV1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(extent = {{-20, -170}, {0, -150}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valveLin1(redeclare package Medium = Medium, Kv = whex / phex) annotation(
    Placement(visible = true, transformation(extent = {{100, -170}, {120, -150}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure3(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation(
    Placement(visible = true, transformation(extent = {{160, -170}, {180, -150}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{130, -166}, {150, -146}}, rotation = 0)));
//  ThermoPower.Gas.SinkMassFlow sinkMassFlow(redeclare package Medium = Medium, use_in_w0 = true) annotation(
//    Placement(visible = true, transformation(origin = {78, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation(
//    Placement(visible = true, transformation(origin = {28, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//  ThermoPower.Gas.SensP sensP4(redeclare package Medium = Medium) annotation(
//    Placement(visible = true, transformation(origin = {58, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdaptor massFlowToPressureAdaptor(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-100, -160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdaptor pressureToMassFlowAdaptor(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-60, -160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdaptor pressureToMassFlowAdaptor1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {80, -160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdaptor massFlowToPressureAdaptor1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {40, -160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(SensT1.outlet, hex.infl) annotation(
    Line(points = {{-44, 0}, {-20, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(hex.outfl, valve.inlet) annotation(
    Line(points = {{0, 0}, {40, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(valve.outlet, SensT2.inlet) annotation(
    Line(points = {{60, 0}, {74, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(SensT2.outlet, Sink.flange) annotation(
    Line(points = {{86, 0}, {100, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(heatSource.wall, hex.wall) annotation(
    Line(points = {{-10, 23}, {-10, 5}}, color = {255, 127, 0}));
  connect(Step1.y, heatSource.power) annotation(
    Line(points = {{-19, 50}, {-10, 50}, {-10, 30}}, color = {0, 0, 127}));
  connect(Step4.y, Source.in_T) annotation(
    Line(points = {{-239, 50}, {-120, 50}, {-120, 5}}, color = {0, 0, 127}));
  connect(Step2.y, valve.cmd) annotation(
    Line(points = {{41, 50}, {50, 50}, {50, 7}}, color = {0, 0, 127}));
  connect(heatSource1DFV.wall, flow1DFV.wall) annotation(
    Line(points = {{-10, -53}, {-10, -75}}, color = {255, 127, 0}));
  connect(Step1.y, heatSource1DFV.power) annotation(
    Line(points = {{-18, 50}, {6, 50}, {6, -30}, {-10, -30}, {-10, -46}}, color = {0, 0, 127}));
  connect(valveLin.outlet, sensT1.inlet) annotation(
    Line(points = {{210, -80}, {224, -80}}, color = {159, 159, 223}));
  connect(sensT1.outlet, sinkPressure.flange) annotation(
    Line(points = {{236, -80}, {250, -80}}, color = {159, 159, 223}));
  connect(Step2.y, valveLin.cmd) annotation(
    Line(points = {{41, 50}, {200, 50}, {200, -73}}, color = {0, 0, 127}));
  connect(Step4.y, sourceMassFlow.in_T) annotation(
    Line(points = {{-239, 50}, {-230, 50}, {-230, -75}}, color = {0, 0, 127}));
  connect(Source.flange, pressDropLin.inlet) annotation(
    Line(points = {{-110, 0}, {-92, 0}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, SensT1.inlet) annotation(
    Line(points = {{-72, 0}, {-56, 0}}, color = {159, 159, 223}));
  connect(sourceMassFlow.flange, pressDropLin1.inlet) annotation(
    Line(points = {{-220, -80}, {-210, -80}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, flow1DFV.infl) annotation(
    Line(points = {{-40, -80}, {-20, -80}}, color = {159, 159, 223}));
  connect(sourcePressure.flange, throughMassFlow.inlet) annotation(
    Line(points = {{-70, -80}, {-60, -80}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensW.inlet) annotation(
    Line(points = {{-190, -80}, {-176, -80}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensP.flange) annotation(
    Line(points = {{-190, -80}, {-184, -80}, {-184, -54}, {-170, -54}}, color = {159, 159, 223}));
  connect(sensW.w, throughMassFlow.in_w0) annotation(
    Line(points = {{-163, -70}, {-154, -70}, {-154, -46}, {-56, -46}, {-56, -75}}, color = {0, 0, 127}));
  connect(sensP.p, sourcePressure.in_p0) annotation(
    Line(points = {{-163, -44}, {-86, -44}, {-86, -74}}, color = {0, 0, 127}));
  connect(sensW.outlet, sensT.inlet) annotation(
    Line(points = {{-164, -80}, {-146, -80}}, color = {159, 159, 223}));
  connect(sensT.outlet, sinkPressure1.flange) annotation(
    Line(points = {{-134, -80}, {-120, -80}}, color = {159, 159, 223}));
  connect(sensT.T, sourcePressure.in_T) annotation(
    Line(points = {{-133, -70}, {-128, -70}, {-128, -48}, {-80, -48}, {-80, -70}}, color = {0, 0, 127}));
  connect(flow1DFV.outfl, sensW1.inlet) annotation(
    Line(points = {{0, -80}, {24, -80}}, color = {159, 159, 223}));
  connect(sensW1.outlet, sensT2.inlet) annotation(
    Line(points = {{36, -80}, {54, -80}}, color = {159, 159, 223}));
  connect(sensT2.outlet, sinkPressure2.flange) annotation(
    Line(points = {{66, -80}, {80, -80}}, color = {159, 159, 223}));
  connect(flow1DFV.outfl, sensP1.flange) annotation(
    Line(points = {{0, -80}, {12, -80}, {12, -54}, {30, -54}}, color = {159, 159, 223}));
  connect(sourcePressure1.flange, throughMassFlow1.inlet) annotation(
    Line(points = {{140, -80}, {150, -80}}, color = {159, 159, 223}));
  connect(throughMassFlow1.outlet, valveLin.inlet) annotation(
    Line(points = {{170, -80}, {190, -80}}, color = {159, 159, 223}));
  connect(sensP1.p, sourcePressure1.in_p0) annotation(
    Line(points = {{38, -44}, {124, -44}, {124, -74}}, color = {0, 0, 127}));
  connect(sensT2.T, sourcePressure1.in_T) annotation(
    Line(points = {{68, -70}, {74, -70}, {74, -48}, {130, -48}, {130, -70}}, color = {0, 0, 127}));
  connect(sensW1.w, throughMassFlow1.in_w0) annotation(
    Line(points = {{38, -70}, {48, -70}, {48, -46}, {154, -46}, {154, -74}}, color = {0, 0, 127}));
  connect(throughMassFlow1.outlet, sensP2.flange) annotation(
    Line(points = {{170, -80}, {170, -58}}, color = {159, 159, 223}));
  connect(sensP2.p, sinkPressure2.in_p0) annotation(
    Line(points = {{177, -48}, {180, -48}, {180, -42}, {84, -42}, {84, -74}}, color = {0, 0, 127}));
  connect(throughMassFlow.outlet, sensP3.flange) annotation(
    Line(points = {{-40, -80}, {-30, -80}, {-30, -40}}, color = {159, 159, 223}));
  connect(sensP3.p, sinkPressure1.in_p0) annotation(
    Line(points = {{-23, -30}, {-20, -30}, {-20, -20}, {-116, -20}, {-116, -74}}, color = {0, 0, 127}));
  connect(Step4.y, sourceMassFlow1.in_T) annotation(
    Line(points = {{-238, 50}, {-230, 50}, {-230, -48}, {-250, -48}, {-250, -136}, {-160, -136}, {-160, -155}}, color = {0, 0, 127}));
  connect(Step1.y, heatSource1DFV1.power) annotation(
    Line(points = {{-18, 50}, {8, 50}, {8, -110}, {-10, -110}, {-10, -130}}, color = {0, 0, 127}));
  connect(sourceMassFlow1.flange, pressDropLin2.inlet) annotation(
    Line(points = {{-150, -160}, {-140, -160}}, color = {159, 159, 223}));
  connect(heatSource1DFV1.wall, flow1DFV1.wall) annotation(
    Line(points = {{-10, -137}, {-10, -155}}, color = {255, 127, 0}));
  connect(valveLin1.outlet, sensT3.inlet) annotation(
    Line(points = {{120, -160}, {134, -160}}, color = {159, 159, 223}));
  connect(sensT3.outlet, sinkPressure3.flange) annotation(
    Line(points = {{146, -160}, {160, -160}}, color = {159, 159, 223}));
  connect(sensT.T, sinkPressure1.in_T) annotation(
    Line(points = {{-132, -70}, {-126, -70}, {-126, -50}, {-110, -50}, {-110, -70}}, color = {0, 0, 127}));
  connect(sensT2.T, sinkPressure2.in_T) annotation(
    Line(points = {{68, -70}, {76, -70}, {76, -50}, {90, -50}, {90, -70}}, color = {0, 0, 127}));
  connect(pressDropLin2.outlet, massFlowToPressureAdaptor.flange) annotation(
    Line(points = {{-120, -160}, {-104, -160}}, color = {159, 159, 223}));
  connect(flow1DFV1.infl, pressureToMassFlowAdaptor.flange) annotation(
    Line(points = {{-20, -160}, {-56, -160}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdaptor.T, pressureToMassFlowAdaptor.T) annotation(
    Line(points = {{-94, -146}, {-66, -146}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor.p, pressureToMassFlowAdaptor.p) annotation(
    Line(points = {{-94, -152}, {-66, -152}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor.m_dot, massFlowToPressureAdaptor.m_dot) annotation(
    Line(points = {{-66, -174}, {-94, -174}}, color = {0, 0, 127}));
  connect(valveLin1.inlet, pressureToMassFlowAdaptor1.flange) annotation(
    Line(points = {{100, -160}, {84, -160}}, color = {159, 159, 223}));
  connect(Step2.y, valveLin1.cmd) annotation(
    Line(points = {{42, 50}, {286, 50}, {286, -110}, {110, -110}, {110, -153}}, color = {0, 0, 127}));
  connect(flow1DFV1.outfl, massFlowToPressureAdaptor1.flange) annotation(
    Line(points = {{0, -160}, {36, -160}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdaptor1.T, pressureToMassFlowAdaptor1.T) annotation(
    Line(points = {{46, -146}, {74, -146}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p, pressureToMassFlowAdaptor1.p) annotation(
    Line(points = {{46, -152}, {74, -152}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot, massFlowToPressureAdaptor1.m_dot) annotation(
    Line(points = {{74, -174}, {46, -174}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
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
end ExtFun_adaptors;
