within PL_Lib.Interfaces;
partial model ConfigurationBase
  Modelica.Blocks.Interfaces.RealInput p_hot_in annotation (Placement(transformation(extent={{-320,-70},{-280,-30}}), iconTransformation(extent={{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.RealInput T_hot_in annotation (Placement(transformation(extent={{-320,-40},{-280,0}}),  iconTransformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealInput p_cold_in annotation (Placement(transformation(extent={{-320,40},{-280,80}}), iconTransformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealInput T_cold_in annotation (Placement(transformation(extent={{-320,70},{-280,110}}), iconTransformation(extent={{-120,60},{-80,100}})));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ConfigurationBase;
