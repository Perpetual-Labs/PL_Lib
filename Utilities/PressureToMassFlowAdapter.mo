within PL_Lib.Utilities;
model PressureToMassFlowAdapter
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
  outer ThermoPower.System system "System wide properties";
  parameter Boolean allowFlowReversal=system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate=true);

  parameter Modelica.SIunits.Temperature T0 = 300 "Initial temperature";
  parameter Modelica.SIunits.Pressure p0 = 101325 "Initial pressure";
  parameter Real Ts = 0.1 "Time constant";

  ThermoPower.Gas.FlangeB flange(redeclare package Medium = Medium, m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP(redeclare package Medium = Medium, use_in_T = true, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p(final quantity="Pressure", final unit="Pa", displayUnit="bar", min=0) "Pressure in port medium" annotation (
    Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_dot(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", min = 0) annotation (
    Placement(visible = true, transformation(origin = {-100, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0) annotation (
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensW sensW(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_T(T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = T0)  annotation (
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_p(T = Ts, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = p0)  annotation (
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sourceP.flange, sensW.inlet) annotation (
    Line(points = {{-20, 0}, {-6, 0}}, color = {159, 159, 223}));
  connect(sensW.outlet, flange) annotation (
    Line(points = {{6, 0}, {80, 0}}, color = {159, 159, 223}));
  connect(sensW.w, m_dot) annotation (
    Line(points = {{8, 10}, {10, 10}, {10, 70}, {-100, 70}}, color = {0, 0, 127}));
  connect(p, firstOrder_p.u) annotation (
    Line(points = {{-100, 20}, {-82, 20}}, color = {0, 0, 127}));
  connect(firstOrder_p.y, sourceP.in_p0) annotation (
    Line(points = {{-58, 20}, {-36, 20}, {-36, 6}}, color = {0, 0, 127}));
  connect(T, firstOrder_T.u) annotation (
    Line(points = {{-100, 50}, {-62, 50}}, color = {0, 0, 127}));
  connect(firstOrder_T.y, sourceP.in_T) annotation (
    Line(points = {{-39, 50}, {-30, 50}, {-30, 10}}, color = {0, 0, 127}));
  annotation (
    Icon(graphics={  Rectangle(lineColor = {159, 159, 223}, fillColor = {255, 255, 255},
            fillPattern =                                                                              FillPattern.Solid,
            lineThickness =                                                                                                               0.5, extent = {{-20, 100}, {20, -100}}, radius = 10), Text(origin = {0, 40}, extent = {{-20, 10}, {20, -10}}, textString = "p"), Text(origin = {0, 70}, extent = {{-20, 10}, {20, -10}}, textString = "T"), Text(origin = {0, -70}, extent = {{-20, 10}, {20, -10}}, textString = "w")}));
end PressureToMassFlowAdapter;
