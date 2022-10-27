within PL_Lib.Components;
model HeatExchanger_supplied
  extends ecs_case_study_mo.HeatExchanger;
  extends PL_Lib.Icons.HeatExchanger_icon;
  PL_Lib.Components.HX_1DCoFlow heatExchanger(
    wnom_c=0.1,
    wnom_h=0.1,
    redeclare package ColdFluid = heatExchangerMediumCold,
    redeclare package HotFluid = heatExchangerMediumHot) annotation (choicesAllMatching=true, Placement(transformation(extent={{-40,-40},{40,40}})));
equation
  connect(HeatExchangerInletCold, heatExchanger.infl_1) annotation (Line(points={{-100,50},{-60,50},{-60,20},{-40,20}}, color={0,0,0}));
  connect(HeatExchangerInletHot, heatExchanger.infl_2) annotation (Line(points={{-100,-50},{-60,-50},{-60,-20},{-40,-20}}, color={0,0,0}));
  connect(HeatExchangerOutletHot, heatExchanger.outfl_2) annotation (Line(points={{100,-50},{60,-50},{60,-20},{40,-20}}, color={0,0,0}));
  connect(HeatExchangerOutletCold, heatExchanger.outfl_1) annotation (Line(points={{100,50},{80,50},{80,20},{40,20}}, color={0,0,0}));
end HeatExchanger_supplied;
