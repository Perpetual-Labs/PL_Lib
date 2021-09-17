within PL_Lib.ModelsWIP;

model HX_Gas2Gas "Simple plant model with HRB"
  extends Modelica.Icons.Example;
  replaceable package GasMedium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
    Placement(transformation(extent = {{140, 140}, {160, 160}})));
  parameter Modelica.SIunits.Time Ts = 4 "Temperature sensor time constant";
  
  ThermoPower.Gas.SinkPressure sinkP_BA(redeclare package Medium = GasMedium, T = 273.15 + 60) annotation(
    Placement(visible = true, transformation(extent = {{120, -10}, {140, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin PressDropLin1(redeclare package Medium = GasMedium, R = 1000 / 10) annotation(
    Placement(transformation(extent = {{60, -10}, {80, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BAout(redeclare package Medium = GasMedium) annotation(
    Placement(transformation(extent = {{30, -6}, {50, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BAin(redeclare package Medium = GasMedium) annotation(
    Placement(transformation(extent = {{-60, -6}, {-40, 14}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceW_BA(redeclare package Medium = GasMedium, T = 273.15 + 200, p0 = 2 * 101325, use_in_w0 = false, w0 = 10) annotation(
    Placement(visible = true, transformation(extent = {{-96, -10}, {-76, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RAin(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-20, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RAout(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {20, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure_RA(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput WaterOut_T annotation(
    Placement(transformation(extent = {{160, -50}, {180, -30}}, rotation = 0), iconTransformation(extent = {{94, -30}, {114, -10}})));
  Modelica.Blocks.Interfaces.RealOutput WaterIn_T annotation(
    Placement(visible = true, transformation(extent = {{160, -90}, {180, -70}}, rotation = 0), iconTransformation(extent = {{94, -70}, {114, -50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput GasOut_T annotation(
    Placement(visible = true, transformation(extent = {{160, 80}, {180, 100}}, rotation = 0), iconTransformation(extent = {{92, 50}, {112, 70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput GasIn_T annotation(
    Placement(transformation(extent = {{160, 30}, {180, 50}}, rotation = 0), iconTransformation(extent = {{94, 10}, {114, 30}})));
  Modelica.Blocks.Continuous.FirstOrder GasFlowActuator( T = 1, initType = Modelica.Blocks.Types.Init.SteadyState,k = 1, y_start = 5) annotation(
    Placement(visible = true, transformation(extent = {{-120, 10}, {-100, 30}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder WaterInTSensor(k = 1, T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 296) annotation(
    Placement(visible = true, transformation(extent = {{120, -90}, {140, -70}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder WaterOutTSensor(k = 1, T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 330) annotation(
    Placement(transformation(extent = {{120, -50}, {140, -30}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder GasInTSensor(k = 1, T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 670) annotation(
    Placement(transformation(extent = {{120, 30}, {140, 50}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder GasOutTSensor(k = 1, T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 350) annotation(
    Placement(visible = true, transformation(extent = {{120, 80}, {140, 100}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder ValveOpeningActuator(k = 1, T = 1, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 1) annotation(
    Placement(visible = true, transformation(extent = {{-56, -92}, {-36, -72}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = -0.1, offset = 1, startTime = 50) annotation(
    Placement(visible = true, transformation(extent = {{-94, -92}, {-74, -72}}, rotation = 0)));
  Modelica.Blocks.Sources.Step TWOutSetPoint(height = -140, offset = 273.15 + 200, startTime = 60) annotation(
    Placement(visible = true, transformation(extent = {{-220, 10}, {-200, 30}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI TempController(T = 20, initType = Modelica.Blocks.Types.Init.SteadyState, k = 0.4) annotation(
    Placement(visible = true, transformation(extent = {{-160, 10}, {-140, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback Feedback1 annotation(
    Placement(visible = true, transformation(extent = {{-190, 30}, {-170, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = GasMedium, R = 1000 / 10) annotation(
    Placement(visible = true, transformation(extent = {{38, -70}, {58, -50}}, rotation = 0)));
  PL_Lib.Components.HXg2g HEX(redeclare package GasMedium1 = GasMedium, redeclare package GasMedium2 = GasMedium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 3, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom(displayUnit = "kg/m3") = 7800) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow(redeclare package Medium = GasMedium, T = 300, p0 = 101325, w0 = 10)  annotation(
    Placement(visible = true, transformation(origin = {-56, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GasInTSensor.u, sensT_BAin.T) annotation(
    Line(points = {{118, 40}, {-32, 40}, {-32, 10}, {-43, 10}}, color = {0, 0, 127}));
  connect(sensT_BAout.T, GasOutTSensor.u) annotation(
    Line(points = {{47, 10}, {60, 10}, {60, 90}, {118, 90}}, color = {0, 0, 127}));
  connect(GasOutTSensor.y, GasOut_T) annotation(
    Line(points = {{141, 90}, {170, 90}}, color = {0, 0, 127}));
  connect(WaterOutTSensor.y, WaterOut_T) annotation(
    Line(points = {{141, -40}, {170, -40}}, color = {0, 0, 127}));
  connect(GasInTSensor.y, GasIn_T) annotation(
    Line(points = {{141, 40}, {170, 40}}, color = {0, 0, 127}));
  connect(WaterInTSensor.y, WaterIn_T) annotation(
    Line(points = {{141, -80}, {170, -80}}, color = {0, 0, 127}));
  connect(PressDropLin1.outlet, sinkP_BA.flange) annotation(
    Line(points = {{80, 0}, {120, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT_BAout.outlet, PressDropLin1.inlet) annotation(
    Line(points = {{46, 0}, {60, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sourceW_BA.flange, sensT_BAin.inlet) annotation(
    Line(points = {{-76, 0}, {-56, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT_RAin.T, WaterInTSensor.u) annotation(
    Line(points = {{-13, 70}, {100, 70}, {100, -80}, {118, -80}}, color = {0, 0, 127}));
  connect(sensT_RAout.T, WaterOutTSensor.u) annotation(
    Line(points = {{27, -50}, {30, -50}, {30, -40}, {118, -40}}, color = {0, 0, 127}));
  connect(TWOutSetPoint.y, Feedback1.u1) annotation(
    Line(points = {{-199, 20}, {-188, 20}}, color = {0, 0, 127}));
  connect(Feedback1.y, TempController.u) annotation(
    Line(points = {{-171, 20}, {-162, 20}}, color = {0, 0, 127}));
  connect(step.y, ValveOpeningActuator.u) annotation(
    Line(points = {{-73, -82}, {-58, -82}}, color = {0, 0, 127}));
  connect(TempController.y, GasFlowActuator.u) annotation(
    Line(points = {{-139, 20}, {-122, 20}}, color = {0, 0, 127}));
  connect(sensT_RAout.outlet, pressDropLin.inlet) annotation(
    Line(points = {{26, -60}, {38, -60}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, sinkPressure_RA.flange) annotation(
    Line(points = {{58, -60}, {70, -60}}, color = {159, 159, 223}));
  connect(GasFlowActuator.y, sourceW_BA.in_w0) annotation(
    Line(points = {{-98, 20}, {-92, 20}, {-92, 6}}, color = {0, 0, 127}));
  connect(sensT_BAin.outlet, HEX.gasIn1) annotation(
    Line(points = {{-44, 0}, {-20, 0}}, color = {159, 159, 223}));
  connect(sensT_RAin.outlet, HEX.gasIn2) annotation(
    Line(points = {{-14, 60}, {0, 60}, {0, 20}}, color = {159, 159, 223}));
  connect(HEX.gasOut1, sensT_BAout.inlet) annotation(
    Line(points = {{20, 0}, {34, 0}}, color = {159, 159, 223}));
  connect(HEX.gasOut2, sensT_RAout.inlet) annotation(
    Line(points = {{0, -20}, {0, -60}, {14, -60}}, color = {159, 159, 223}));
  connect(GasOut_T, Feedback1.u2) annotation(
    Line(points = {{170, 90}, {200, 90}, {200, 120}, {-180, 120}, {-180, 28}}, color = {0, 0, 127}));
  connect(sourceMassFlow.flange, sensT_RAin.inlet) annotation(
    Line(points = {{-46, 60}, {-26, 60}}, color = {159, 159, 223}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}, initialScale = 0.1), graphics),
    Documentation(revisions = "<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>
          ", info = "<html>
Very simple plant model, providing boundary conditions to the <tt>HRB</tt> model.
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.8));
end HX_Gas2Gas;
