within PL_Lib.Templates;
model ECS_lossy
//  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching = true);

  //  HX Geometry Parameters:
  parameter Integer Nnodes=10 "number of Nodes";
  parameter Integer Nt=20 "Number of tubes in parallel";
  parameter Modelica.SIunits.Length Lhex=10 "total length";
  parameter Modelica.SIunits.Diameter Dihex=0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex=Dihex/2 "internal radius";
  parameter Modelica.SIunits.Length omegahex=Modelica.Constants.pi*Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex=Modelica.Constants.pi*rhex^2 "internal cross section";
  parameter Real Cfhex=0.005 "friction coefficient";

  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA=101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA=101325*2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA=273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA=273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA=273.15 + 300;
  parameter Modelica.SIunits.Temperature Thex_out_BA=273.15 + 60;

  inner ThermoPower.System system annotation (Placement(visible=true, transformation(extent={{280,80},{300,100}}, rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-90,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-170,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = Medium, use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-30,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(
    redeclare package Medium = Medium,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-290,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-260,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = Medium,
    use_in_T=true,
    use_in_p0=true)  annotation (Placement(visible=true, transformation(
        origin={-290,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-260,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RA_SHXout(redeclare package Medium = Medium, use_in_p0=true) annotation (Placement(visible=true, transformation(extent={{160,30},{180,50}}, rotation=0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-230,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-200,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(extent={{280,-20},{300,0}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=10, w(start=523.3, fixed=false)) annotation (Placement(visible=true, transformation(
        origin={70,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin annotation (Placement(transformation(extent={{-180,-46},{-160,-26}})));
  ThermoPower.Gas.SensT sensT_RA_PHXout annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  ThermoPower.Gas.SensT sensT_RA_SHXout(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={110,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXout(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={110,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_BA_SHXin(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Interfaces.TurbineBase turbine annotation (Placement(transformation(extent={{160,-80},{200,-40}})));
  replaceable Interfaces.CompressorBase compressor annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
  replaceable Interfaces.HeatExchangerBase PHX annotation (Placement(transformation(extent={{-150,-20},{-110,20}})));
  replaceable Interfaces.HeatExchangerBase SHX annotation (Placement(transformation(extent={{50,-20},{90,20}})));
  ThermoPower.Gas.SensT sensT_BA_PACKout(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={220,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.PressDropLin pressDropLin annotation (Placement(transformation(extent={{-210,30},{-190,50}})));
  ThermoPower.Gas.PressDropLin pressDropLin1 annotation (Placement(transformation(extent={{-208,-50},{-188,-30}})));
  ThermoPower.Gas.PressDropLin pressDropLin2 annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  ThermoPower.Gas.PressDropLin pressDropLin3 annotation (Placement(transformation(extent={{-70,-54},{-50,-34}})));
  ThermoPower.Gas.PressDropLin pressDropLin4 annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
  ThermoPower.Gas.PressDropLin pressDropLin5 annotation (Placement(transformation(extent={{130,30},{150,50}})));
  ThermoPower.Gas.SensT sensT_RA_PHXin1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={30,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.PressDropLin pressDropLin6 annotation (Placement(transformation(extent={{130,-54},{150,-34}})));
  ThermoPower.Gas.PressDropLin pressDropLin7 annotation (Placement(transformation(extent={{240,-54},{260,-34}})));
protected
  parameter Real tableEtaC[6,4]=[0,95,100,105; 1,82.5e-2,81e-2,80.5e-2; 2,84e-2,82.9e-2,82e-2; 3,83.2e-2,82.2e-2,81.5e-2; 4,82.5e-2,81.2e-2,79e-2; 5,79.5e-2,78e-2,76.5e-2];
  parameter Real tablePhicC[6,4]=[0,95,100,105; 1,38.3e-3,43e-3,46.8e-3; 2,39.3e-3,43.8e-3,47.9e-3; 3,40.6e-3,45.2e-3,48.4e-3; 4,41.6e-3,46.1e-3,48.9e-3; 5,42.3e-3,46.6e-3,49.3e-3];
  parameter Real tablePRC[6,4]=[0,95,100,105; 1,22.6,27,32; 2,22,26.6,30.8; 3,20.8,25.5,29; 4,19,24.3,27.1; 5,17,21.5,24.2];
  parameter Real tablePhicT[5,4]=[1,90,100,110; 2.36,4.68e-3,4.68e-3,4.68e-3; 2.88,4.68e-3,4.68e-3,4.68e-3; 3.56,4.68e-3,4.68e-3,4.68e-3; 4.46,4.68e-3,4.68e-3,4.68e-3];
  parameter Real tableEtaT[5,4]=[1,90,100,110; 2.36,89e-2,89.5e-2,89.3e-2; 2.88,90e-2,90.6e-2,90.5e-2; 3.56,90.5e-2,90.6e-2,90.5e-2; 4.46,90.2e-2,90.3e-2,90e-2];
initial equation
  inertia.w = 523.3;
equation
  connect(throughMassFlow_RAin.outlet, flowSplit.inlet) annotation (Line(points={{-250,50},{-236,50}}, color={159,159,223}));
  connect(flowSplit.outlet1, throughMassFlow.inlet) annotation (Line(points={{-224,54},{-220,54},{-220,70},{-210,70}}, color={159,159,223}));
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
  connect(flowSplit.outlet2, pressDropLin.inlet) annotation (Line(points={{-224,46},{-220,46},{-220,40},{-210,40}}, color={159,159,223}));
  connect(pressDropLin.outlet, sensT_RA_PHXin.inlet) annotation (Line(points={{-190,40},{-176,40}}, color={159,159,223}));
  connect(sensT_RA_PHXout.outlet, pressDropLin2.inlet) annotation (Line(points={{-84,40},{-70,40}}, color={159,159,223}));
  connect(pressDropLin2.outlet, sinkP_RA_PHXout.flange) annotation (Line(points={{-50,40},{-40,40}}, color={159,159,223}));
  connect(compressor.inlet, pressDropLin3.outlet) annotation (Line(points={{-36,-44},{-50,-44}}, color={159,159,223}));
  connect(pressDropLin3.inlet, sensT_BA_PHXout.outlet) annotation (Line(points={{-70,-44},{-84,-44}}, color={159,159,223}));
  connect(throughMassFlow.outlet, pressDropLin4.inlet) annotation (Line(points={{-190,70},{-62,70}}, color={159,159,223}));
  connect(sensT_RA_SHXout.outlet, pressDropLin5.inlet) annotation (Line(points={{116,40},{130,40}}, color={159,159,223}));
  connect(pressDropLin5.outlet, sinkP_RA_SHXout.flange) annotation (Line(points={{150,40},{160,40}}, color={159,159,223}));
  connect(pressDropLin4.outlet, sensT_RA_PHXin1.inlet) annotation (Line(points={{-42,70},{14,70},{14,40},{24,40}}, color={159,159,223}));
  connect(sensT_RA_PHXin1.outlet, SHX.infl_1) annotation (Line(points={{36,40},{40,40},{40,10},{50,10}}, color={159,159,223}));
  connect(sensT_BA_SHXout.outlet, pressDropLin6.inlet) annotation (Line(points={{116,-44},{130,-44}}, color={159,159,223}));
  connect(pressDropLin6.outlet, turbine.inlet) annotation (Line(points={{150,-44},{164,-44}}, color={159,159,223}));
  connect(sensT_BA_PACKout.outlet, pressDropLin7.inlet) annotation (Line(points={{226,-44},{240,-44}}, color={159,159,223}));
  connect(pressDropLin7.outlet, sinkP_PACKout.flange) annotation (Line(points={{260,-44},{274,-44},{274,-10},{280,-10}}, color={159,159,223}));
  annotation (
    Diagram(coordinateSystem(extent={{-300,-100},{300,100}}), graphics={Text(
          origin={-270,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Bleed air (hot side)"), Text(
          origin={-270,30},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Ram air (cold side)")}),
    experiment(
      StopTime=3000,
      Tolerance=1e-06,
      StartTime=0,
      Interval=6),
    Documentation(info=""),
    __Dymola_experimentSetupOutput);
end ECS_lossy;
