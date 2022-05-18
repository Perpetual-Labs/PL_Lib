within PL_Lib.Components;
model HX_extFun_dummy
  extends PL_Lib.Interfaces.HeatExchangerBase;
  extends PL_Lib.Icons.C_icon;
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor1(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-50,40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-50,-40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare package Medium = ColdFluid, T0=293.15) annotation (Placement(visible=true, transformation(
        origin={50,40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Interfaces.PressureToMassFlowAdapter pressureToMassFlowAdaptor2(redeclare package Medium = HotFluid, T0=573.15, p0=200000) annotation (Placement(visible=true, transformation(
        origin={50,-40},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Utilities.HX_extFun_dummy PHX_extFun(
    T_cold_out(displayUnit="K"),
    T_hot_out(displayUnit="K"),
    p_cold_out(displayUnit="Pa"),
    p_hot_out(displayUnit="Pa")) annotation (Placement(visible=true, transformation(
        origin={0,-2},
        extent={{-20,-28},{20,28}},
        rotation=0)));
equation
  connect(massFlowToPressureAdaptor1.T,PHX_extFun. T_cold_in) annotation (
    Line(points={{-44,54},{-26,54},{-26,22},{-22,22}},              color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.p,PHX_extFun. p_cold_in) annotation (
    Line(points={{-44,48},{-28,48},{-28,16},{-22,16}},              color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.p,PHX_extFun. p_hot_in) annotation (
    Line(points={{-44,-32},{-30,-32},{-30,-14},{-22,-14}},              color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.T,PHX_extFun. T_hot_in) annotation (
    Line(points={{-44,-26},{-32,-26},{-32,-8},{-22,-8}},              color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot,massFlowToPressureAdaptor1. m_dot) annotation (
    Line(points={{44,26},{30,26},{30,30},{-30,30},{-30,26},{-44,26}},                      color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor1.m_dot,PHX_extFun. w_cold_in) annotation (
    Line(points={{44,26},{30,26},{30,30},{-30,30},{-30,10},{-22,10}},                      color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot,massFlowToPressureAdaptor2. m_dot) annotation (
    Line(points={{44,-54},{-44,-54}},        color = {0, 0, 127}));
  connect(pressureToMassFlowAdaptor2.m_dot,PHX_extFun. w_hot_in) annotation (
    Line(points={{44,-54},{-28,-54},{-28,-20},{-22,-20}},              color = {0, 0, 127}));
  connect(PHX_extFun.T_hot_out,pressureToMassFlowAdaptor2. T) annotation (
    Line(points={{22,-12},{40,-12},{40,-26},{44,-26}},               color = {0, 0, 127}));
  connect(PHX_extFun.p_hot_out,pressureToMassFlowAdaptor2. p) annotation (
    Line(points={{22,-20},{38,-20},{38,-32},{44,-32}},               color = {0, 0, 127}));
  connect(PHX_extFun.p_cold_out,pressureToMassFlowAdaptor1. p) annotation (
    Line(points={{22,8},{40,8},{40,48},{44,48}},               color = {0, 0, 127}));
  connect(PHX_extFun.T_cold_out,pressureToMassFlowAdaptor1. T) annotation (
    Line(points={{22,16},{38,16},{38,54},{44,54}},               color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor1.d,PHX_extFun. d_cold_in) annotation (
    Line(points={{-44,42},{-32,42},{-32,4},{-22,4}},              color = {0, 0, 127}));
  connect(massFlowToPressureAdaptor2.d,PHX_extFun. d_hot_in) annotation (
    Line(points={{-44,-38},{-26,-38},{-26,-26},{-22,-26}},              color = {0, 0, 127}));
  connect(infl_1, massFlowToPressureAdaptor1.flange) annotation (Line(points={{-100,50},{-80,50},{-80,40},{-54,40}}, color={159,159,223}));
  connect(pressureToMassFlowAdaptor1.flange, outfl_1) annotation (Line(points={{54,40},{80,40},{80,50},{100,50}}, color={159,159,223}));
  connect(infl_2, massFlowToPressureAdaptor2.flange) annotation (Line(points={{-100,-50},{-80,-50},{-80,-40},{-54,-40}}, color={159,159,223}));
  connect(pressureToMassFlowAdaptor2.flange, outfl_2) annotation (Line(points={{54,-40},{80,-40},{80,-50},{100,-50}}, color={159,159,223}));
  annotation (Icon(graphics={Text(
          extent={{-80,-100},{80,-140}},
          textColor={28,108,200},
          textString="%name"),
                             Text(
          extent={{-80,-140},{80,-180}},
          textColor={238,46,47},
          textString="dummy C-fun.")}));
end HX_extFun_dummy;
