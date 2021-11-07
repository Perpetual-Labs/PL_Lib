within PL_Lib.Interfaces;
partial model HeatExchangerBase
  outer ThermoPower.System system "System wide properties";
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  ThermoPower.Gas.FlangeA infl_1(redeclare package Medium = ColdFluid) "Cold fluid inlet" annotation (Placement(transformation(rotation=0, extent={{-110,40},{-90,60}}), iconTransformation(extent={{-110,40},{-90,60}})));
  ThermoPower.Gas.FlangeA infl_2(redeclare package Medium = HotFluid) "Hot fluid inlet" annotation (Placement(transformation(rotation=0, extent={{-110,-60},{-90,-40}}), iconTransformation(extent={{-110,-60},{-90,-40}})));
  ThermoPower.Gas.FlangeB outfl_1(redeclare package Medium = ColdFluid) "Cold fluid outlet" annotation (Placement(transformation(rotation=0, extent={{90,40},{110,60}}), iconTransformation(extent={{90,40},{110,60}})));
  ThermoPower.Gas.FlangeB outfl_2(redeclare package Medium = HotFluid) "Hot fluid outlet" annotation (Placement(transformation(rotation=0, extent={{90,-60},{110,-40}}), iconTransformation(extent={{90,-60},{110,-40}})));
end HeatExchangerBase;
