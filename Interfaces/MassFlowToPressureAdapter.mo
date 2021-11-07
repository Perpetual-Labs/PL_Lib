within PL_Lib.Interfaces;
model MassFlowToPressureAdapter
  extends PL_Lib.Icons.AdapterIcon;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  outer ThermoPower.System system "System wide properties";
  parameter Boolean allowFlowReversal=system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation (Evaluate=true);
  ThermoPower.Gas.FlangeA flange(redeclare package Medium = Medium, m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(
      visible=true,
      transformation(
        origin={-60,0},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensP sensP(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={10,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={-30,4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow(redeclare package Medium = Medium, use_in_w0=true) annotation (Placement(visible=true, transformation(
        origin={70,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PL_Lib.Components.SensD sensD(redeclare package Medium = Medium) annotation (Placement(visible=true, transformation(
        origin={30,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  Modelica.Blocks.Interfaces.RealOutput p(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0) "Pressure in port medium" annotation (Placement(
      visible=true,
      transformation(
        origin={110,70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={30,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput T(
    final quantity="Temperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Temperature in port medium" annotation (Placement(
      visible=true,
      transformation(
        origin={110,90},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput d(
    displayUnit="g/cm3",
    min=0,
    final quantity="Density",
    final unit="kg/m3") annotation (Placement(
      visible=true,
      transformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(extent={{20,0},{40,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput m_dot(
    final quantity="MassFlowRate",
    final unit="kg/s",
    displayUnit="kg/s",
    min=0) "Mass flow rate in port medium" annotation (Placement(
      visible=true,
      transformation(
        origin={110,20},
        extent={{10,-10},{-10,10}},
        rotation=0),
      iconTransformation(
        origin={30,-70},
        extent={{10,-10},{-10,10}},
        rotation=0)));
equation
  connect(flange, sensT.inlet) annotation (Line(points={{-60,0},{-36,0}}, color={159,159,223}));
  connect(sensT.outlet, sinkMassFlow.flange) annotation (Line(points={{-24,0},{60,0}}, color={159,159,223}));
  connect(m_dot, sinkMassFlow.in_w0) annotation (Line(points={{110,20},{64,20},{64,5}}, color={0,0,127}));
  connect(sensT.outlet, sensP.flange) annotation (Line(points={{-24,0},{10,0},{10,60}}, color={159,159,223}));
  connect(sensP.p, p) annotation (Line(points={{17,70},{110,70}}, color={0,0,127}));
  connect(sensT.T, T) annotation (Line(points={{-23,10},{-10,10},{-10,90},{110,90}}, color={0,0,127}));
  connect(sensD.d, d) annotation (Line(points={{37,50},{110,50}}, color={0,0,127}));
  connect(sensT.outlet, sensD.flange) annotation (Line(points={{-24,0},{30,0},{30,40}}, color={159,159,223}));
  annotation (Icon(graphics={
        Text(
          origin={0,70},
          extent={{-20,10},{20,-10}},
          textString="T"),
        Text(
          origin={0,-70},
          extent={{-20,10},{20,-10}},
          textString="w"),
        Text(
          origin={2,40},
          extent={{-20,10},{20,-10}},
          textString="p"),
        Text(
          origin={0,10},
          extent={{-20,10},{20,-10}},
          textString="d")}));
end MassFlowToPressureAdapter;
