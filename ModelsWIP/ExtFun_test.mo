within PL_Lib.ModelsWIP;

model ExtFun_test
  extends Modelica.Icons.Example;
  PL_Lib.Utilities.HX_extFun extFun_block annotation(
    Placement(visible = true, transformation(origin = {65, -13}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_BAin(k = 273.15 + 200)  annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant p_BAin(k = 101325 * 2) annotation(
    Placement(visible = true, transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mdot_BAin(k = 0.25) annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant d_BAin(k = 1.25) annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_RAin(k = 273.15 + 20) annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant p_RAin(k = 101325) annotation(
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mdot_RAin(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant d_RAin(k = 1.2) annotation(
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T_BAin.y, extFun_block.BAin_T) annotation(
    Line(points = {{-79, 70}, {31, 70}, {31, 17}, {36.5, 17}}, color = {0, 0, 127}));
  connect(p_BAin.y, extFun_block.BAin_p) annotation(
    Line(points = {{-49, 50}, {29, 50}, {29, 9.5}, {36.5, 9.5}}, color = {0, 0, 127}));
  connect(mdot_BAin.y, extFun_block.BAin_mdot) annotation(
    Line(points = {{-19, 30}, {27, 30}, {27, 2}, {36.5, 2}}, color = {0, 0, 127}));
  connect(d_BAin.y, extFun_block.BAin_d) annotation(
    Line(points = {{11, 10}, {25, 10}, {25, -5}, {36.5, -5}}, color = {0, 0, 127}));
  connect(T_RAin.y, extFun_block.RAin_T) annotation(
    Line(points = {{-79, -10}, {27, -10}, {27, -20.5}, {36.5, -20.5}}, color = {0, 0, 127}));
  connect(p_RAin.y, extFun_block.RAin_p) annotation(
    Line(points = {{-49, -30}, {28.75, -30}, {28.75, -28}, {36.5, -28}}, color = {0, 0, 127}));
  connect(mdot_RAin.y, extFun_block.RAin_mdot) annotation(
    Line(points = {{-19, -50}, {31, -50}, {31, -35.5}, {36.5, -35.5}}, color = {0, 0, 127}));
  connect(d_RAin.y, extFun_block.RAin_d) annotation(
    Line(points = {{11, -70}, {33, -70}, {33, -43}, {36.5, -43}}, color = {0, 0, 127}));  
  annotation(
    Diagram,
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
end ExtFun_test;
