within PL_Lib.Utilities;

model MassFlowToPressureAdaptor
  Modelica.Blocks.Interfaces.RealOutput pder annotation(
    Placement(visible = true, transformation(extent = {{20, 40}, {40, 60}}, rotation = 0), iconTransformation(extent = {{20, 40}, {40, 60}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput fder2 annotation(
    Placement(visible = true, transformation(extent = {{40, -30}, {20, -10}}, rotation = 0), iconTransformation(extent = {{40, -30}, {20, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput fder annotation(
    Placement(visible = true, transformation(extent = {{40, -60}, {20, -40}}, rotation = 0), iconTransformation(extent = {{40, -60}, {20, -40}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput f annotation(
    Placement(visible = true, transformation(extent = {{40, -90}, {20, -70}}, rotation = 0), iconTransformation(extent = {{40, -90}, {20, -70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput pder2 annotation(
    Placement(visible = true, transformation(extent = {{20, 10}, {40, 30}}, rotation = 0), iconTransformation(extent = {{20, 10}, {40, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p annotation(
    Placement(visible = true, transformation(extent = {{20, 70}, {40, 90}}, rotation = 0), iconTransformation(extent = {{20, 70}, {40, 90}}, rotation = 0)));
  
  ThermoPower.Gas.FlangeA flangeA annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    Icon(graphics = {Rectangle(lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-20, 100}, {20, -100}}, radius = 10), Text(extent = {{-18, 30}, {18, 10}}, textString = "%Name_pder2"), Text(extent = {{-18, -40}, {18, -60}}, textString = "%Name_fder"), Text(extent = {{-18, -10}, {18, -30}}, textString = "%Name_fder2"), Text(extent = {{-18, 60}, {18, 40}}, textString = "%Name_pder"), Text(extent = {{-18, 90}, {18, 70}}, textString = "%Name_p"), Text(extent = {{-18, -70}, {18, -90}}, textString = "%Name_f")}));
end MassFlowToPressureAdaptor;
