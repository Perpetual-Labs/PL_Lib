within PL_Lib.Sinks;

model SinkP
  extends PL_Lib.Interfaces.PartialOnePort;
  parameter Modelica.SIunits.Pressure p0=1.01325e5 "Nominal pressure";
  Modelica.SIunits.Pressure p;
  Modelica.Blocks.Interfaces.RealInput p_in annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  fluidPort_b.p = p;
  p = p_in;
   if cardinality(p_in) == 0 then
    p_in = p0 "Pressure set by parameter";
  end if;
annotation(
    Icon(graphics = {Rectangle(lineColor = {204, 204, 204}, fillColor = {255, 255, 255}, pattern = LinePattern.Dash, lineThickness = 2, extent = {{-100, 100}, {100, -100}}, radius = 30), Line(origin = {-10, 0}, points = {{-70, 0}, {70, 0}}, thickness = 4), Line(origin = {-80, 0}, points = {{0, 60}, {0, -60}}, thickness = 4)}));
end SinkP;
