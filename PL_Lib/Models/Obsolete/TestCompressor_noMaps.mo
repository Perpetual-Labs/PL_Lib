within PL_Lib.Models.Obsolete;
model TestCompressor_noMaps
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Air.DryAirNasa;
  inner ThermoPower.System system annotation (
    Placement(transformation(extent = {{80, 80}, {100, 100}})));
  PL_Lib.Components.Compressor_noMaps compressor(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 300, Tstart_in = 300, Tstart_out = 350, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEta, tablePR = tablePR, tablePhic = tablePhic) annotation (
    Placement(visible = true, transformation(extent = {{-20, -26}, {20, 14}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.8)  annotation (
    Placement(visible = true, transformation(origin = {58, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium)  annotation (
    Placement(visible = true, transformation(origin = {76, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, p0(displayUnit = "Pa") = 2e5)  annotation (
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real tableEta[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhic[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
initial equation
  inertia.w = 500;
equation
  connect(compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{12, -6}, {32, -6}, {32, -34}, {48, -34}}));
  connect(compressor.outlet, sinkPressure.flange) annotation (
    Line(points = {{16, 10}, {66, 10}}, color = {159, 159, 223}));
  connect(sourcePressure.flange, compressor.inlet) annotation (
    Line(points = {{-60, 10}, {-16, 10}}));
  annotation (
    experiment(StopTime = 2),
    experimentSetupOutput,
    Documentation(info = "<html>
This model test the <tt>Compressor</tt> model at constant speed.

<p>Simulate for 2s.

</html>"));
end TestCompressor_noMaps;
