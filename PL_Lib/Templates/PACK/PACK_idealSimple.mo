within PL_Lib.Templates.PACK;
partial model PACK_idealSimple
  extends PL_Lib.Interfaces.ConfigurationBase;

  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";

  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable Interfaces.CompressorBase compressor(
    redeclare package Medium = HotFluid,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{-40,-80},{0,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (choicesAllMatching=true, Placement(transformation(extent={{-150,-20},{-110,20}})));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = HotFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(transformation(
        origin={-210,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(transformation(
        origin={-50,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-80,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-190,-46},{-170,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(
        origin={-180,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-90,34},{-70,54}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(visible = true, transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_PHXin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold,
    use_in_w0=false,
    use_in_T=true)
                annotation (Placement(visible=true, transformation(
        origin={-210,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
protected
  ThermoPower.Gas.SensP sensP_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{-190,10},{-170,30}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{-90,10},{-70,30}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{-190,-20},{-170,0}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{-90,-20},{-70,0}}, rotation=0)));
protected
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (
    Line(points = {{-110, 10}, {-100, 10}, {-100, 40}, {-86, 40}}, color = {159, 159, 223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (
    Line(points = {{-110, -10}, {-100, -10}, {-100, -40}, {-86, -40}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (
    Line(points = {{-174, 40}, {-160, 40}, {-160, 10}, {-150, 10}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (
    Line(points = {{-174, -40}, {-160, -40}, {-160, -10}, {-150, -10}}, color = {159, 159, 223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{-8, -60}, {60, -60}}));
  connect(T_hot_in, sourceP_BAin.in_T) annotation (
    Line(points = {{-300, -20}, {-210, -20}, {-210, -31}}, color = {0, 0, 127}));
  connect(p_hot_in, sourceP_BAin.in_p0) annotation (
    Line(points = {{-300, -50}, {-226, -50}, {-226, -24}, {-216, -24}, {-216, -33.6}}, color = {0, 0, 127}));
  connect(p_cold_in, sinkP_RA_PHXout.in_p0) annotation (
    Line(points={{-300,60},{-260,60},{-260,80},{-56.45,80},{-56.45,45.95}},            color = {0, 0, 127}));
  connect(PHX.outfl_2, sensP_BA_PHXout.flange) annotation (
    Line(points = {{-110, -10}, {-100, -10}, {-100, -14}, {-80, -14}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, sensP_BA_PHXin.flange) annotation (
    Line(points = {{-174, -40}, {-160, -40}, {-160, -14}, {-180, -14}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, sensP_RA_PHXin.flange) annotation (
    Line(points = {{-174, 40}, {-160, 40}, {-160, 16}, {-180, 16}}, color = {159, 159, 223}));
  connect(PHX.outfl_1, sensP_RA_PHXout.flange) annotation (
    Line(points = {{-110, 10}, {-100, 10}, {-100, 16}, {-80, 16}}, color = {159, 159, 223}));
  connect(sourceMassFlow_RA_PHXin.flange, sensT_RA_PHXin.inlet) annotation (
    Line(points = {{-200, 40}, {-186, 40}}, color = {159, 159, 223}));
  connect(T_cold_in, sourceMassFlow_RA_PHXin.in_T) annotation (
    Line(points = {{-300, 90}, {-210, 90}, {-210, 45}}, color = {0, 0, 127}));
  connect(sourceP_BAin.flange, sensT_BA_PHXin.inlet) annotation (
    Line(points = {{-200, -40}, {-186, -40}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXout.outlet, compressor.inlet) annotation (
    Line(points = {{-74, -40}, {-50, -40}, {-50, -44}, {-36, -44}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (
    Line(points={{-74,40},{-60,40}},      color = {159, 159, 223}));
  connect(compressor.outlet, sinkP_PACKout.flange) annotation (Line(points={{-4,-44},{-4,-20},{60,-20}}, color={159,159,223}));
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}}), graphics={Text(
          origin={-210,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-230,30},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left)}));
end PACK_idealSimple;
