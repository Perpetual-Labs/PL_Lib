within PL_Lib.Templates;
model ECS_lossless
  //  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package HotFluid = Modelica.Media.Interfaces.PartialMedium annotation (
    choicesAllMatching = true);
  replaceable package ColdFluid = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  inner ThermoPower.System system annotation (Placement(visible=true, transformation(extent={{220,80},{240,100}}, rotation=0)));

  replaceable Interfaces.TurbineBase turbine(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{140,-80},{180,-40}})));
  replaceable Interfaces.CompressorBase compressor(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));
  replaceable Interfaces.HeatExchangerBase SHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (Placement(transformation(extent={{50,-20},{90,20}})));

  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-30,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(
    redeclare package Medium = ColdFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-250,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-220,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = HotFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-250,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-220,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(visible=true, transformation(extent={{140,30},{160,50}}, rotation=0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-190,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RA_SHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-160,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(extent={{220,-20},{240,0}}, rotation=0)));

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=10, w(start=523.3, fixed=false)) annotation (Placement(visible=true, transformation(
        origin={70,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={-60,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={120,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = HotFluid) annotation (Placement(visible=true, transformation(
        origin={200,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{-170,-46},{-150,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={-160,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = ColdFluid) annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = ColdFluid) annotation (Placement(visible=true, transformation(
        origin={120,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout1(redeclare package Medium = ColdFluid)
                                                                              annotation (Placement(transformation(extent={{-10,64},{10,84}})));
protected
  parameter Real tableEtaC[6,4]=[0,95,100,105; 1,82.5e-2,81e-2,80.5e-2; 2,84e-2,82.9e-2,82e-2; 3,83.2e-2,82.2e-2,81.5e-2; 4,82.5e-2,81.2e-2,79e-2; 5,79.5e-2,78e-2,76.5e-2];
  parameter Real tablePhicC[6,4]=[0,95,100,105; 1,38.3e-3,43e-3,46.8e-3; 2,39.3e-3,43.8e-3,47.9e-3; 3,40.6e-3,45.2e-3,48.4e-3; 4,41.6e-3,46.1e-3,48.9e-3; 5,42.3e-3,46.6e-3,49.3e-3];
  parameter Real tablePRC[6,4]=[0,95,100,105; 1,22.6,27,32; 2,22,26.6,30.8; 3,20.8,25.5,29; 4,19,24.3,27.1; 5,17,21.5,24.2];
  parameter Real tablePhicT[5,4]=[1,90,100,110; 2.36,4.68e-3,4.68e-3,4.68e-3; 2.88,4.68e-3,4.68e-3,4.68e-3; 3.56,4.68e-3,4.68e-3,4.68e-3; 4.46,4.68e-3,4.68e-3,4.68e-3];
  parameter Real tableEtaT[5,4]=[1,90,100,110; 2.36,89e-2,89.5e-2,89.3e-2; 2.88,90e-2,90.6e-2,90.5e-2; 3.56,90.5e-2,90.6e-2,90.5e-2; 4.46,90.2e-2,90.3e-2,90e-2];
initial equation
  inertia.w = 523.3;
equation
  connect(throughMassFlow_RAin.outlet, flowSplit.inlet) annotation (Line(points={{-210,50},{-196,50}}, color={159,159,223}));
  connect(flowSplit.outlet1, throughMassFlow_RA_SHXin.inlet) annotation (Line(points={{-184,54},{-180,54},{-180,70},{-170,70}}, color={159,159,223}));
  connect(flowSplit.outlet2, sensT_RA_PHXin.inlet) annotation (Line(points={{-184,46},{-180,46},{-180,40},{-166,40}}, color={159,159,223}));
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (Line(points={{-240,50},{-230,50}}, color={159,159,223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (Line(points={{-240,-40},{-230,-40}}, color={159,159,223}));
  connect(throughMassFlow_BAin.outlet, sensT_BA_PHXin.inlet) annotation (Line(points={{-210,-40},{-166,-40}}, color={159,159,223}));
  connect(sensT_RA_PHXout.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-54,40},{-40,40}}, color={159,159,223}));
  connect(PHX.outfl_1, sensT_RA_PHXout.inlet) annotation (Line(points={{-90,10},{-80,10},{-80,40},{-66,40}}, color={159,159,223}));
  connect(PHX.outfl_2, sensT_BA_PHXout.inlet) annotation (Line(points={{-90,-10},{-80,-10},{-80,-44},{-66,-44}}, color={159,159,223}));
  connect(sensT_RA_PHXin.outlet, PHX.infl_1) annotation (Line(points={{-154,40},{-140,40},{-140,10},{-130,10}}, color={159,159,223}));
  connect(sensT_BA_PHXin.outlet, PHX.infl_2) annotation (Line(points={{-154,-40},{-140,-40},{-140,-10},{-130,-10}}, color={159,159,223}));
  connect(compressor.inlet, sensT_BA_PHXout.outlet) annotation (Line(points={{-36,-44},{-54,-44}}, color={159,159,223}));
  connect(compressor.outlet, sensT_BA_SHXin.inlet) annotation (Line(points={{-4,-44},{14,-44}}, color={159,159,223}));
  connect(SHX.outfl_1, sensT_RA_SHXout.inlet) annotation (Line(points={{90,10},{100,10},{100,40},{114,40}}, color={159,159,223}));
  connect(SHX.outfl_2, sensT_BA_SHXout.inlet) annotation (Line(points={{90,-10},{100,-10},{100,-44},{114,-44}}, color={159,159,223}));
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{-8,-60},{60,-60}}, color={0,0,0}));
  connect(inertia.flange_b, turbine.shaft_a) annotation (Line(points={{80,-60},{148,-60}}, color={0,0,0}));
  connect(sensT_BA_SHXin.outlet, SHX.infl_2) annotation (Line(points={{26,-44},{40,-44},{40,-10},{50,-10}}, color={159,159,223}));
  connect(sensT_BA_SHXout.outlet, turbine.inlet) annotation (Line(points={{126,-44},{144,-44}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{126,40},{140,40}}, color={159,159,223}));
  connect(sensT_BA_PACKout.inlet, turbine.outlet) annotation (Line(points={{194,-44},{176,-44}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, sinkP_PACKout.flange) annotation (Line(points={{206,-44},{214,-44},{214,-10},{220,-10}}, color={159,159,223}));
  connect(throughMassFlow_RA_SHXin.outlet, sensT_RA_PHXout1.inlet) annotation (Line(points={{-150,70},{-6,70}}, color={159,159,223}));
  connect(sensT_RA_PHXout1.outlet, SHX.infl_1) annotation (Line(points={{6,70},{40,70},{40,10},{50,10}}, color={159,159,223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-260, -100}, {240, 100}}), graphics={  Text(origin = {-230, -60}, lineColor = {238, 46, 47}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Left), Text(origin = {-230, 30}, lineColor = {28, 108, 200}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)", textStyle = {TextStyle.Bold},
            horizontalAlignment =                                                                                                                                                                                                        TextAlignment.Left)}),
    experiment(StopTime = 3000, Tolerance = 1e-06, StartTime = 0, Interval = 6),
    Documentation(info = ""),
    __Dymola_experimentSetupOutput);
end ECS_lossless;
