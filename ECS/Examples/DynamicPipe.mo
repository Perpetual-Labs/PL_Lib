within PL_Lib.ECS.Examples;

model DynamicPipe
  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.DynamicFreeInitial) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa;
  Modelica.Fluid.Sources.MassFlowSource_T boundary(nPorts = 1, use_m_flow_in = true, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-26, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts = 1, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {34, 4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe(redeclare package Medium = Medium, diameter = 0.08, length = 10) annotation(
    Placement(visible = true, transformation(origin = {4, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 200, height = 2.5) annotation(
    Placement(visible = true, transformation(origin = {-84, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp.y, boundary.m_flow_in) annotation(
    Line(points = {{-73, 12}, {-36, 12}}, color = {0, 0, 127}));
  connect(boundary.ports[1], pipe.port_a) annotation(
    Line(points = {{-16, 4}, {-6, 4}}, color = {0, 127, 255}));
  connect(pipe.port_b, boundary1.ports[1]) annotation(
    Line(points = {{14, 4}, {24, 4}}, color = {0, 127, 255}));
end DynamicPipe;
