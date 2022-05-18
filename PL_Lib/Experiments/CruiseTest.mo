within PL_Lib.Experiments;
model CruiseTest
  extends PL_Lib.Configurations.PACK_simple;
  Modelica.Blocks.Sources.Constant T_cold_in(k=Thex_in_RA_10km) annotation (Placement(transformation(extent={{-260,70},{-240,90}})));
  Modelica.Blocks.Sources.Constant p_cold_in(k=phex_RA_10km) annotation (Placement(transformation(extent={{-260,40},{-240,60}})));
  Modelica.Blocks.Sources.Constant T_hot_in(k=Thex_in_BA_10km) annotation (Placement(transformation(extent={{-260,-10},{-240,10}})));
  Modelica.Blocks.Sources.Constant p_hot_in(k=phex_BA_10km) annotation (Placement(transformation(extent={{-260,-40},{-240,-20}})));
equation
  connect(p_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-239,-30},{-226,-30},{-226,-24},{-216,-24},{-216,-33.6}}, color={0,0,127}));
  connect(T_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-239,0},{-210,0},{-210,-31}}, color={0,0,127}));
  connect(T_cold_in.y, sourceMassFlow_RA_PHXin.in_T) annotation (Line(points={{-239,80},{-210,80},{-210,45}}, color={0,0,127}));
  connect(p_cold_in.y, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-239,50},{-56.45,50},{-56.45,45.95}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CruiseTest;
