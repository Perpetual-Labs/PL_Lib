within PL_Lib.ECS.Examples;

model PipesHEX
  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.DynamicFreeInitial, m_flow_start = 0.01) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa;
  Modelica.Fluid.Sources.Boundary_pT ambient1(T = 300, nPorts = 1, p = 1e5, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{100, 40}, {80, 60}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate1(T = 300, m_flow = 0.2, nPorts = 1, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{-100, -20}, {-80, 0}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T massFlowRate2(redeclare package Medium = Medium, T = 360, m_flow = 0.2, nPorts = 1, use_T_in = false, use_X_in = false, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(extent = {{-100, 40}, {-80, 60}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT ambient2(T = 280, nPorts = 1, p = 1e5, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(extent = {{100, -20}, {80, 0}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp Ramp1(duration = 5, height = 0.4, offset = -0.2, startTime = 50) annotation(
    Placement(visible = true, transformation(extent = {{-138, 46}, {-118, 66}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(diameter = 0.08, length = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(diameter = 0.08, length = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Ramp1.y, massFlowRate2.m_flow_in) annotation(
    Line(points = {{-117, 56}, {-108.5, 56}, {-108.5, 58}, {-100, 58}}, color = {0, 0, 127}));
  connect(massFlowRate2.ports[1], pipe1.port_a) annotation(
    Line(points = {{-80, 50}, {-20, 50}}, color = {0, 127, 255}));
  connect(pipe1.port_b, ambient1.ports[1]) annotation(
    Line(points = {{0, 50}, {80, 50}}, color = {0, 127, 255}));
  connect(massFlowRate1.ports[1], pipe2.port_a) annotation(
    Line(points = {{-80, -10}, {-20, -10}}, color = {0, 127, 255}));
  connect(pipe2.port_b, ambient2.ports[1]) annotation(
    Line(points = {{0, -10}, {80, -10}}, color = {0, 127, 255}));
  connect(wallConstProps.heatPort_a, pipe1.heatPorts) annotation(
    Line(points = {{-10, 26}, {-10, 32}, {10, 32}, {10, 70}, {-10, 70}, {-10, 54}}, color = {191, 0, 0}, thickness = 0.5));
  connect(wallConstProps.heatPort_b, heatPorts.heatPorts) annotation(
    Line(points = {{-10, 16}, {-10, -6}}, color = {191, 0, 0}, thickness = 0.5));
protected
end PipesHEX;
