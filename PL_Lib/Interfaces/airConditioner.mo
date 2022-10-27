within PL_Lib.Interfaces;
partial model airConditioner
  ThermoPower.Gas.FlangeA acRamAirInlet annotation (Placement(
      visible=true,
      transformation(
        origin={-100,50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-100,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.FlangeA acBleedAirInlet annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.FlangeB acBleedAirOutlet annotation (Placement(
      visible=true,
      transformation(
        origin={100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={100,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable PL_Lib.Interfaces.HeatExchangerBase heatExchanger annotation (Placement(visible=true, transformation(
        origin={-34,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  replaceable PL_Lib.Interfaces.CompressorBase compressor annotation (Placement(visible=true, transformation(
        origin={38,-66},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  ThermoPower.Gas.SinkPressure sinkPressure annotation (Placement(visible=true, transformation(
        origin={70,54},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(heatExchanger.infl_1, acRamAirInlet) annotation (Line(points={{-54,10},{-70,10},{-70,50},{-100,50}}, color={159,159,223}));
  connect(acBleedAirInlet, heatExchanger.infl_2) annotation (Line(points={{-100,-50},{-72,-50},{-72,-10},{-54,-10}}, color={159,159,223}));
  connect(compressor.outlet, acBleedAirOutlet) annotation (Line(points={{54,-50},{100,-50}}, color={159,159,223}));
  connect(heatExchanger.outfl_2, compressor.inlet) annotation (Line(points={{-14,-10},{1,-10},{1,-50},{22,-50}}, color={159,159,223}));
  connect(heatExchanger.outfl_1, sinkPressure.flange) annotation (Line(points={{-14,10},{14,10},{14,54},{60,54}}, color={159,159,223}));
end airConditioner;
