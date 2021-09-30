within PL_Lib.ModelsWIP;

model ExtFun_test
  extends Modelica.Icons.Example;
  PL_Lib.Utilities.HX_extFun extFun_block annotation(
    Placement(visible = true, transformation(origin = {65, 17}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-2, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-34, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-62, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const4(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-62, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const6(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-34, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const7(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-2, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const1.y, extFun_block.BAin_T) annotation(
    Line(points = {{9, 70}, {28, 70}, {28, 48}, {38, 48}}, color = {0, 0, 127}));
  connect(const.y, extFun_block.BAin_p) annotation(
    Line(points = {{-23, 50}, {25.5, 50}, {25.5, 40}, {38, 40}}, color = {0, 0, 127}));
  connect(const2.y, extFun_block.BAin_mdot) annotation(
    Line(points = {{-51, 30}, {0, 30}, {0, 32}, {38, 32}}, color = {0, 0, 127}));
  connect(const3.y, extFun_block.BAin_d) annotation(
    Line(points = {{-79, 10}, {8, 10}, {8, 26}, {38, 26}}, color = {0, 0, 127}));
  connect(const7.y, extFun_block.RAin_T) annotation(
    Line(points = {{9, -10}, {21, -10}, {21, 10}, {37, 10}}, color = {0, 0, 127}));
  connect(const6.y, extFun_block.RAin_p) annotation(
    Line(points = {{-23, -30}, {25, -30}, {25, 2}, {37, 2}}, color = {0, 0, 127}));
  connect(const4.y, extFun_block.RAin_mdot) annotation(
    Line(points = {{-51, -50}, {29, -50}, {29, -6}, {37, -6}}, color = {0, 0, 127}));
  connect(const5.y, extFun_block.RAin_d) annotation(
    Line(points = {{-79, -70}, {33, -70}, {33, -12}, {37, -12}}, color = {0, 0, 127}));
end ExtFun_test;
