within PL_Lib.Utilities;

model PressureToMassFlowAdaptor
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
  outer ThermoPower.System system "System wide properties";
  parameter Boolean allowFlowReversal=system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate=true);  
  ThermoPower.Gas.FlangeB flange(redeclare package Medium = Medium, m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p(final quantity="Pressure", final unit="Pa", displayUnit="bar", min=0) "Pressure in port medium" annotation(
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_dot(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", min = 0) annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0) annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensW sensW(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(p, sourceP.in_p0) annotation(
    Line(points = {{-100, 20}, {-66, 20}, {-66, 6}}, color = {0, 0, 127}));
  connect(T, sourceP.in_T) annotation(
    Line(points = {{-100, 40}, {-60, 40}, {-60, 10}}, color = {0, 0, 127}));
  connect(sourceP.flange, sensW.inlet) annotation(
    Line(points = {{-50, 0}, {-6, 0}}, color = {159, 159, 223}));
  connect(sensW.outlet, flange) annotation(
    Line(points = {{6, 0}, {80, 0}}, color = {159, 159, 223}));
  connect(sensW.w, m_dot) annotation(
    Line(points = {{8, 10}, {10, 10}, {10, 60}, {-100, 60}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-20, 100}, {20, -100}}, radius = 10), Text(origin = {0, 40}, extent = {{-20, 10}, {20, -10}}, textString = "p"), Text(origin = {0, 70}, extent = {{-20, 10}, {20, -10}}, textString = "T"), Text(origin = {0, -70}, extent = {{-20, 10}, {20, -10}}, textString = "m_dot")}));
end PressureToMassFlowAdaptor;
