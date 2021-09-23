within PL_Lib.ModelsWIP;

model TestCompressorInertia_test
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation(
    Placement(transformation(extent = {{80, 80}, {100, 100}})));  
  package Medium = Modelica.Media.Air.DryAirNasa;
  
  ThermoPower.Gas.SourcePressure SourceP1(redeclare package Medium = Medium, T = 273.15 + 70, p0 = 200000) annotation(
    Placement(transformation(extent = {{-80, 6}, {-60, 26}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure SinkP1(redeclare package Medium = Medium, T = 273.15 + 200, p0 = 5e5) annotation(
    Placement(transformation(extent = {{40, 6}, {60, 26}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(J = 1) annotation(
    Placement(transformation(extent = {{10, -10}, {30, 10}}, rotation = 0)));
  ThermoPower.Gas.Compressor Compressor(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 70, Tstart_in = 273.15 + 70, Tstart_out = 273.15 + 200, explicitIsentropicEnthalpy = false, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEta, tablePR = tablePR, tablePhic = tablePhic) annotation(
    Placement(transformation(extent = {{-40, -20}, {0, 20}}, rotation = 0)));

protected
  parameter Real tableEta[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhic[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];

initial equation
  Inertia1.w = 523.3;

equation
  connect(SourceP1.flange, Compressor.inlet) annotation(
    Line(points = {{-60, 16}, {-36, 16}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Compressor.outlet, SinkP1.flange) annotation(
    Line(points = {{-4, 16}, {40, 16}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Compressor.shaft_b, Inertia1.flange_a) annotation(
    Line(points = {{-8, 0}, {-8, -0.05}, {10, -0.05}, {10, 0}}, color = {0, 0, 0}, thickness = 0.5));
  annotation(
    experiment(StopTime = 2),
    experimentSetupOutput,
    Documentation(info = "<html>
This model test the <tt>Compressor</tt> model with an inertial load. Boundary conditions and data refer to an turbojet engine at 11.000 m.

<p>Simulate for 2 seconds. The compressor slows down.
</html>"));
end TestCompressorInertia_test;
