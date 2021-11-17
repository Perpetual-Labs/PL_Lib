within PL_Lib.Interfaces;
partial model ConfigurationBase
  PL_Lib.Interfaces.SignalBus signalBus annotation (Placement(transformation(extent={{280,-20},{320,20}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,0})));
  Modelica.Blocks.Interfaces.RealInput p_hot_in annotation (Placement(transformation(extent={{-320,-70},{-280,-30}}), iconTransformation(extent={{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.RealInput T_hot_in annotation (Placement(transformation(extent={{-320,-30},{-280,10}}), iconTransformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealInput p_cold_in annotation (Placement(transformation(extent={{-320,30},{-280,70}}), iconTransformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealInput T_cold_in annotation (Placement(transformation(extent={{-320,70},{-280,110}}), iconTransformation(extent={{-120,60},{-80,100}})));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})));
end ConfigurationBase;
