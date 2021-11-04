within PL_Lib.Utilities;
model HX_extFun
  Modelica.Blocks.Interfaces.RealInput T_hot_in(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-30},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_hot_in(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput w_hot_in(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput d_hot_in(displayUnit = "g/cm3", min = 0, final quantity = "Density", final unit = "kg/m3") annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-90},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-120},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  Modelica.Blocks.Interfaces.RealInput T_cold_in(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,90},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,120},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_cold_in(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput w_cold_in(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", min = 0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput d_cold_in(displayUnit = "g/cm3", min = 0, final quantity = "Density", final unit = "kg/m3") annotation (Placement(
      visible=true,
      transformation(
        origin={-100,30},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  Modelica.Blocks.Interfaces.RealOutput T_hot_out(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0, start = 300) annotation (Placement(
      visible=true,
      transformation(
        origin={110,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput T_cold_out(final quantity = "Temperature", final unit = "K", displayUnit = "degC", min = 0, start = 300) annotation (Placement(
      visible=true,
      transformation(
        origin={110,80},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput p_hot_out(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0, start = 101325) annotation (Placement(
      visible=true,
      transformation(
        origin={110,-80},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput p_cold_out(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar", min = 0, start = 101325) annotation (Placement(
      visible=true,
      transformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Real temperatures[2];
  Real pressures[2];
  Real t;
equation
  t = time;
  (temperatures, pressures) = hx(T_cold_in, T_hot_in, w_cold_in, w_hot_in, p_cold_in, p_hot_in, d_cold_in, d_hot_in, t);

  T_cold_out  = temperatures[1];
  T_hot_out   = temperatures[2];
  p_cold_out  = pressures[1];
  p_hot_out   = pressures[2];

  annotation (
    Icon(graphics={  Rectangle(lineColor = {170, 85, 127}, fillColor = {255, 224, 234},
            fillPattern =                                                                             FillPattern.Solid,
            lineThickness =                                                                                                              0.5, extent = {{-100, 140}, {100, -140}}), Text(extent = {{-80, 40}, {80, -40}}, textString = "Ext. Code"), Text(origin = {-70, -30}, extent = {{-30, 10}, {30, -10}}, textString = "T_hot_in"), Text(origin = {-70, -60}, extent = {{-30, 10}, {30, -10}}, textString = "p_hot_in"), Text(origin = {-70, -90}, extent = {{-30, 10}, {30, -10}}, textString = "w_hot_in"), Text(origin = {-70, -120}, extent = {{-30, 10}, {30, -10}}, textString = "d_hot_in"), Text(origin = {-70, 30}, extent = {{-30, 10}, {30, -10}}, textString = "d_cold_in"), Text(origin = {-70, 60}, extent = {{-30, 10}, {30, -10}}, textString = "w_cold_in"), Text(origin = {-70, 90}, extent = {{-30, 10}, {30, -10}}, textString = "p_cold_in"), Text(origin = {-70, 120}, extent = {{-30, 10}, {30, -10}}, textString = "T_cold_in"), Text(origin = {70, -50}, extent = {{-30, 10}, {30, -10}}, textString = "T_hot_out"), Text(origin = {70, 90}, extent = {{-30, 10}, {30, -10}}, textString = "T_cold_out"), Text(origin = {70, 50}, extent = {{-30, 10}, {30, -10}}, textString = "p_cold_out"), Text(origin = {70, -90}, extent = {{-30, 10}, {30, -10}}, textString = "p_hot_out")}, coordinateSystem(extent = {{-100, -140}, {100, 140}})),
    Diagram);
end HX_extFun;
