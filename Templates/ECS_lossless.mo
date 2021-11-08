within PL_Lib.Templates;
model ECS_lossless
  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  parameter Modelica.SIunits.Inertia J_shaft = 10;
  parameter Modelica.SIunits.AngularVelocity w0 = 523.3;

  inner ThermoPower.System system annotation (Placement(visible=true, transformation(extent={{260,80},{280,100}}, rotation=0)));
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
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = ColdFluid, w0=0.5)
                                                                                             annotation (Placement(visible=true, transformation(
        origin={-180,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = HotFluid, w0=0.25)
                                                                                            annotation (Placement(visible=true, transformation(
        origin={-180,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RA_SHXin(redeclare package Medium = ColdFluid, w0=0.25)
                                                                                                 annotation (Placement(visible=true, transformation(
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
equation
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (Line(points={{-200,50},{-190,50}}, color={159,159,223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (Line(points={{-200,-40},{-190,-40}}, color={159,159,223}));
  connect(throughMassFlow_BAin.outlet, sensT_BA_PHXin.inlet) annotation (Line(points={{-170,-40},{-146,-40}}, color={159,159,223}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-34,40},{-20,40}}, color={159,159,223}));
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (Line(points={{-70,10},{-60,10},{-60,40},{-46,40}}, color={159,159,223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (Line(points={{-70,-10},{-60,-10},{-60,-44},{-46,-44}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (Line(points={{-134,40},{-120,40},{-120,10},{-110,10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (Line(points={{-134,-40},{-120,-40},{-120,-10},{-110,-10}}, color={159,159,223}));
  connect(compressor.inlet, sensT_BA_PHXout.outlet) annotation (Line(points={{-16,-44},{-34,-44}}, color={159,159,223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (Line(points={{16,-44},{34,-44}}, color={159,159,223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation (Line(points={{110,10},{120,10},{120,40},{134,40}},color={159,159,223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation (Line(points={{110,-10},{120,-10},{120,-44},{134,-44}},color={159,159,223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{12,-60},{80,-60}}, color={0,0,0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (Line(points={{100,-60},{168,-60}},color={0,0,0}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation (Line(points={{46,-44},{60,-44},{60,-10},{70,-10}}, color={159,159,223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation (Line(points={{146,-44},{164,-44}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{146,40},{160,40}}, color={159,159,223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (Line(points={{214,-44},{196,-44}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, sinkP_PACKout.flange) annotation (Line(points={{226,-44},{234,-44},{234,-10},{240,-10}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, throughMassFlow_RA_SHXin.inlet) annotation (Line(points={{-170,50},{-160,50},{-160,70},{-150,70}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, sensT_RA_PHXin.inlet) annotation (Line(points={{-170,50},{-160,50},{-160,40},{-146,40}}, color={159,159,223}));
  connect(throughMassFlow_RA_SHXin.outlet, SHX.infl_1) annotation (Line(points={{-130,70},{60,70},{60,10},{70,10}}, color={159,159,223}));
  annotation (
    Diagram(coordinateSystem(extent={{-300,-100},{300,100}}), graphics={Text(
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
          horizontalAlignment=TextAlignment.Left)}),
    experiment(
      StopTime=3000,
      Tolerance=1e-06,
      StartTime=0,
      Interval=6));
end ECS_lossless;
