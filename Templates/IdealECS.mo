within PL_Lib.Templates;
model IdealECS
  replaceable Components.BasicCoFlowHX heatExchanger constrainedby Interfaces.HeatExchangerBase annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end IdealECS;
