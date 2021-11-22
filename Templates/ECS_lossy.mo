within PL_Lib.Templates;
model ECS_lossy
  extends PL_Lib.Interfaces.ConfigurationBase;
  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable Interfaces.TurbineBase turbine(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{160,-80},{200,-40}})));
  replaceable Interfaces.CompressorBase compressor(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{-150,-20},{-110,20}})));
  replaceable Interfaces.HeatExchangerBase SHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{50,-20},{90,20}})));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-90,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-170,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-180,-46},{-160,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={110,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={110,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={220,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin1(redeclare package Medium = ColdFluid) annotation (
    Placement(visible = true, transformation(origin = {26, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-30,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(extent={{160,30},{180,50}}, rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{280,-20},{300,0}}, rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(
    redeclare package Medium = ColdFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-290,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = HotFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-290,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-260,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-260,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-200,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-210,30},{-190,50}})));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-208,-50},{-188,-30}})));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-70,-54},{-50,-34}})));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
  ThermoPower.Gas.PressDropLin pressDropLin5(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{130,30},{150,50}})));
  ThermoPower.Gas.PressDropLin pressDropLin6(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{130,-54},{150,-34}})));
  ThermoPower.Gas.PressDropLin pressDropLin7(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{240,-54},{260,-34}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(visible=true, transformation(
        origin={70,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
protected
  parameter Modelica.SIunits.Inertia J_shaft=10;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (Line(points={{-280,50},{-270,50}}, color={159,159,223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (Line(points={{-280,-40},{-270,-40}}, color={159,159,223}));
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (Line(points={{-110,10},{-100,10},{-100,40},{-96,40}}, color={159,159,223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (Line(points={{-110,-10},{-100,-10},{-100,-44},{-96,-44}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (Line(points={{-164,40},{-160,40},{-160,10},{-150,10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (Line(points={{-164,-40},{-160,-40},{-160,-10},{-150,-10}}, color={159,159,223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (Line(points={{-4,-44},{14,-44}}, color={159,159,223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation (Line(points={{90,10},{100,10},{100,40},{104,40}}, color={159,159,223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation (Line(points={{90,-10},{100,-10},{100,-44},{104,-44}}, color={159,159,223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{-8,-60},{60,-60}}, color={0,0,0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (Line(points={{80,-60},{168,-60}}, color={0,0,0}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation (Line(points={{26,-44},{40,-44},{40,-10},{50,-10}}, color={159,159,223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (Line(points={{214,-44},{196,-44}}, color={159,159,223}));
  connect(throughMassFlow_BAin.outlet, pressDropLin1.inlet) annotation (Line(points={{-250,-40},{-208,-40}}, color={159,159,223}));
  connect(pressDropLin1.outlet, sensT_BA_PHXin.inlet) annotation (Line(points={{-188,-40},{-176,-40}}, color={159,159,223}));
  connect(pressDropLin.outlet, sensT_RA_PHXin.inlet) annotation (Line(points={{-190,40},{-176,40}}, color={159,159,223}));
  connect(sensT_RA_PHXout.outlet, pressDropLin2.inlet) annotation (Line(points={{-84,40},{-70,40}}, color={159,159,223}));
  connect(pressDropLin2.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-50,40},{-40,40}}, color={159,159,223}));
  connect(compressor.inlet, pressDropLin3.outlet) annotation (Line(points={{-36,-44},{-50,-44}}, color={159,159,223}));
  connect(pressDropLin3.inlet, sensT_BA_PHXout.outlet) annotation (Line(points={{-70,-44},{-84,-44}}, color={159,159,223}));
  connect(throughMassFlow_RA_SHXin.outlet, pressDropLin4.inlet) annotation (Line(points={{-190,70},{-62,70}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, pressDropLin5.inlet) annotation (Line(points={{116,40},{130,40}}, color={159,159,223}));
  connect(pressDropLin5.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{150,40},{160,40}}, color={159,159,223}));
  connect(pressDropLin4.outlet, sensT_RA_PHXin1.inlet) annotation (
    Line(points = {{-42, 70}, {14, 70}, {14, 40}, {20, 40}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin1.outlet, SHX.infl_1) annotation (
    Line(points = {{32, 40}, {40, 40}, {40, 10}, {50, 10}}, color = {159, 159, 223}));
  connect(sensT_BA_SHXout.outlet, pressDropLin6.inlet) annotation (Line(points={{116,-44},{130,-44}}, color={159,159,223}));
  connect(pressDropLin6.outlet, turbine.inlet) annotation (Line(points={{150,-44},{164,-44}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, pressDropLin7.inlet) annotation (Line(points={{226,-44},{240,-44}}, color={159,159,223}));
  connect(pressDropLin7.outlet, sinkP_PACKout.flange) annotation (Line(points={{260,-44},{274,-44},{274,-10},{280,-10}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, throughMassFlow_RA_SHXin.inlet) annotation (Line(points={{-250,50},{-220,50},{-220,70},{-210,70}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, pressDropLin.inlet) annotation (Line(points={{-250,50},{-220,50},{-220,40},{-210,40}}, color={159,159,223}));
  annotation (
    Diagram(coordinateSystem(extent={{-300,-100},{300,100}}), graphics={Text(origin = {-270, -60}, lineColor = {238, 46, 47}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Left), Text(origin = {-270, 30}, lineColor = {28, 108, 200}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)", textStyle = {TextStyle.Bold},
            horizontalAlignment =                                                                                                                                                                                                        TextAlignment.Left)}),
    experiment(
      StopTime=3000,
      Tolerance=1e-06,
      StartTime=0,
      Interval=6),
    Documentation(info=""),
    __Dymola_experimentSetupOutput);
end ECS_lossy;
