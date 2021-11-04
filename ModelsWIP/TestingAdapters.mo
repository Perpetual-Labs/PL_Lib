within PL_Lib.ModelsWIP;
model TestingAdapters "Test case for Gas.Flow1DFV"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{180, 180}, {200, 200}}, rotation = 0)));
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
    Placement(visible = true, transformation(extent = {{-30, 160}, {-10, 180}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step3(height = 10, offset = Tinhex, startTime = 10) annotation (
    Placement(visible = true, transformation(extent = {{-200, 160}, {-180, 180}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step2(height = -0.2, offset = 1, startTime = 40) annotation (
    Placement(visible = true, transformation(extent = {{60, 160}, {80, 180}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation (
    Placement(visible = true, transformation(extent = {{-170, 110}, {-150, 130}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium, p0 = 10000, T = 300) annotation (
    Placement(visible = true, transformation(extent = {{152, 110}, {172, 130}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, 114}, {-90, 134}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, 114}, {140, 134}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1(redeclare package Medium = Medium, N = Nnodes, L = Lhex, A = Ahex, omega = omegahex, Dhyd = Dihex, wnom = whex, Cfnom = Cfhex, Tstartin = Tinhex, Tstartout = Touthex, pstart = phex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, initOpt = ThermoPower.Choices.Init.Options.steadyState, dpnom = 1000) annotation (
    Placement(visible = true, transformation(extent = {{-10, 110}, {10, 130}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{-10, 136}, {10, 156}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve1(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, 110}, {110, 130}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow2(redeclare package Medium = Medium, T = Tinhex, p0 = phex, use_in_T = true, w0 = whex) annotation (
    Placement(visible = true, transformation(extent = {{-170, 40}, {-150, 60}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource2(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{-10, 66}, {10, 86}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX2(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(extent = {{-10, 40}, {10, 60}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve2(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, 40}, {110, 60}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure2(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation (
    Placement(visible = true, transformation(extent = {{150, 40}, {170, 60}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, 44}, {140, 64}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, 44}, {-90, 64}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT5(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, -36}, {-90, -16}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.HX_extFun ExtFun annotation (
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, T = 273.15 + 20, use_in_T = true) annotation (
    Placement(visible = true, transformation(origin = {-160, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation (
    Placement(visible = true, transformation(extent = {{150, -40}, {170, -20}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve3(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, -40}, {110, -20}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT6(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, -36}, {140, -16}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure1(redeclare package Medium = Medium, T = 273.15 + 200) annotation (
    Placement(visible = true, transformation(origin = {-160, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT7(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-110, -116}, {-90, -96}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdapter4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-70, -110}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve4(redeclare package Medium = Medium, Kv = whex / phex) annotation (
    Placement(visible = true, transformation(extent = {{90, -120}, {110, -100}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure3(redeclare package Medium = Medium, T = 300, p0 = 10000) annotation (
    Placement(visible = true, transformation(extent = {{150, -120}, {170, -100}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdapter4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {70, -110}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT8(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{120, -116}, {140, -96}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = -0.2, offset = 1, startTime = 40) annotation (
    Placement(visible = true, transformation(extent = {{80, 0}, {100, 20}}, rotation = 0)));
equation
  connect(sensT1.outlet, HEX1.infl) annotation (
    Line(points = {{-94, 120}, {-10, 120}}, color = {159, 159, 223}, thickness = 0.5));
  connect(HEX1.outfl, valve1.inlet) annotation (
    Line(points = {{10, 120}, {90, 120}}, color = {159, 159, 223}, thickness = 0.5));
  connect(valve1.outlet, sensT2.inlet) annotation (
    Line(points = {{110, 120}, {124, 120}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT2.outlet, sinkPressure1.flange) annotation (
    Line(points = {{136, 120}, {152, 120}}, color = {159, 159, 223}, thickness = 0.5));
  connect(heatSource1.wall, HEX1.wall) annotation (
    Line(points = {{0, 143}, {0, 125}}, color = {255, 127, 0}));
  connect(Step1.y, heatSource1.power) annotation (
    Line(points = {{-9, 170}, {0, 170}, {0, 150}}, color = {0, 0, 127}));
  connect(Step2.y, valve1.cmd) annotation (
    Line(points = {{81, 170}, {100, 170}, {100, 127}}, color = {0, 0, 127}));
  connect(sourceMassFlow1.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-150, 120}, {-140, 120}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensT1.inlet) annotation (
    Line(points = {{-120, 120}, {-106, 120}}, color = {159, 159, 223}));
  connect(sourceMassFlow2.flange, pressDropLin2.inlet) annotation (
    Line(points = {{-150, 50}, {-140, 50}}, color = {159, 159, 223}));
  connect(heatSource2.wall, HEX2.wall) annotation (
    Line(points = {{0, 73}, {0, 55}}, color = {255, 127, 0}));
  connect(valve2.outlet, sensT4.inlet) annotation (
    Line(points = {{110, 50}, {124, 50}}, color = {159, 159, 223}));
  connect(sensT4.outlet, sinkPressure2.flange) annotation (
    Line(points = {{136, 50}, {150, 50}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdapter1.T, pressureToMassFlowAdapter1.T) annotation (
    Line(points = {{-64, 64}, {-36, 64}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter1.p, pressureToMassFlowAdapter1.p) annotation (
    Line(points = {{-64, 58}, {-36, 58}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter1.m_dot, massFlowToPressureAdapter1.m_dot) annotation (
    Line(points = {{-36, 36}, {-64, 36}}, color = {0, 0, 127}));
  connect(valve2.inlet, pressureToMassFlowAdapter2.flange) annotation (
    Line(points = {{90, 50}, {74, 50}}, color = {159, 159, 223}));
  connect(HEX2.outfl, massFlowToPressureAdapter2.flange) annotation (
    Line(points = {{10, 50}, {26, 50}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdapter2.T, pressureToMassFlowAdapter2.T) annotation (
    Line(points = {{36, 64}, {64, 64}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter2.p, pressureToMassFlowAdapter2.p) annotation (
    Line(points = {{36, 58}, {64, 58}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter2.m_dot, massFlowToPressureAdapter2.m_dot) annotation (
    Line(points = {{64, 36}, {36, 36}}, color = {0, 0, 127}));
  connect(Step1.y, heatSource2.power) annotation (
    Line(points = {{-9, 170}, {20, 170}, {20, 100}, {0, 100}, {0, 80}}, color = {0, 0, 127}));
  connect(Step2.y, valve2.cmd) annotation (
    Line(points = {{81, 170}, {116, 170}, {116, 100}, {100, 100}, {100, 57}}, color = {0, 0, 127}));
  connect(pressDropLin2.outlet, sensT3.inlet) annotation (
    Line(points = {{-120, 50}, {-106, 50}}, color = {159, 159, 223}));
  connect(sensT3.outlet, massFlowToPressureAdapter1.flange) annotation (
    Line(points = {{-94, 50}, {-74, 50}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdapter1.flange, HEX2.infl) annotation (
    Line(points = {{-26, 50}, {-10, 50}}, color = {159, 159, 223}));
  connect(Step3.y, sourceMassFlow1.in_T) annotation (
    Line(points = {{-179, 170}, {-160, 170}, {-160, 125}}, color = {0, 0, 127}));
  connect(Step3.y, sourceMassFlow2.in_T) annotation (
    Line(points = {{-179, 170}, {-146, 170}, {-146, 70}, {-160, 70}, {-160, 55}}, color = {0, 0, 127}));
  connect(pressDropLin3.outlet, sensT5.inlet) annotation (
    Line(points = {{-120, -30}, {-106, -30}}, color = {159, 159, 223}));
  connect(sensT5.outlet, massFlowToPressureAdapter3.flange) annotation (
    Line(points = {{-94, -30}, {-74, -30}}, color = {159, 159, 223}));
  connect(sourcePressure.flange, pressDropLin3.inlet) annotation (
    Line(points = {{-150, -30}, {-140, -30}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdapter3.T, ExtFun.T_cold_in) annotation (
    Line(points = {{-64, -16}, {-28, -16}, {-28, -46}, {-22, -46}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter3.p, ExtFun.p_cold_in) annotation (
    Line(points = {{-64, -22}, {-30, -22}, {-30, -52}, {-22, -52}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter3.d, ExtFun.d_cold_in) annotation (
    Line(points = {{-64, -28}, {-34, -28}, {-34, -64}, {-22, -64}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.d, ExtFun.d_hot_in) annotation (
    Line(points = {{-64, -108}, {-28, -108}, {-28, -94}, {-22, -94}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.p, ExtFun.p_hot_in) annotation (
    Line(points = {{-64, -102}, {-32, -102}, {-32, -82}, {-22, -82}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter4.T, ExtFun.T_hot_in) annotation (
    Line(points = {{-64, -96}, {-34, -96}, {-34, -76}, {-22, -76}}, color = {0, 0, 127}));
  connect(ExtFun.p_cold_out, pressureToMassFlowAdapter3.p) annotation (
    Line(points = {{22, -60}, {60, -60}, {60, -22}, {64, -22}}, color = {0, 0, 127}));
  connect(ExtFun.T_cold_out, pressureToMassFlowAdapter3.T) annotation (
    Line(points = {{22, -52}, {58, -52}, {58, -16}, {64, -16}}, color = {0, 0, 127}));
  connect(ExtFun.T_hot_out, pressureToMassFlowAdapter4.T) annotation (
    Line(points = {{22, -80}, {60, -80}, {60, -96}, {64, -96}}, color = {0, 0, 127}));
  connect(ExtFun.p_hot_out, pressureToMassFlowAdapter4.p) annotation (
    Line(points = {{22, -88}, {58, -88}, {58, -102}, {64, -102}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter3.flange, valve3.inlet) annotation (
    Line(points = {{74, -30}, {90, -30}}, color = {159, 159, 223}));
  connect(valve3.outlet, sensT6.inlet) annotation (
    Line(points = {{110, -30}, {124, -30}}, color = {159, 159, 223}));
  connect(sensT6.outlet, sinkPressure.flange) annotation (
    Line(points = {{136, -30}, {150, -30}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdapter4.flange, valve4.inlet) annotation (
    Line(points = {{74, -110}, {90, -110}}, color = {159, 159, 223}));
  connect(valve4.outlet, sensT8.inlet) annotation (
    Line(points = {{110, -110}, {124, -110}}, color = {159, 159, 223}));
  connect(sensT8.outlet, sinkPressure3.flange) annotation (
    Line(points = {{136, -110}, {150, -110}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdapter3.m_dot, massFlowToPressureAdapter3.m_dot) annotation (
    Line(points = {{64, -44}, {40, -44}, {40, -28}, {-32, -28}, {-32, -44}, {-64, -44}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter3.m_dot, ExtFun.w_cold_in) annotation (
    Line(points = {{64, -44}, {40, -44}, {40, -28}, {-32, -28}, {-32, -58}, {-22, -58}}, color = {0, 0, 127}));
  connect(sourcePressure1.flange, pressDropLin4.inlet) annotation (
    Line(points = {{-150, -110}, {-140, -110}}, color = {159, 159, 223}));
  connect(pressDropLin4.outlet, sensT7.inlet) annotation (
    Line(points = {{-120, -110}, {-106, -110}}, color = {159, 159, 223}));
  connect(sensT7.outlet, massFlowToPressureAdapter4.flange) annotation (
    Line(points = {{-94, -110}, {-74, -110}}, color = {159, 159, 223}));
  connect(step.y, valve4.cmd) annotation (
    Line(points = {{101, 10}, {116, 10}, {116, -90}, {100, -90}, {100, -103}}, color = {0, 0, 127}));
  connect(step.y, valve3.cmd) annotation (
    Line(points = {{101, 10}, {116, 10}, {116, -10}, {100, -10}, {100, -23}}, color = {0, 0, 127}));
  connect(Step3.y, sourcePressure.in_T) annotation (
    Line(points = {{-178, 170}, {-146, 170}, {-146, -10}, {-160, -10}, {-160, -21}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter4.m_dot, ExtFun.w_hot_in) annotation (
    Line(points = {{64, -124}, {40, -124}, {40, -106}, {-30, -106}, {-30, -88}, {-22, -88}}, color = {0, 0, 127}));
  connect(pressureToMassFlowAdapter4.m_dot, massFlowToPressureAdapter4.m_dot) annotation (
    Line(points = {{64, -124}, {-64, -124}}, color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics = {Rectangle(origin = {-0.02, 54.75}, lineColor = {0, 170, 0}, fillColor = {234, 255, 230}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-49.98, 35.2}, {49.98, -35.2}})}),
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
