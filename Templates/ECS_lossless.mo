within PL_Lib.Templates;
partial model ECS_lossless
  extends PL_Lib.Interfaces.ConfigurationBase;
  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  inner ThermoPower.System system annotation (Placement(visible=true, transformation(extent={{280,80},{300,100}}, rotation=0)));
  replaceable Interfaces.TurbineBase turbine(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{160,-80},{200,-40}})));
  replaceable Interfaces.CompressorBase compressor(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{-110,-20},{-70,20}})));
  replaceable Interfaces.HeatExchangerBase SHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{70,-20},{110,20}})));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = ColdFluid, use_in_T=true, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-210,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = HotFluid, use_in_T=true, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-210,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = ColdFluid, w0=0.5) annotation (Placement(visible=true, transformation(
        origin={-180,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = HotFluid, w0=0.25) annotation (Placement(visible=true, transformation(
        origin={-180,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RA_SHXin(redeclare package Medium = ColdFluid, w0=0.25) annotation (Placement(visible=true, transformation(
        origin={-140,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-10,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(extent={{160,30},{180,50}}, rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{240,-20},{260,0}}, rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-40,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={140,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={40,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={220,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-150,-46},{-130,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-140,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={140,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(visible=true, transformation(
        origin={90,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensP sensP_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  ThermoPower.Gas.SensP sensP_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  ThermoPower.Gas.SensT sensT_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{30,34},{50,54}})));
  ThermoPower.Gas.SensP sensP_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  ThermoPower.Gas.SensP sensP_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{100,40},{120,60}})));
protected
  parameter Modelica.SIunits.Inertia J_shaft=10;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (
    Line(points = {{-200, 50}, {-190, 50}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (
    Line(points = {{-200, -40}, {-190, -40}}, color = {159, 159, 223}));
  connect(throughMassFlow_BAin.outlet, sensT_BA_PHXin.inlet) annotation (
    Line(points = {{-170, -40}, {-146, -40}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (
    Line(points = {{-34, 40}, {-20, 40}}, color = {159, 159, 223}));
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (
    Line(points = {{-70, 10}, {-60, 10}, {-60, 40}, {-46, 40}}, color = {159, 159, 223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (
    Line(points = {{-70, -10}, {-60, -10}, {-60, -44}, {-46, -44}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (
    Line(points = {{-134, 40}, {-120, 40}, {-120, 10}, {-110, 10}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (
    Line(points = {{-134, -40}, {-120, -40}, {-120, -10}, {-110, -10}}, color = {159, 159, 223}));
  connect(compressor.inlet, sensT_BA_PHXout.outlet) annotation (
    Line(points = {{-16, -44}, {-34, -44}}, color = {159, 159, 223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (
    Line(points = {{16, -44}, {34, -44}}, color = {159, 159, 223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation (
    Line(points = {{110, 10}, {120, 10}, {120, 40}, {134, 40}}, color = {159, 159, 223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation (
    Line(points = {{110, -10}, {120, -10}, {120, -44}, {134, -44}}, color = {159, 159, 223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{12, -60}, {80, -60}}, color = {0, 0, 0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (
    Line(points = {{100, -60}, {168, -60}}, color = {0, 0, 0}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation (
    Line(points = {{46, -44}, {60, -44}, {60, -10}, {70, -10}}, color = {159, 159, 223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation (
    Line(points = {{146, -44}, {164, -44}}, color = {159, 159, 223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation (
    Line(points = {{146, 40}, {160, 40}}, color = {159, 159, 223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (
    Line(points = {{214, -44}, {196, -44}}, color = {159, 159, 223}));
  connect(sensT_BA_PACKout.outlet, sinkP_PACKout.flange) annotation (
    Line(points = {{226, -44}, {234, -44}, {234, -10}, {240, -10}}, color = {159, 159, 223}));
  connect(throughMassFlow_RAin.outlet, throughMassFlow_RA_SHXin.inlet) annotation (
    Line(points = {{-170, 50}, {-160, 50}, {-160, 70}, {-150, 70}}, color = {159, 159, 223}));
  connect(throughMassFlow_RAin.outlet, sensT_RA_PHXin.inlet) annotation (
    Line(points = {{-170, 50}, {-160, 50}, {-160, 40}, {-146, 40}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.T, signalBus.signalSubBus_BA_T.T_BA_PHXin) annotation (
    Line(points={{-133,-30},{-130,-30},{-130,-120},{300.1,-120},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_BA_PHXout.T, signalBus.signalSubBus_BA_T.T_BA_PHXout) annotation (
    Line(points={{-33,-34},{-30,-34},{-30,-118},{300.1,-118},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_BA_SHXin.T, signalBus.signalSubBus_BA_T.T_BA_SHXin) annotation (
    Line(points={{47,-34},{50,-34},{50,-116},{300.1,-116},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_BA_SHXout.T, signalBus.signalSubBus_BA_T.T_BA_SHXout) annotation (
    Line(points={{147,-34},{150,-34},{150,-114},{300.1,-114},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_BA_PACKout.T, signalBus.signalSubBus_BA_T.T_BA_PACKout) annotation (
    Line(points={{227,-34},{230,-34},{230,-112},{300.1,-112},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_RA_PHXin.T, signalBus.signalSubBus_RA_T.T_RA_PHXin) annotation (
    Line(points={{-133,50},{-126,50},{-126,120},{300.1,120},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_RA_PHXout.T, signalBus.signalSubBus_RA_T.T_RA_PHXout) annotation (
    Line(points={{-33,50},{-28,50},{-28,118},{300.1,118},{300.1,0.1}},      color = {0, 0, 127}));
  connect(sensT_RA_SHXout.T, signalBus.signalSubBus_RA_T.T_RA_SHXout) annotation (
    Line(points={{147,50},{152,50},{152, 114},{300.1, 114},{300.1,0.1}},      color = {0, 0, 127}));
  connect(T_cold_in, sourceP_RAin.in_T) annotation (Line(points={{-300,90},{-210,90},{-210,59}}, color={0,0,127}));
  connect(p_cold_in, sourceP_RAin.in_p0) annotation (Line(points={{-300,50},{-260,50},{-260,80},{-216,80},{-216,56.4}}, color={0,0,127}));
  connect(T_hot_in, sourceP_BAin.in_T) annotation (Line(points={{-300,-10},{-210,-10},{-210,-31}}, color={0,0,127}));
  connect(p_hot_in, sourceP_BAin.in_p0) annotation (Line(points={{-300,-50},{-260,-50},{-260,-20},{-216,-20},{-216,-33.6}}, color={0,0,127}));
  connect(p_cold_in, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-300,50},{-260,50},{-260,80},{-16.45,80},{-16.45,45.95}}, color={0,0,127}));
  connect(p_cold_in, sinkP_RA_SHXout.in_p0) annotation (Line(points={{-300,50},{-260,50},{-260,80},{163.55,80},{163.55,45.95}}, color={0,0,127}));
  connect(sensT_RA_PHXin.outlet, sensP_RA_PHXin.flange) annotation (Line(points={{-134,40},{-120,40},{-120,32},{-110,32},{-110,46}}, color={159,159,223}));
  connect(PHX.outfl_1, sensP_RA_PHXout.flange) annotation (Line(points={{-70,10},{-60,10},{-60,32},{-70,32},{-70,46}}, color={159,159,223}));
  connect(throughMassFlow_RA_SHXin.outlet, sensT_RA_SHXin.inlet) annotation (Line(points={{-130,70},{20,70},{20,40},{34,40}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, SHX.infl_1) annotation (Line(points={{46,40},{60,40},{60,10},{70,10}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, sensP_RA_SHXin.flange) annotation (Line(points={{46,40},{60,40},{60,32},{70,32},{70,46}}, color={159,159,223}));
  connect(SHX.outfl_1, sensP_RA_SHXout.flange) annotation (Line(points={{110,10},{120,10},{120,32},{110,32},{110,46}}, color={159,159,223}));
  connect(sensP_RA_PHXin.p, signalBus.signalSubBus_RA_p.p_RA_PHXin) annotation (
    Line(points={{-103,56},{-94,56},{-94,100},{274,100},{274,0.1},{300.1,0.1}},        color = {0, 0, 127}));
  connect(sensP_RA_PHXout.p, signalBus.signalSubBus_RA_p.p_RA_PHXout) annotation (
    Line(points={{-63,56},{-56,56},{-56,98},{272,98},{272,0.1},{300.1,0.1}},        color = {0, 0, 127}));
  connect(sensP_RA_SHXin.p, signalBus.signalSubBus_RA_p.p_RA_SHXin) annotation (
    Line(points={{77,56},{86,56},{86,96},{270,96},{270,0.1},{300.1,0.1}},        color = {0, 0, 127}));
  connect(sensP_RA_SHXout.p, signalBus.signalSubBus_RA_p.p_RA_SHXout) annotation (
    Line(points={{117,56},{124,56},{124,94},{268,94},{268,0.1},{300.1,0.1}},        color = {0, 0, 127}));
  connect(sensT_RA_SHXin.T, signalBus.signalSubBus_RA_T.T_RA_SHXin) annotation (
    Line(points={{47,50},{52,50},{52,116},{300.1,116},{300.1,0.1}},      color = {0, 0, 127}));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}}), graphics={Text(
          origin={-190,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-190,30},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left)}), experiment(
      StopTime=3000,
      Tolerance=1e-06,
      StartTime=0,
      Interval=6));
end ECS_lossless;
