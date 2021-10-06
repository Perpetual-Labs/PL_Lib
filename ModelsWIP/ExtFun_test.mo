within PL_Lib.ModelsWIP;
model ExtFun_test
  extends Modelica.Icons.Example;
  PL_Lib.Utilities.HX_extFun extFun_block annotation (
    Placement(visible = true, transformation(origin={70,-8},     extent={{-20,-28},
            {20,28}},                                                                             rotation = 0)));
  Modelica.Blocks.Sources.Constant T_BAin(k = 273.15 + 200)  annotation (
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant p_BAin(k = 101325 * 2) annotation (
    Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mdot_BAin(k = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant d_BAin(k = 1.25) annotation (
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_RAin(k = 273.15 + 20) annotation (
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant p_RAin(k = 101325) annotation (
    Placement(visible = true, transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mdot_RAin(k = 0.3) annotation (
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant d_RAin(k = 1.2) annotation (
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T_RAin.y, extFun_block.RAin_T) annotation(
    Line(points = {{-78, 90}, {40, 90}, {40, 16}, {48, 16}}, color = {0, 0, 127}));
  connect(p_RAin.y, extFun_block.RAin_p) annotation(
    Line(points = {{-48, 70}, {38, 70}, {38, 10}, {48, 10}}, color = {0, 0, 127}));
  connect(mdot_RAin.y, extFun_block.RAin_mdot) annotation(
    Line(points = {{-18, 50}, {36, 50}, {36, 4}, {48, 4}}, color = {0, 0, 127}));
  connect(d_RAin.y, extFun_block.RAin_d) annotation(
    Line(points = {{12, 30}, {34, 30}, {34, -2}, {48, -2}}, color = {0, 0, 127}));
  connect(T_BAin.y, extFun_block.BAin_T) annotation(
    Line(points = {{-78, 10}, {20, 10}, {20, -14}, {48, -14}}, color = {0, 0, 127}));
  connect(p_BAin.y, extFun_block.BAin_p) annotation(
    Line(points = {{-48, -10}, {18, -10}, {18, -20}, {48, -20}}, color = {0, 0, 127}));
  connect(mdot_BAin.y, extFun_block.BAin_mdot) annotation(
    Line(points = {{-18, -30}, {16, -30}, {16, -26}, {48, -26}}, color = {0, 0, 127}));
  connect(d_BAin.y, extFun_block.BAin_d) annotation(
    Line(points = {{12, -50}, {40, -50}, {40, -32}, {48, -32}}, color = {0, 0, 127}));
  annotation (
    Diagram,
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
end ExtFun_test;
