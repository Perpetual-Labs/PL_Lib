within PL_Lib.Interfaces;
partial model HeatExchangerCausal
  Modelica.Blocks.Interfaces.RealInput T_hot_in(
    final quantity="Temperature",
    final unit="K",
    displayUnit="degC",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-30},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_hot_in(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput w_hot_in(
    final quantity="MassFlowRate",
    final unit="kg/s",
    displayUnit="kg/s",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput d_hot_in(
    final quantity="Density",
    final unit="kg/m3",
    displayUnit="g/cm3",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-90},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-120},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput T_cold_in(
    final quantity="Temperature",
    final unit="K",
    displayUnit="degC",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,90},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,120},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_cold_in(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput w_cold_in(
    final quantity="MassFlowRate",
    final unit="kg/s",
    displayUnit="kg/s",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput d_cold_in(
    final quantity="Density",
    final unit="kg/m3",
    displayUnit="g/cm3",
    min=0) annotation (Placement(
      visible=true,
      transformation(
        origin={-100,30},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput T_hot_out(
    final quantity="Temperature",
    final unit="K",
    displayUnit="degC",
    min=0,
    start=300) annotation (Placement(
      visible=true,
      transformation(
        origin={110,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput T_cold_out(
    final quantity="Temperature",
    final unit="K",
    displayUnit="degC",
    min=0,
    start=300) annotation (Placement(
      visible=true,
      transformation(
        origin={110,80},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput p_hot_out(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0,
    start=101325) annotation (Placement(
      visible=true,
      transformation(
        origin={110,-80},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput p_cold_out(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0,
    start=101325) annotation (Placement(
      visible=true,
      transformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  annotation (Icon(coordinateSystem(extent={{-100,-140},{100,140}}), graphics={
        Text(
          origin={-70,120},
          extent={{-30,10},{30,-10}},
          textString="T_cold_in"),
        Text(
          origin={-70,90},
          extent={{-30,10},{30,-10}},
          textString="p_cold_in"),
        Text(
          origin={-70,60},
          extent={{-30,10},{30,-10}},
          textString="w_cold_in"),
        Text(
          origin={-70,30},
          extent={{-30,10},{30,-10}},
          textString="d_cold_in"),
        Text(
          origin={-70,-30},
          extent={{-30,10},{30,-10}},
          textString="T_hot_in"),
        Text(
          origin={-70,-60},
          extent={{-30,10},{30,-10}},
          textString="p_hot_in"),
        Text(
          origin={-70,-90},
          extent={{-30,10},{30,-10}},
          textString="w_hot_in"),
        Text(
          origin={-70,-120},
          extent={{-30,10},{30,-10}},
          textString="d_hot_in"),
        Text(
          origin={70,-90},
          extent={{-30,10},{30,-10}},
          textString="p_hot_out"),
        Text(
          origin={70,-50},
          extent={{-30,10},{30,-10}},
          textString="T_hot_out"),
        Text(
          origin={70,50},
          extent={{-30,10},{30,-10}},
          textString="p_cold_out"),
        Text(
          origin={70,90},
          extent={{-30,10},{30,-10}},
          textString="T_cold_out")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatExchangerCausal;
