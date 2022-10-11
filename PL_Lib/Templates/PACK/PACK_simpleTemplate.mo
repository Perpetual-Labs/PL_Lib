within PL_Lib.Templates.PACK;
partial model PACK_simpleTemplate
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
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_RA_PHXin(
    redeclare package Medium = ColdFluid,
    w0=whex_cold,
    use_in_w0=false,
    use_in_T=true)
                annotation (Placement(visible=true, transformation(
        origin={-210,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkP_PACKout(redeclare package Medium = HotFluid) annotation (Placement(transformation(extent={{40,-20},{60,0}})));
protected
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  connect(sourceMassFlow_RA_PHXin.flange, PHX.infl_1) annotation (Line(points={{-200,40},{-156,40},{-156,10},{-150,10}}, color={159,159,223}));
  connect(sourceP_BAin.flange, PHX.infl_2) annotation (Line(points={{-200,-40},{-156,-40},{-156,-10},{-150,-10}}, color={159,159,223}));
  connect(PHX.outfl_2, compressor.inlet) annotation (Line(points={{-110,-10},{-104,-10},{-104,-44},{-36,-44}}, color={159,159,223}));
  connect(PHX.outfl_1, sinkP_RA_PHXout.flange) annotation (Line(points={{-110,10},{-104,10},{-104,40},{-60,40}}, color={159,159,223}));
  connect(compressor.outlet, sinkP_PACKout.flange) annotation (Line(points={{-4,-44},{20,-44},{20,-10},{40,-10}}, color={159,159,223}));
  connect(p_cold_in, sinkP_RA_PHXout.in_p0) annotation (Line(points={{-300,60},{-242,60},{-242,72},{-56.45,72},{-56.45,45.95}}, color={0,0,127}));
  connect(T_cold_in, sourceMassFlow_RA_PHXin.in_T) annotation (Line(points={{-300,90},{-210,90},{-210,45}}, color={0,0,127}));
  connect(T_hot_in, sourceP_BAin.in_T) annotation (Line(points={{-300,-20},{-210,-20},{-210,-31}}, color={0,0,127}));
  connect(p_hot_in, sourceP_BAin.in_p0) annotation (Line(points={{-300,-50},{-262,-50},{-262,-26},{-216,-26},{-216,-33.6}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-300,-140},{300,140}}), graphics={Text(
          origin={-190,-60},
          lineColor={238,46,47},
          extent={{-30,10},{30,-10}},
          textString="Bleed air (hot side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left), Text(
          origin={-190,20},
          lineColor={28,108,200},
          extent={{-30,10},{30,-10}},
          textString="Ram air (cold side)",
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left)}));
end PACK_simpleTemplate;
