within PL_Lib.Models.Obsolete;
model ECS_exampleTemplate2
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
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

  inner ThermoPower.System system annotation (Placement(visible=true, transformation(extent={{180,140},{200,160}}, rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_BAin1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-130,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_BAout1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-20,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_RAout1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-20,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_RAin1(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-130,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp_T_RAin(
    duration=600,
    height=-45,
    offset=273.15 + 20,
    startTime=300) annotation (Placement(visible=true, transformation(
        origin={-244,100},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(
    duration=600,
    height=-74825,
    offset=101325,
    startTime=300) annotation (Placement(visible=true, transformation(
        origin={-244,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout1(
    redeclare package Medium = Medium, use_in_p0=true)
                     annotation (Placement(visible=true, transformation(
        origin={10,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(
    redeclare package Medium = Medium,
    T(displayUnit="K") = 293.15 + 20,
    p0=101325,
    use_in_T=false,
    use_in_p0=true) annotation (Placement(visible=true, transformation(
        origin={-220,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_RAin(redeclare package Medium = Medium, w0=0.5) annotation (Placement(visible=true, transformation(
        origin={-190,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = Medium,
    T(displayUnit="K") = 273.15 + 200,
    p0=101325*2,
    use_in_T=false,
    use_in_p0=false) annotation (Placement(visible=true, transformation(
        origin={-190,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = Medium, w0=0.25) annotation (Placement(visible=true, transformation(
        origin={-160,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout2(redeclare package Medium = Medium, use_in_p0=true)  annotation (Placement(visible=true, transformation(extent={{150,30},{170,50}}, rotation=0)));
  ThermoPower.Gas.FlowSplit flowSplit(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-160,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0=0.25) annotation (Placement(visible=true, transformation(
        origin={-130,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_RAin2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={40,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_RAout2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={130,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_BAin2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={40,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_BAout2(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={130,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(extent={{240,-40},{260,-20}}, rotation=0)));
  PL_Lib.Components.Obsolete.StateReader_gas stateReader_BAout3(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={220,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=100, w(start=523.3)) annotation (Placement(visible=true, transformation(
        origin={96,-86},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable PL_Lib.Components.HX_1DCoFlow PHX(redeclare package ColdFluid = Medium, redeclare package HotFluid = Medium) constrainedby PL_Lib.Interfaces.HeatExchangerBase annotation (Placement(transformation(extent={{-90,-16},{-50,24}})));
  replaceable PL_Lib.Components.HX_1DCoFlow SHX(redeclare package ColdFluid = Medium, redeclare package HotFluid = Medium) constrainedby PL_Lib.Interfaces.HeatExchangerBase annotation (Placement(transformation(extent={{68,-20},{108,20}})));
  replaceable PL_Lib.Components.Compressor_noMaps Compressor(
    redeclare package Medium = Medium,
    Ndesign=523.3,
    PR_set=2.5,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    Tdes_in=363.15,
    Tstart_in=363.15,
    Tstart_out=473.15,
    eta_set=0.9,
    pstart_in=200000,
    pstart_out=500000) constrainedby PL_Lib.Interfaces.CompressorBase annotation (Placement(transformation(extent={{-12,-106},{28,-66}})));
  replaceable PL_Lib.Components.Turbine_noMaps Turbine(
    redeclare package Medium = Medium,
    Ndesign=523.3,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    Tdes_in=363.15,
    Tstart_in=1270,
    Tstart_out=883,
    pstart_in=785000,
    pstart_out=152000) constrainedby PL_Lib.Interfaces.TurbineBase annotation (Placement(transformation(extent={{158,-106},{198,-66}})));
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=300)          annotation (Placement(transformation(extent={{-254,2},{-234,22}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=101325*2) annotation (Placement(transformation(extent={{-254,-28},{-234,-8}})));
equation
  connect(ramp_T_RAin.y, sourceP_RAin.in_T) annotation (Line(points={{-233,100},{-220,100},{-220,59}}, color={0,0,127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation (Line(points={{-233,70},{-226,70},{-226,56.4}}, color={0,0,127}));
  connect(ramp_P_RAin.y, sinkP_RAout1.in_p0) annotation (Line(points={{-233,70},{3.55,70},{3.55,45.95}}, color={0,0,127}));
  connect(throughMassFlow_BAin.outlet, stateReader_BAin1.inlet) annotation (Line(points={{-150,-40},{-136,-40}}, color={159,159,223}));
  connect(throughMassFlow_RAin.outlet, flowSplit.inlet) annotation (Line(points={{-180,50},{-166,50}}, color={159,159,223}));
  connect(flowSplit.outlet1, throughMassFlow.inlet) annotation (Line(points={{-154,54},{-150,54},{-150,60},{-140,60}}, color={159,159,223}));
  connect(flowSplit.outlet2, stateReader_RAin1.inlet) annotation (Line(points={{-154,46},{-150,46},{-150,40},{-136,40}}, color={159,159,223}));
  connect(ramp_P_RAin.y, sinkP_RAout2.in_p0) annotation (Line(points={{-233,70},{153.55,70},{153.55,45.95}}, color={0,0,127}));
  connect(sourceP_RAin.flange, throughMassFlow_RAin.inlet) annotation (Line(points={{-210,50},{-200,50}}, color={159,159,223}));
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (Line(points={{-180,-40},{-170,-40}}, color={159,159,223}));
  connect(stateReader_RAout1.outlet, sinkP_RAout1.flange) annotation (Line(points={{-14,40},{0,40}}, color={159,159,223}));
  connect(stateReader_RAout2.outlet, sinkP_RAout2.flange) annotation (Line(points={{136,40},{150,40}}, color={159,159,223}));
  connect(stateReader_BAout3.outlet, sinkPressure.flange) annotation (Line(points={{226,-30},{240,-30}}, color={159,159,223}));
  connect(throughMassFlow.outlet, stateReader_RAin2.inlet) annotation (Line(points={{-120,60},{26,60},{26,40},{34,40}}, color={159,159,223}));
  connect(stateReader_RAin1.outlet, PHX.infl_1) annotation (Line(points={{-124,40},{-100,40},{-100,14},{-90,14}}, color={159,159,223}));
  connect(stateReader_BAin1.outlet, PHX.infl_2) annotation (Line(points={{-124,-40},{-100,-40},{-100,-6},{-90,-6}}, color={159,159,223}));
  connect(PHX.outfl_1, stateReader_RAout1.inlet) annotation (Line(points={{-50,14},{-36,14},{-36,40},{-26,40}}, color={159,159,223}));
  connect(PHX.outfl_2, stateReader_BAout1.inlet) annotation (Line(points={{-50,-6},{-36,-6},{-36,-40},{-26,-40}}, color={159,159,223}));
  connect(stateReader_BAin2.inlet, Compressor.outlet) annotation (Line(points={{34,-40},{30,-40},{30,-70},{24,-70}}, color={159,159,223}));
  connect(stateReader_BAout1.outlet, Compressor.inlet) annotation (Line(points={{-14,-40},{-12,-40},{-12,-70},{-8,-70}}, color={159,159,223}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (Line(points={{20,-86},{86,-86}}, color={0,0,0}));
  connect(stateReader_RAin2.outlet, SHX.infl_1) annotation (Line(points={{46,40},{58,40},{58,10},{68,10}}, color={159,159,223}));
  connect(stateReader_BAin2.outlet, SHX.infl_2) annotation (Line(points={{46,-40},{58,-40},{58,-10},{68,-10}}, color={159,159,223}));
  connect(SHX.outfl_1, stateReader_RAout2.inlet) annotation (Line(points={{108,10},{118,10},{118,24},{114,24},{114,40},{124,40}}, color={159,159,223}));
  connect(SHX.outfl_2, stateReader_BAout2.inlet) annotation (Line(points={{108,-10},{118,-10},{118,-24},{114,-24},{114,-40},{124,-40}}, color={159,159,223}));
  connect(stateReader_BAout2.outlet, Turbine.inlet) annotation (Line(points={{136,-40},{152,-40},{152,-70},{162,-70}}, color={159,159,223}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (Line(points={{106,-86},{166,-86}}, color={0,0,0}));
  connect(Turbine.outlet, stateReader_BAout3.inlet) annotation (Line(points={{194,-70},{194,-30},{214,-30}}, color={159,159,223}));
  annotation (
    Diagram(coordinateSystem(extent={{-200,-140},{200,160}}), graphics={Text(
          origin={-180,-20},
          lineColor={170,0,0},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-184,80},
          lineColor={0,85,255},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          horizontalAlignment=TextAlignment.Left)}),
    experiment(
      StopTime=3000,
      Tolerance=1e-06,
      StartTime=0,
      Interval=6),
    Documentation(info="<html>
<p>The model is designed to test the component <code>Gas.Flow1DFV</code> (fluid side of a heat exchanger, finite volumes). A uniform prescribed heat flux is applied to the lateral boundary. The working fluid is pure nitrogen.</p>
<p>The model starts at steady state. </p>
<p><ul>
<li>At t = 10 s, step variation of the temperature of the fluid entering the heat exchanger. The temperature change is propagated at the outlet with a delay approximately equal to the residence time</li>
<li>At t = 20 s, a thermal power flow W is applied to the heat exchanger lateral surface. The outlet temperature undergoes a ramp change, whose duration is approximately equal to the residence time, and whose amplitude is equal to W/(whex*cp)</li>
<li>At t = 50 s, step reduction of the outlet valve opening</li>
</ul></p>
<p>Simulation Interval = [0...80] sec </p>
<p>Integration Algorithm = DASSL </p>
<p>Algorithm Tolerance = 1e-6 </p>
</html>"),
    __Dymola_experimentSetupOutput);
end ECS_exampleTemplate2;
