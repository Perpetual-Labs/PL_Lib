within PL_Lib.ModelsWIP;

model TestGasMixer_PID
  extends Modelica.Icons.Example;
  //  package Medium = Modelica.Media.IdealGases.MixtureGases.CombustionAir;
  package Medium = Modelica.Media.Air.DryAirNasa;
  parameter Real wext = 10;
  ThermoPower.Gas.Mixer Mixer1(redeclare package Medium = Medium, S = 1, Tstart = 273.15 + 22, V = 3, gamma = 0.8) annotation(
    Placement(transformation(extent = {{-38, -10}, {-18, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDrop PressDrop1(redeclare package Medium = Medium, A = 0.1, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, Tstart = 273.15 + 22, dpnom(displayUnit = "Pa") = 1e5, rhonom = 3.5, wnom = wext) annotation(
    Placement(transformation(extent = {{0, -10}, {22, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure SinkP1(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{106, -10}, {126, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow SourceW2(redeclare package Medium = Medium, T = 273.15 - 10, use_in_T = true, use_in_w0 = false, w0 = 0.25) annotation(
    Placement(transformation(extent = {{-76, -40}, {-56, -20}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Step1(height = -0.2, offset = 1.5, startTime = 15) annotation(
    Placement(visible = true, transformation(extent = {{20, 20}, {40, 40}}, rotation = 0)));
  ThermoPower.Gas.Valve Valve1(redeclare package Medium = Medium, CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, Tstart = 273.15 + 22, dpnom(displayUnit = "Pa") = 200000, pnom = 300000, useThetaInput = true, wnom = wext) annotation(
    Placement(transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow SourceW1(redeclare package Medium = Medium, T = 273.15 + 200, use_in_w0 = true) annotation(
    Placement(transformation(extent = {{-74, 18}, {-54, 38}}, rotation = 0)));
  inner ThermoPower.System system(initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
    Placement(visible = true, transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PID PIDcontrol(Td = 0, Ti = 60, k = 0.4) annotation(
    Placement(visible = true, transformation(origin = {130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Tcabin_set(height = 4, offset = 273.15 + 20, startTime = 500) annotation(
    Placement(visible = true, transformation(origin = {70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {80, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_T_RAin(duration = 600, height = -45, offset = 273.15 + 20, startTime = 300) annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Mixer1.out, PressDrop1.inlet) annotation(
    Line(points = {{-18, 0}, {0, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(SourceW2.flange, Mixer1.in2) annotation(
    Line(points = {{-56, -30}, {-44, -30}, {-44, -6}, {-36, -6}}, color = {159, 159, 223}, thickness = 0.5));
  connect(PressDrop1.outlet, Valve1.inlet) annotation(
    Line(points = {{22, 0}, {40, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Step1.y, Valve1.theta) annotation(
    Line(points = {{41, 30}, {50, 30}, {50, 7.2}}, color = {0, 0, 127}));
  connect(SourceW1.flange, Mixer1.in1) annotation(
    Line(points = {{-54, 28}, {-44, 28}, {-44, 6}, {-36, 6}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Tcabin_set.y, feedback.u1) annotation(
    Line(points = {{81, 60}, {92, 60}}, color = {0, 0, 127}));
  connect(feedback.y, PIDcontrol.u) annotation(
    Line(points = {{109, 60}, {117, 60}}, color = {0, 0, 127}));
  connect(Valve1.outlet, sensT.inlet) annotation(
    Line(points = {{60, 0}, {74, 0}}, color = {159, 159, 223}));
  connect(sensT.outlet, SinkP1.flange) annotation(
    Line(points = {{86, 0}, {106, 0}}, color = {159, 159, 223}));
  connect(sensT.T, feedback.u2) annotation(
    Line(points = {{88, 10}, {100, 10}, {100, 52}}, color = {0, 0, 127}));
  connect(PIDcontrol.y, SourceW1.in_w0) annotation(
    Line(points = {{142, 60}, {150, 60}, {150, 80}, {-70, 80}, {-70, 34}}, color = {0, 0, 127}));
  connect(ramp_T_RAin.y, SourceW2.in_T) annotation(
    Line(points = {{-78, -10}, {-66, -10}, {-66, -24}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics),
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 1e-06, Interval = 0.4),
    Documentation(info = "<html>
This model tests the <tt>Mixer</tt> model.
<p>
Simulate for 20 s. At time t=1 the first inlet flow rate is reduced. At time t=8 the second inlet flow rate is reduced. At time t=15, the outlet valve is partially closed.
</html>"));
end TestGasMixer_PID;
