within PL_Lib.Utilities;

model MassFlowToPressureAdaptor
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  outer ThermoPower.System system "System wide properties";
  parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(
    Evaluate = true);
  ThermoPower.Gas.FlangeA flange(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  ThermoPower.Gas.SensP sensP(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-10, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensW sensW(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-10, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {20, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP(redeclare package Medium = Medium, use_in_T = false, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0) "Pressure in port medium" annotation(
    Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput T(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0) "Temperature in port medium" annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p_back(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0) "Pressure in port medium" annotation(
    Placement(visible = true, transformation(origin = {110, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {30, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_dot(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", min = 0) "Mass flow rate in port medium" annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sensT.outlet, sinkP.flange) annotation(
    Line(points = {{26, 0}, {50, 0}}, color = {159, 159, 223}));
  connect(sensW.outlet, sensT.inlet) annotation(
    Line(points = {{-4, 0}, {14, 0}}, color = {159, 159, 223}));
  connect(flange, sensW.inlet) annotation(
    Line(points = {{-60, 0}, {-16, 0}}, color = {159, 159, 223}));
  connect(flange, sensP.flange) annotation(
    Line(points = {{-60, 0}, {-30, 0}, {-30, 70}, {-10, 70}}, color = {159, 159, 223}));
  connect(sensP.p, p) annotation(
    Line(points = {{-3, 80}, {110, 80}}, color = {0, 0, 127}));
  connect(sensT.T, T) annotation(
    Line(points = {{27, 10}, {32, 10}, {32, 40}, {110, 40}}, color = {0, 0, 127}));
  connect(sensW.w, m_dot) annotation(
    Line(points = {{-2, 10}, {10, 10}, {10, 60}, {110, 60}}, color = {0, 0, 127}));
  connect(p_back, sinkP.in_p0) annotation(
    Line(points = {{110, 20}, {54, 20}, {54, 6}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-20, 100}, {20, -100}}, radius = 10), Text(origin = {0, -20}, extent = {{-20, 10}, {20, -10}}, textString = "p_back"), Text(origin = {0, 50}, extent = {{-20, 10}, {20, -10}}, textString = "T"), Text(origin = {0, 20}, extent = {{-20, 10}, {20, -10}}, textString = "m_dot"), Text(origin = {0, 80}, extent = {{-20, 10}, {20, -10}}, textString = "p")}));
end MassFlowToPressureAdaptor;
