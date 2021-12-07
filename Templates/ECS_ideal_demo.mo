within PL_Lib.Templates;
partial model ECS_ideal_demo
  extends PL_Lib.Interfaces.ConfigurationBase;

  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";

  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable Components.Turbine_noMaps
                                     turbine(
    redeclare package Medium = HotFluid,
    Tdes_in=573.15,
    pstart_in=100000,
    pstart_out=100000,
    Tstart_out=573.15) constrainedby Interfaces.TurbineBase(
    redeclare package Medium = HotFluid,
    Tdes_in=573.15,
    pstart_in=100000,
    pstart_out=100000,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{130,-100},{170,-60}})));
  replaceable Components.Compressor_noMaps
                                        compressor(
    redeclare package Medium = HotFluid,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) constrainedby Interfaces.CompressorBase(
    redeclare package Medium = HotFluid,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{-60,-100},{-20,-60}})));
  replaceable Components.HX_extFun PrimaryHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) constrainedby Interfaces.HeatExchangerBase(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid)
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-150,-20},{-110,20}})));
  replaceable Components.HX_1DCounterFlow SecondaryHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) constrainedby Interfaces.HeatExchangerBase(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid)
    annotation (choicesAllMatching=true, Placement(transformation(extent={{40,-20},{80,20}})));
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
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(transformation(extent={{130,30},{150,50}})));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{210,-20},{230,0}})));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-80,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={110,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={10,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(
        origin={190,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-190,-46},{-170,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(
        origin={-180,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-90,34},{-70,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(origin={110,44}, extent={{-10,-10},{10,10}})));
  ThermoPower.Gas.SensT sensT_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{0,34},{20,54}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(transformation(origin={60,-80}, extent={{-10,-10},{10,10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_SHXin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold,
    use_in_w0=false,
    use_in_T=true) annotation (Placement(visible=true, transformation(
        origin={-22,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_PHXin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold,
    use_in_w0=false,
    use_in_T=true) annotation (Placement(visible=true, transformation(
        origin={-210,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
protected
  ThermoPower.Gas.SensP sensP_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{-190,10},{-170,30}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{-90,10},{-70,30}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{0,10},{20,30}},  rotation=0)));
  ThermoPower.Gas.SensP sensP_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(extent={{100,8},{120,28}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{-190,-20},{-170,0}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{-90,-20},{-70,0}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{0,-20},{20,0}},  rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{100,-20},{120,0}}, rotation=0)));
  ThermoPower.Gas.SensP sensP_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{180,-24},{200,-4}}, rotation=0)));
protected
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(PrimaryHX.outfl_1, sensT_RA_PHXout.inlet) annotation (Line(points={{-110,10},{-100,10},{-100,40},{-86,40}}, color={159,159,223}));
  connect(PrimaryHX.outfl_2, sensT_BA_PHXout.inlet) annotation (Line(points={{-110,-10},{-100,-10},{-100,-40},{-86,-40}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, PrimaryHX.infl_1) annotation (Line(points={{-174,40},{-160,40},{-160,10},{-150,10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, PrimaryHX.infl_2) annotation (Line(points={{-174,-40},{-160,-40},{-160,-10},{-150,-10}}, color={159,159,223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (Line(points={{-24,-64},{-16,-64},{-16,-40},{4,-40}},
                                                                                                                  color={159,159,223}));
  connect(SecondaryHX.outfl_1, sensT_RA_SHXout.inlet) annotation (Line(points={{80,10},{90,10},{90,40},{104,40}}, color={159,159,223}));
  connect(SecondaryHX.outfl_2, sensT_BA_SHXout.inlet) annotation (Line(points={{80,-10},{90,-10},{90,-40},{104,-40}}, color={159,159,223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{-28,-80},{50,-80}},color={0,0,0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (Line(points={{70,-80},{138,-80}},  color={0,0,0}));
  connect(sensT_BA_SHXin.outlet, SecondaryHX.infl_2) annotation (Line(points={{16,-40},{30,-40},{30,-10},{40,-10}}, color={159,159,223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation (Line(points={{116,-40},{125,-40},{125,-64},{134,-64}}, color={159,159,223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (Line(points={{184,-40},{176,-40},{176,-64},{166,-64}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, sinkP_PACKout.flange) annotation (Line(points={{196,-40},{204,-40},{204,-10},{210,-10}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, SecondaryHX.infl_1) annotation (Line(points={{16,40},{30,40},{30,10},{40,10}}, color={159,159,223}));
  connect(PrimaryHX.outfl_2, sensP_BA_PHXout.flange) annotation (Line(points={{-110,-10},{-100,-10},{-100,-14},{-80,-14}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, sensP_BA_PHXin.flange) annotation (Line(points={{-174,-40},{-160,-40},{-160,-14},{-180,-14}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, sensP_RA_PHXin.flange) annotation (Line(points={{-174,40},{-160,40},{-160,16},{-180,16}}, color={159,159,223}));
  connect(PrimaryHX.outfl_1, sensP_RA_PHXout.flange) annotation (Line(points={{-110,10},{-100,10},{-100,16},{-80,16}}, color={159,159,223}));
  connect(sensT_RA_SHXin.outlet, sensP_RA_SHXin.flange) annotation (Line(points={{16,40},{30,40},{30,16},{10,16}}, color={159,159,223}));
  connect(sensT_BA_SHXin.outlet, sensP_BA_SHXin.flange) annotation (Line(points={{16,-40},{30,-40},{30,-14},{10,-14}}, color={159,159,223}));
  connect(SecondaryHX.outfl_1, sensP_RA_SHXout.flange) annotation (Line(points={{80,10},{90,10},{90,14},{110,14}}, color={159,159,223}));
  connect(SecondaryHX.outfl_2, sensP_BA_SHXout.flange) annotation (Line(points={{80,-10},{90,-10},{90,-14},{110,-14}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, sensP_BA_PACKout.flange) annotation (Line(points={{196,-40},{204,-40},{204,-18},{190,-18}}, color={159,159,223}));
  connect(sourceMassFlow_RA_PHXin.flange, sensT_RA_PHXin.inlet) annotation (Line(points={{-200,40},{-186,40}}, color={159,159,223}));
  connect(sourceP_BAin.flange, sensT_BA_PHXin.inlet) annotation (Line(points={{-200,-40},{-186,-40}}, color={159,159,223}));
  connect(sourceMassFlow_RA_SHXin.flange, sensT_RA_SHXin.inlet) annotation (Line(points={{-12,40},{4,40}}, color={159,159,223}));
  connect(sensT_BA_PHXout.outlet, compressor.inlet) annotation (Line(points={{-74,-40},{-70,-40},{-70,-64},{-56,-64}}, color={159,159,223}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-74,40},{-60,40}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{116,40},{130,40}}, color={159,159,223}));
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}}), graphics={Text(
          origin={-190,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-190,60},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-206,-164},
          lineColor={0,140,72},
          extent={{-50,10},{50,-10}},
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left,
          fontSize=12,
          textString="External C++ code"),         Text(
          origin={-16,-164},
          lineColor={0,140,72},
          extent={{-50,10},{50,-10}},
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left,
          textString="Native Modelica code",
          fontSize=12),
        Line(
          points={{-20,-170},{-30,-200}},
          color={0,140,72},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-236,-170},{-246,-200}},
          color={0,140,72},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled})}));
end ECS_ideal_demo;
