within PL_Lib.ModelsWIP;
model PHX_extFun "Test case for Gas.Flow1DFV"
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
  Modelica.Blocks.Sources.Step step1(height = -45, offset = 273.15 + 20, startTime = 10) annotation (
    Placement(visible = true, transformation(extent = {{-200, 40}, {-180, 60}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-140, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-120, 24}, {-100, 44}}, rotation = 0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdapter1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-80,30},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Utilities.HX_extFun ExtFun annotation (
    Placement(visible = true, transformation(origin = {-8, -10}, extent = {{-20, -28}, {20, 28}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure2(redeclare package Medium = Medium, T = 273.15 + 200, p0 = 200000) annotation (
    Placement(visible = true, transformation(origin = {-170, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-140, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{-120, -56}, {-100, -36}}, rotation = 0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdapter2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-80,-50},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourcePressure1(redeclare package Medium = Medium, T = 273.15 + 20, use_in_T = true) annotation (
    Placement(visible = true, transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = Medium,R = 1000) annotation (
    Placement(visible = true, transformation(origin = {98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{110, -56}, {130, -36}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step1(height = 500, startTime = 20) annotation (
    Placement(visible = true, transformation(extent = {{110, 60}, {130, 80}}, rotation = 0)));
  ThermoPower.Thermal.HeatSource1DFV heatSource1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(extent = {{130, 40}, {150, 60}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation (
    Placement(visible = true, transformation(extent = {{146, -28}, {166, -8}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {180, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow1(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {76, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {242, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdapter(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={54,-50},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.1, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 300)  annotation (
    Placement(visible = true, transformation(origin = {40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = 0.1, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 101325) annotation (
    Placement(visible = true, transformation(origin = {20, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pressDropLin1.outlet, sensT1.inlet) annotation (
    Line(points = {{-130, 30}, {-116, 30}}, color = {159, 159, 223}));
  connect(sensT1.outlet, massFlowToPressureAdapter1.flange) annotation (
    Line(points = {{-104, 30}, {-84, 30}}, color = {159, 159, 223}));
  connect(massFlowToPressureAdapter1.T, ExtFun.T_cold_in) annotation (
    Line(points = {{-74, 44}, {-38, 44}, {-38, 14}, {-30, 14}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter1.p, ExtFun.p_cold_in) annotation (
    Line(points = {{-74, 38}, {-40, 38}, {-40, 8}, {-30, 8}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter1.d, ExtFun.d_cold_in) annotation (
    Line(points = {{-74, 32}, {-44, 32}, {-44, -4}, {-30, -4}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter2.d, ExtFun.d_hot_in) annotation (
    Line(points = {{-74, -48}, {-38, -48}, {-38, -34}, {-30, -34}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter2.p, ExtFun.p_hot_in) annotation (
    Line(points = {{-74, -42}, {-42, -42}, {-42, -22}, {-30, -22}}, color = {0, 0, 127}));
  connect(massFlowToPressureAdapter2.T, ExtFun.T_hot_in) annotation (
    Line(points = {{-74, -36}, {-44, -36}, {-44, -16}, {-30, -16}}, color = {0, 0, 127}));
  connect(pressDropLin3.outlet, sensT3.inlet) annotation (
    Line(points = {{-130, -50}, {-116, -50}}, color = {159, 159, 223}));
  connect(sensT3.outlet, massFlowToPressureAdapter2.flange) annotation (
    Line(points = {{-104, -50}, {-84, -50}}, color = {159, 159, 223}));
  connect(sourcePressure2.flange, pressDropLin3.inlet) annotation (
    Line(points = {{-160, -50}, {-150, -50}}, color = {159, 159, 223}));
  connect(sourcePressure1.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-160, 30}, {-150, 30}}, color = {159, 159, 223}));
  connect(step1.y, sourcePressure1.in_T) annotation (
    Line(points = {{-178, 50}, {-170, 50}, {-170, 40}}, color = {0, 0, 127}));
  connect(pressDropLin4.outlet, sensT4.inlet) annotation (
    Line(points = {{108, -98}, {111, -98}, {111, -50}, {114, -50}}, color = {159, 159, 223}));
  connect(const.y, ExtFun.w_cold_in) annotation (
    Line(points = {{-79, -10}, {-60, -10}, {-60, 2}, {-30, 2}}, color = {0, 0, 127}));
  connect(const.y, ExtFun.w_hot_in) annotation (
    Line(points = {{-79, -10}, {-60, -10}, {-60, -28}, {-30, -28}}, color = {0, 0, 127}));
  connect(heatSource1.wall, HEX1.wall) annotation (
    Line(points = {{140, 47}, {140, 41}, {156, 41}, {156, -13}}, color = {255, 127, 0}));
  connect(Step1.y, heatSource1.power) annotation (
    Line(points = {{131, 70}, {140, 70}, {140, 54}}, color = {0, 0, 127}));
  connect(sourcePressure.flange, throughMassFlow.inlet) annotation (
    Line(points = {{90, 30}, {100, 30}}, color = {159, 159, 223}));
  connect(const.y, massFlowToPressureAdapter2.m_dot) annotation (
    Line(points = {{-79, -10}, {-60, -10}, {-60, -64}, {-74, -64}}, color = {0, 0, 127}));
  connect(const.y, massFlowToPressureAdapter1.m_dot) annotation (
    Line(points = {{-78, -10}, {-60, -10}, {-60, 16}, {-74, 16}}, color = {0, 0, 127}));
  connect(ExtFun.T_hot_out, firstOrder.u) annotation (
    Line(points = {{14, -20}, {20, -20}, {20, 12}, {28, 12}}, color = {0, 0, 127}));
  connect(firstOrder.y, pressureToMassFlowAdapter.T) annotation (
    Line(points = {{52, 12}, {64, 12}, {64, -10}, {40, -10}, {40, -36}, {48, -36}}, color = {0, 0, 127}));
  connect(firstOrder1.y, pressureToMassFlowAdapter.p) annotation (
    Line(points = {{32, -64}, {36, -64}, {36, -42}, {48, -42}}, color = {0, 0, 127}));
  connect(ExtFun.p_hot_out, firstOrder1.u) annotation (
    Line(points = {{14, -28}, {22, -28}, {22, -44}, {-2, -44}, {-2, -64}, {8, -64}}, color = {0, 0, 127}));
  connect(sensT4.outlet, HEX1.infl) annotation (
    Line(points = {{126, -50}, {134, -50}, {134, -18}, {146, -18}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, sinkPressure.flange) annotation (
    Line(points = {{120, 30}, {170, 30}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdapter.flange, throughMassFlow1.inlet) annotation (
    Line(points = {{58, -50}, {66, -50}, {66, -68}}, color = {159, 159, 223}));
  connect(throughMassFlow1.outlet, pressDropLin4.inlet) annotation (
    Line(points = {{86, -68}, {96, -68}, {96, -82}, {80, -82}, {80, -98}, {88, -98}}, color = {159, 159, 223}));
  connect(HEX1.outfl, sinkPressure1.flange) annotation (
    Line(points = {{166, -18}, {176, -18}, {176, -50}, {232, -50}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
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
end PHX_extFun;
