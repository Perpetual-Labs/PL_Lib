within PL_Lib.Templates.PACK;
model PACK_simple_template
  inner ThermoPower.System system annotation (Placement(visible=true, transformation(
        origin={150,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";

  replaceable PL_Lib.Interfaces.HeatExchangerBase PHX(redeclare package ColdFluid = ColdFluid, redeclare package HotFluid = HotFluid) annotation (choicesAllMatching=true, Placement(transformation(extent={{-150,-20},{-110,20}})));
  replaceable PL_Lib.Interfaces.CompressorBase compressor(
    redeclare package Medium = HotFluid,
    pstart_in=100000,
    pstart_out=100000,
    Tdes_in=573.15,
    Tstart_out=573.15) annotation (choicesAllMatching=true, Placement(transformation(extent={{-40,-80},{0,-40}})));

  ThermoPower.Gas.SourcePressure sourceP_BAin(
    redeclare package Medium = HotFluid,
    use_in_T=true,
    use_in_p0=true) annotation (Placement(transformation(
        origin={-210,-40},
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
  ThermoPower.Gas.SinkPressure sinkP_RA_PHXout(redeclare package Medium = ColdFluid, use_in_p0=true) annotation (Placement(transformation(
        origin={-50,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
protected
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(visible=true, transformation(
        origin={50,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{-8,-60},{40,-60}}));
  connect(compressor.outlet, sinkP_PACKout.flange) annotation (Line(points={{-4,-44},{40,-44},{40,-20},{60,-20}}, color={159,159,223}));
  connect(sourceMassFlow_RA_PHXin.flange, PHX.infl_1) annotation (Line(points={{-200,40},{-160,40},{-160,10},{-150,10}}, color={159,159,223}));
  connect(sourceP_BAin.flange, PHX.infl_2) annotation (Line(points={{-200,-40},{-160,-40},{-160,-10},{-150,-10}}, color={159,159,223}));
  connect(PHX.outfl_1, sinkP_RA_PHXout.flange) annotation (Line(points={{-110,10},{-100,10},{-100,40},{-60,40}}, color={159,159,223}));
  connect(PHX.outfl_2, compressor.inlet) annotation (Line(points={{-110,-10},{-100,-10},{-100,-44},{-36,-44}}, color={159,159,223}));
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}}), graphics={Text(
          origin={-210,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left),Text(
          origin={-210,20},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left)}));
end PACK_simple_template;
