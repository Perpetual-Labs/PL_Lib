within PL_Lib.Experiments;
model Evaluation_supplied
  extends Modelica.Icons.Example;
  extends ecs_case_study_mo.Verification(S=if time <=50 then 1 else 2, redeclare Configurations.AirConditioner_supplied airConditioner(redeclare package acMediumCold = ecsMediumCold, redeclare package acMediumHot = ecsMediumHot));

  Boolean acMassConstraint=acMass <= acMassLimit;
  Boolean cruiseAmbientTempConstraint=ambientTemp == cruiseAmbientTempLimit;
  Boolean cruiseAmbientPressConstraint=ambientPress == cruiseAmbientPressLimit;
  Boolean taxiAmbientTempConstraint=ambientTemp == taxiAmbientTempLimit;
  Boolean taxiAmbientPressConstraint=ambientPress == taxiAmbientPressLimit;
  Boolean cabinTempLowerLimitConstraint=cabinTemp >= cabinTempLowerLimit;
  Boolean cabinTempUpperLimitConstraint=cabinTemp <= cabinTempUpperLimit;
  Boolean cabinPressLowerLimitConstraint=cabinPress >= cabinPressLowerLimit;
  Boolean cabinPressUpperLimitConstraint=cabinPress <= cabinPressUpperLimit;
  Boolean acMassRequirement=acMassConstraint "R.1";
  Boolean acPressRequirement=if taxiConditions or cruiseConditions then cabinPressLowerLimitConstraint and cabinPressUpperLimitConstraint else false "R.2";
  Boolean acTempRequirement=if taxiConditions or cruiseConditions then cabinTempLowerLimitConstraint and cabinTempUpperLimitConstraint else false "R.3";
  Boolean acAtmosChangeRateRequirement=true "R.4";

  parameter Real mass_flow = 0.35;

  inner ThermoPower.System system annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression inputT_cold_in(y=ambientTemp) annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.RealExpression inputP_hot_in(y=bleedPress) annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.RealExpression inputT_hot_in(y=bleedTemp) annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.RealExpression inputP_cold_in(y=ambientPress) annotation (Placement(transformation(extent={{50,60},{70,80}})));
  ThermoPower.Gas.SourcePressure sourcePressure_hot(
    redeclare package Medium = ecsMediumHot,
    use_in_p0=true,
    use_in_T=true) annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_cold(
    redeclare package Medium = ecsMediumCold,
    w0=mass_flow,
    use_in_T=true) annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  ThermoPower.Gas.SinkPressure sinkPressure_cold(redeclare package Medium = ecsMediumCold, use_in_p0=true) annotation (Placement(transformation(extent={{80,40},{100,60}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_cold1(
    redeclare package Medium = ecsMediumCold,
    use_in_T=true,
    w0=mass_flow) annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  ThermoPower.Gas.SinkPressure sinkPressure_cold1(redeclare package Medium = ecsMediumCold, use_in_p0=true) annotation (Placement(transformation(extent={{80,10},{100,30}})));
  ThermoPower.Gas.SensP sensP(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{120,-56},{140,-36}})));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = ecsMediumHot) annotation (Placement(visible=true, transformation(
        origin={150,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.Mixer mixer(
    redeclare package Medium = ecsMediumHot,
    V=0.01,
    pstart=101325,
    Tstart=295.15) annotation (Placement(visible=true, transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Continuous.LimPID PID(
    Td= 0.2,
    Ti= 9.5,
    k=1e-3,
    limitsAtInit=true,
    yMax=mass_flow,
    yMin=0) annotation (Placement(visible=true, transformation(
        origin={120,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_BA_MIXin(
    redeclare package Medium = ecsMediumHot,
    use_in_T=true,
    use_in_w0=true) annotation (Placement(visible=true, transformation(
        origin={50,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder actuator(T=1, y_start=0) annotation (Placement(transformation(extent={{140,-30},{160,-10}})));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Modelica.Blocks.Sources.RealExpression inputCabinTemp(y=(cabinTempLowerLimit + cabinTempUpperLimit)/2) annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
equation
  acMass = airConditioner.acMass;
  cabinPress = sensP.p;
  cabinTemp = sensT.T;
  cabinAtmosphereMass = 0;
  cabinAtmosphereChangeRate = 0;
  connect(sourcePressure_hot.flange, bleedAtmoshpere) annotation (Line(points={{-70,-50},{-50,-50}}, color={159,159,223}));
  connect(inputP_hot_in.y, sourcePressure_hot.in_p0) annotation (Line(points={{-79,-26},{-72,-26},{-72,-32},{-86,-32},{-86,-43.6}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourcePressure_hot.in_T) annotation (Line(points={{-79,-10},{-66,-10},{-66,-36},{-80,-36},{-80,-41}}, color={0,0,127}));
  connect(ambientAtomsphere_out, sinkPressure_cold.flange) annotation (Line(points={{50,50},{80,50}}, color={0,0,0}));
  connect(sourceMassFlow_cold.flange, ambientAtmosphere_in) annotation (Line(points={{-70,50},{-50,50}}, color={159,159,223}));
  connect(inputT_cold_in.y, sourceMassFlow_cold.in_T) annotation (Line(points={{-79,70},{-70,70},{-70,62},{-80,62},{-80,55}}, color={0,0,127}));
  connect(inputP_cold_in.y, sinkPressure_cold.in_p0) annotation (Line(points={{71,70},{83.55,70},{83.55,55.95}}, color={0,0,127}));
  connect(inputT_cold_in.y, sourceMassFlow_cold1.in_T) annotation (Line(points={{-79,70},{-70,70},{-70,62},{-92,62},{-92,34},{-80,34},{-80,25}}, color={0,0,127}));
  connect(cabinAtmosphere, cabinAtmosphere) annotation (Line(points={{50,-50},{50,-50}}));
  connect(inputP_cold_in.y, sinkPressure_cold1.in_p0) annotation (Line(points={{71,70},{104,70},{104,34},{83.55,34},{83.55,25.95}}, color={0,0,127}));
  connect(airConditioner.acInletCold1, sourceMassFlow_cold1.flange) annotation (Line(points={{10,20},{10,32},{-40,32},{-40,20},{-70,20}}, color={0,0,0}));
  connect(airConditioner.acOutletCold1, sinkPressure_cold1.flange) annotation (Line(points={{-10,20},{-10,26},{60,26},{60,20},{80,20}}, color={0,0,0}));
  connect(sourceMassFlow_BA_MIXin.flange, mixer.in1) annotation (Line(points={{60,-30},{72,-30},{72,-44}}, color={159,159,223}));
  connect(PID.y, actuator.u) annotation (Line(points={{131,-20},{138,-20}}, color={0,0,127}));
  connect(actuator.y, sourceMassFlow_BA_MIXin.in_w0) annotation (Line(points={{161,-20},{164,-20},{164,-4},{44,-4},{44,-25}}, color={0,0,127}));
  connect(mixer.out, sensT.inlet) annotation (Line(points={{90,-50},{104,-50}}, color={159,159,223}));
  connect(sensT.T, PID.u_m) annotation (Line(points={{117,-40},{120,-40},{120,-32}}, color={0,0,127}));
  connect(PID.u_s, inputCabinTemp.y) annotation (Line(points={{108,-20},{101,-20}}, color={0,0,127}));
  connect(sensT.outlet, sensP.flange) annotation (Line(points={{116,-50},{130,-50}}, color={159,159,223}));
  connect(sensP.flange, sinkPressure.flange) annotation (Line(points={{130,-50},{140,-50}}, color={159,159,223}));
  connect(cabinAtmosphere, mixer.in2) annotation (Line(points={{50,-50},{66,-50},{66,-56},{72,-56}}, color={0,0,0}));
  connect(inputT_hot_in.y, sourceMassFlow_BA_MIXin.in_T) annotation (Line(points={{-79,-10},{-40,-10},{-40,-34},{36,-34},{36,-18},{50,-18},{50,-25}}, color={0,0,127}));
  annotation (experiment(
      StartTime=0,
      StopTime=100,
      Tolerance=1e-06,
      Interval=0.2), Diagram(coordinateSystem(extent={{-120,-100},{180,120}})));
end Evaluation_supplied;
