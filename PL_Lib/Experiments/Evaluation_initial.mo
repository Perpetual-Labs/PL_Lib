within PL_Lib.Experiments;
model Evaluation_initial
  extends Modelica.Icons.Example;
  extends ecs_case_study_mo.Verification(S=if time <=50 then 1 else 2, redeclare Configurations.AirConditioner_initial  airConditioner(redeclare package acMediumCold = ecsMediumCold, redeclare package acMediumHot = ecsMediumHot));
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
  inner ThermoPower.System system annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  ThermoPower.Gas.SourcePressure sourcePressure_hot(
    redeclare package Medium = ecsMediumHot,
    use_in_p0=true,
    use_in_T=true) annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  ThermoPower.Gas.SinkMassFlow sinkMassFlow_hot(redeclare package Medium = ecsMediumHot, w0=0.025) annotation (Placement(transformation(origin={110,-50},extent={{-10,-10},{10,10}})));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow_cold(redeclare package Medium = ecsMediumCold,
    w0=0.025,                                                                                  use_in_T=true) annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  ThermoPower.Gas.SinkPressure sinkPressure_cold(redeclare package Medium = ecsMediumCold, use_in_p0=true) annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Sources.RealExpression inputT_cold_in(y=ambientTemp) annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.RealExpression inputP_hot_in(y=bleedPress) annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.RealExpression inputT_hot_in(y=bleedTemp) annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.RealExpression inputP_cold_in(y=ambientPress) annotation (Placement(transformation(extent={{50,60},{70,80}})));
  ThermoPower.Gas.SensP sensP(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{80,-56},{100,-36}})));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{60,-56},{80,-36}})));
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
  connect(cabinAtmosphere, cabinAtmosphere) annotation (Line(points={{50,-50},{50,-50}}));
  connect(cabinAtmosphere, sensT.inlet) annotation (Line(points={{50,-50},{64,-50}}, color={0,0,0}));
  connect(sensT.outlet, sensP.flange) annotation (Line(points={{76,-50},{90,-50}}, color={159,159,223}));
  connect(sinkMassFlow_hot.flange, sensP.flange) annotation (Line(points={{100,-50},{90,-50}}, color={159,159,223}));
  annotation (experiment(
      StartTime=0,
      StopTime=100,
      Tolerance=1e-06,
      Interval=0.2), Diagram(coordinateSystem(extent={{-120,-100},{140,120}})));
end Evaluation_initial;
