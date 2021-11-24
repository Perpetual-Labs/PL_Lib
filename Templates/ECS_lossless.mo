within PL_Lib.Templates;
partial model ECS_lossless
  extends PL_Lib.Interfaces.ConfigurationBase;
  extends Modelica.Icons.UnderConstruction;

  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";

  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable Interfaces.TurbineBase turbine(
    redeclare package Medium = HotFluid,
    Tdes_in=573.15,
    pstart_in=100000,
    pstart_out=100000,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{160,-80},{200,-40}})));
  replaceable Interfaces.CompressorBase compressor(
    redeclare package Medium = HotFluid,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{-20,-80},{20,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (choicesAllMatching=true, Placement(transformation(extent={{-110,-20},{-70,20}})));
  replaceable Interfaces.HeatExchangerBase SHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-20},{110,20}})));
  ThermoPower.Gas.SourcePressure sourceP_RAin(
    redeclare package Medium = ColdFluid,
    use_in_T=true,
    use_in_p0=true)   annotation (Placement(visible = true, transformation(origin={-210,50},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = HotFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(transformation(
        origin={-210,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold*2,
    use_in_w0=false) annotation (Placement(visible = true, transformation(origin={-180,50},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(
    redeclare package Medium = HotFluid,
    w0=whex_hot,
    use_in_w0=false) annotation (Placement(visible = true, transformation(origin={-180,-40},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RA_SHXin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold,
    use_in_w0=false) annotation (Placement(visible = true, transformation(origin={-140,70},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(transformation(
        origin={-10,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(transformation(extent={{160,30},{180,50}})));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{240,-20},{260,0}})));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(transformation(
        origin={-40,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(transformation(
        origin={140,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(
        origin={40,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(
        origin={220,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-150,-46},{-130,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(
        origin={-140,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(origin={140,44}, extent={{-10,-10},{10,10}})));
  ThermoPower.Gas.SensT sensT_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{30,34},{50,54}})));
  ThermoPower.Gas.SensP sensP_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  ThermoPower.Gas.SensP sensP_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  ThermoPower.Gas.SensP sensP_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  ThermoPower.Gas.SensP sensP_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{100,40},{120,60}})));
  ThermoPower.Gas.SensP sensP_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-170,-20},{-150,0}})));
  ThermoPower.Gas.SensP sensP_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermoPower.Gas.SensP sensP_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{30,-12},{50,8}})));
  ThermoPower.Gas.SensP sensP_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{140,-8},{160,12}})));
  ThermoPower.Gas.SensP sensP_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible = true, transformation(extent = {{198, -12}, {218, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(transformation(origin={90,-60}, extent={{-10,-10},{10,10}})));
protected
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-34,40},{-20,40}}, color={159,159,223}));
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (Line(points={{-70,10},{-60,10},{-60,40},{-46,40}}, color={159,159,223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (Line(points={{-70,-10},{-60,-10},{-60,-44},{-46,-44}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (Line(points={{-134,40},{-120,40},{-120,10},{-110,10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (Line(points={{-134,-40},{-120,-40},{-120,-10},{-110,-10}}, color={159,159,223}));
  connect(compressor.inlet, sensT_BA_PHXout.outlet) annotation (Line(points={{-16,-44},{-34,-44}}, color={159,159,223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (Line(points={{16,-44},{34,-44}}, color={159,159,223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation (Line(points={{110,10},{120,10},{120,40},{134,40}}, color={159,159,223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation (Line(points={{110,-10},{120,-10},{120,-44},{134,-44}}, color={159,159,223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{12,-60},{80,-60}}, color={0,0,0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (Line(points={{100,-60},{168,-60}}, color={0,0,0}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation (Line(points={{46,-44},{60,-44},{60,-10},{70,-10}}, color={159,159,223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation (Line(points={{146,-44},{164,-44}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{146,40},{160,40}}, color={159,159,223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (Line(points={{214,-44},{196,-44}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, sinkP_PACKout.flange) annotation (Line(points={{226,-44},{234,-44},{234,-10},{240,-10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.T, signalBus.signalSubBus_BA_T.T_BA_PHXin) annotation (Line(points={{-133,-30},{-130,-30},{-130,-120},{300,-120},{300,0}},       color={0,0,127}));
  connect(sensT_BA_PHXout.T, signalBus.signalSubBus_BA_T.T_BA_PHXout) annotation (Line(points={{-33,-34},{-30,-34},{-30,-118},{300,-118},{300,0}},       color={0,0,127}));
  connect(sensT_BA_SHXin.T, signalBus.signalSubBus_BA_T.T_BA_SHXin) annotation (Line(points={{47,-34},{50,-34},{50,-116},{300,-116},{300,0}},       color={0,0,127}));
  connect(sensT_BA_SHXout.T, signalBus.signalSubBus_BA_T.T_BA_SHXout) annotation (Line(points={{147,-34},{150,-34},{150,-114},{300,-114},{300,0}},       color={0,0,127}));
  connect(sensT_BA_PACKout.T, signalBus.signalSubBus_BA_T.T_BA_PACKout) annotation (Line(points={{227,-34},{230,-34},{230,-112},{300,-112},{300,0}},       color={0,0,127}));
  connect(sensT_RA_PHXin.T, signalBus.signalSubBus_RA_T.T_RA_PHXin) annotation (Line(points={{-133,50},{-126,50},{-126,120},{300,120},{300,0}},       color={0,0,127}));
  connect(sensT_RA_PHXout.T, signalBus.signalSubBus_RA_T.T_RA_PHXout) annotation (Line(points={{-33,50},{-28,50},{-28,118},{300,118},{300,0}},       color={0,0,127}));
  connect(sensT_RA_SHXout.T, signalBus.signalSubBus_RA_T.T_RA_SHXout) annotation (Line(points={{147,50},{152,50},{152,114},{300,114},{300,0}},       color={0,0,127}));
  connect(T_hot_in, sourceP_BAin.in_T) annotation (Line(points={{-300,-20},{-210,-20},{-210,-31}}, color={0,0,127}));
  connect(p_hot_in, sourceP_BAin.in_p0) annotation (Line(points={{-300,-50},{-260,-50},{-260,-28},{-216,-28},{-216,-33.6}}, color={0,0,127}));
  connect(p_cold_in, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-300,60},{-260,60},{-260,80},{-16.45,80},{-16.45,45.95}}, color={0,0,127}));
  connect(p_cold_in, sinkP_RA_SHXout.in_p0) annotation (Line(points={{-300,60},{-260,60},{-260,80},{163.55,80},{163.55,45.95}}, color={0,0,127}));
  connect(sensT_RA_PHXin.outlet, sensP_RA_PHXin.flange) annotation (Line(points={{-134,40},{-120,40},{-120,32},{-110,32},{-110,46}}, color={159,159,223}));
  connect(PHX.outfl_1, sensP_RA_PHXout.flange) annotation (Line(points={{-70,10},{-60,10},{-60,32},{-70,32},{-70,46}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, SHX.infl_1) annotation (Line(points={{46,40},{60,40},{60,10},{70,10}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, sensP_RA_SHXin.flange) annotation (Line(points={{46,40},{60,40},{60,32},{70,32},{70,46}}, color={159,159,223}));
  connect(SHX.outfl_1, sensP_RA_SHXout.flange) annotation (Line(points={{110,10},{120,10},{120,32},{110,32},{110,46}}, color={159,159,223}));
  connect(sensP_RA_PHXin.p, signalBus.signalSubBus_RA_p.p_RA_PHXin) annotation (Line(points={{-103,56},{-94,56},{-94,100},{274,100},{274,0},{300,0}},       color={0,0,127}));
  connect(sensP_RA_PHXout.p, signalBus.signalSubBus_RA_p.p_RA_PHXout) annotation (Line(points={{-63,56},{-56,56},{-56,98},{272,98},{272,0},{300,0}},       color={0,0,127}));
  connect(sensP_RA_SHXin.p, signalBus.signalSubBus_RA_p.p_RA_SHXin) annotation (Line(points={{77,56},{86,56},{86,96},{270,96},{270,0},{300,0}},       color={0,0,127}));
  connect(sensP_RA_SHXout.p, signalBus.signalSubBus_RA_p.p_RA_SHXout) annotation (Line(points={{117,56},{124,56},{124,94},{268,94},{268,0},{300,0}},       color={0,0,127}));
  connect(sensT_RA_SHXin.T, signalBus.signalSubBus_RA_T.T_RA_SHXin) annotation (Line(points={{47,50},{52,50},{52,116},{300,116},{300,0}},       color={0,0,127}));
  connect(PHX.outfl_2, sensP_BA_PHXout.flange) annotation (Line(points={{-70,-10},{-60,-10},{-60,-18},{-30,-18},{-30,-4}}, color={159,159,223}));
  connect(compressor.outlet, sensP_BA_SHXin.flange) annotation (Line(points={{16,-44},{28,-44},{28,-18},{40,-18},{40,-6}}, color={159,159,223}));
  connect(SHX.outfl_2, sensP_BA_SHXout.flange) annotation (Line(points={{110,-10},{120,-10},{120,-14},{150,-14},{150,-2}}, color={159,159,223}));
  connect(turbine.outlet, sensP_BA_PACKout.flange) annotation (
    Line(points = {{196, -44}, {208, -44}, {208, -6}}, color = {159, 159, 223}));
  connect(sensP_BA_PHXin.p, signalBus.signalSubBus_BA_p.p_BA_PHXin) annotation (Line(points={{-153,-4},{-150,-4},{-150,-100},{280,-100},{280,0},{300,0}},       color={0,0,127}));
  connect(sensP_BA_PHXout.p, signalBus.signalSubBus_BA_p.p_BA_PHXout) annotation (Line(points={{-23,6},{-20,6},{-20,-98},{278,-98},{278,0},{300,0}},       color={0,0,127}));
  connect(sensP_BA_SHXin.p, signalBus.signalSubBus_BA_p.p_BA_SHXin) annotation (Line(points={{47,4},{54,4},{54,-96},{276,-96},{276,0},{300,0}},       color={0,0,127}));
  connect(sensP_BA_SHXout.p, signalBus.signalSubBus_BA_p.p_BA_SHXout) annotation (Line(points={{157,8},{160,8},{160,-94},{274,-94},{274,0},{300,0}},       color={0,0,127}));
  connect(sensP_BA_PACKout.p, signalBus.signalSubBus_BA_p.p_BA_PACKout) annotation (
    Line(points={{215,4},{232,4},{232,-92},{272,-92},{272,0},{300,0}},                    color = {0, 0, 127}));
  connect(T_cold_in, sourceP_RAin.in_T) annotation (Line(points={{-300,90},{-210,90},{-210,59}}, color={0,0,127}));
  connect(throughMassFlow_RA_SHXin.outlet, sensT_RA_SHXin.inlet) annotation (Line(points={{-130,70},{20,70},{20,40},{34,40}}, color={159,159,223}));
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (Line(points={{-200,50},{-190,50}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, throughMassFlow_RA_SHXin.inlet) annotation (Line(points={{-170,50},{-160,50},{-160,70},{-150,70}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, sensT_RA_PHXin.inlet) annotation (Line(points={{-170,50},{-160,50},{-160,40},{-146,40}}, color={159,159,223}));
  connect(p_cold_in, sourceP_RAin.in_p0) annotation (Line(points={{-300,60},{-260,60},{-260,80},{-216,80},{-216,56.4}}, color={0,0,127}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (Line(points={{-200,-40},{-190,-40}}, color={159,159,223}));
  connect(throughMassFlow_BAin.outlet, sensT_BA_PHXin.inlet) annotation (Line(points={{-170,-40},{-146,-40}}, color={159,159,223}));
  connect(throughMassFlow_BAin.outlet, sensP_BA_PHXin.flange) annotation (Line(points={{-170,-40},{-160,-40},{-160,-14}}, color={159,159,223}));
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}}), graphics={Text(
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
          horizontalAlignment=TextAlignment.Left)}));
end ECS_lossless;
