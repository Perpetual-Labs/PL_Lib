within PL_Lib.Experiments;
model CruiseTest
  extends Modelica.Icons.Example;
//  extends PL_Lib.Configurations.PACK_simpleConfig;
  Modelica.Blocks.Sources.Constant T_cold_in(k=Thex_in_RA_10km) annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Sources.Constant p_cold_in(k=phex_RA_10km) annotation (Placement(transformation(extent={{-86,16},{-66,36}})));
  Modelica.Blocks.Sources.Constant T_hot_in(k=Thex_in_BA_10km) annotation (Placement(transformation(extent={{-86,-34},{-66,-14}})));
  Modelica.Blocks.Sources.Constant p_hot_in(k=phex_BA_10km) annotation (Placement(transformation(extent={{-86,-64},{-66,-44}})));
  Configurations.PACK_simpleConfig pACK_simple annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CruiseTest;
