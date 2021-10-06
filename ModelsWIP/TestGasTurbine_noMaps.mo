within PL_Lib.ModelsWIP;
model TestGasTurbine_noMaps
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Air.DryAirNasa;
  inner ThermoPower.System system annotation (
    Placement(transformation(extent = {{80, 80}, {100, 100}})));

  ThermoPower.Gas.SourcePressure SourceP1(redeclare package Medium = Medium, T = 1270, p0 = 7.85e5) annotation (
    Placement(visible = true, transformation(extent = {{-70, 44}, {-50, 64}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(J = 10000) annotation (
    Placement(visible = true, transformation(extent = {{20, 28}, {40, 48}}, rotation = 0)));
  ThermoPower.Gas.Turbine Turbine1(redeclare package Medium = Medium, tablePhic = tablePhic, tableEta = tableEta, pstart_in = 7.85e5, pstart_out = 1.52e5, Tstart_in = 1270, Tstart_out = 883, Ndesign = 523.3, Tdes_in = 1400, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix) annotation (
    Placement(visible = true, transformation(extent = {{-30, 18}, {10, 58}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure SinkP1(redeclare package Medium = Medium, p0 = 1.52e5, T = 883) annotation (
    Placement(visible = true, transformation(extent = {{50, 44}, {70, 64}}, rotation = 0)));

  PL_Lib.Components.Turbine_noMaps turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEta, tablePhic = tablePhic) annotation (
    Placement(visible = true, transformation(extent = {{-30, -48}, {10, -8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 100) annotation (
    Placement(visible = true, transformation(extent = {{20, -38}, {40, -18}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 273.15, p0 = 1e5) annotation (
    Placement(visible = true, transformation(extent = {{50, -22}, {70, -2}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = Medium, T = 273.15 + 200, p0 = 499999.9999999999) annotation (
    Placement(visible = true, transformation(extent = {{-100, -22}, {-80, -2}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25)  annotation (
    Placement(visible = true, transformation(origin = {-56, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real tablePhic[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEta[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
initial equation
  Inertia1.w = 523.3;
  inertia.w = 523.3;
equation
  connect(SourceP1.flange, Turbine1.inlet) annotation (
    Line(points = {{-50, 54}, {-26, 54}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Turbine1.outlet, SinkP1.flange) annotation (
    Line(points = {{6, 54}, {50, 54}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Turbine1.shaft_b, Inertia1.flange_a) annotation (
    Line(points = {{2, 38}, {6, 38}, {6, 38}, {20, 38}}, thickness = 0.5));
  connect(turbine.outlet, sinkPressure.flange) annotation (
    Line(points = {{6, -12}, {50, -12}}, color = {159, 159, 223}));
  connect(turbine.shaft_b, inertia.flange_a) annotation (
    Line(points = {{2, -28}, {20, -28}}));
  connect(sourcePressure.flange, throughMassFlow.inlet) annotation (
    Line(points = {{-80, -12}, {-66, -12}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, turbine.inlet) annotation (
    Line(points = {{-46, -12}, {-26, -12}}, color = {159, 159, 223}));
  annotation (
    experiment(StopTime = 10),
    experimentSetupOutput,
    Documentation(info = "<html>
This model test the Turbine model with an inertial load. Boundary conditions and data refer to an turbojet engine at 11.000 m.

<p>Simulate for 5 seconds.
</html>"));
end TestGasTurbine_noMaps;
