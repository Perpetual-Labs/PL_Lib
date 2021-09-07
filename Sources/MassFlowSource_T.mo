within PL_Lib.Sources;

model MassFlowSource_T
  extends PL_Lib.Interfaces.PartialOnePort;
  parameter Modelica.SIunits.MassFlowRate m_dot_0 = 0;
  Modelica.Blocks.Interfaces.RealInput m_dot_in annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  fluidPort_b.m_flow = - m_dot_in;
  if cardinality(m_dot_in) == 0 then
    m_dot_in = m_dot_0 "Flow rate set by parameter";
  end if;
  
annotation(
    Diagram(graphics = {Rectangle(lineThickness = 1, extent = {{-100, 100}, {100, -100}}, radius = 40)}),
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid,lineThickness = 1, extent = {{-100, 100}, {100, -100}}, radius = 40), Text(origin = {0, 120}, extent = {{-100, 20}, {100, -20}}, textString = "%name"), Line(points = {{-68, 0}, {80, 0}}, thickness = 2, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 30)}));
end MassFlowSource_T;
