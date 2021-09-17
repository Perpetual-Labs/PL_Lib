within PL_Lib.Components;

model HX_extFun
  Modelica.Blocks.Interfaces.RealVectorInput gas1_state_in annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput gas2_state_in annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput gas1_state_out annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput gas2_state_out annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  hxP.hxSignal hxSignal annotation(
    Placement(visible = true, transformation(origin = {1.77636e-15, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-80, 80}, {80, -80}}, textString = "Ext. Code")}));
end HX_extFun;
