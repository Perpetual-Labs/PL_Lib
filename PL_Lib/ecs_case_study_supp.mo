within PL_Lib;
package ecs_case_study_supp
  model HeatExchanger_supplied
    extends PL_Lib.ecs_case_study_mo.HeatExchanger;
    PL_Lib.Components.HX_1DCoFlow heatExchanger(wnom_c = 0.025, wnom_h = 0.025, redeclare package ColdFluid = heatExchangerMediumCold, redeclare package HotFluid = heatExchangerMediumHot) annotation (
      choicesAllMatching = true,
      Placement(transformation(extent = {{-40, -40}, {40, 40}})));
  equation
    connect(HeatExchangerInletCold, heatExchanger.infl_1) annotation (
      Line(points = {{-102, 50}, {-60, 50}, {-60, 20}, {-40, 20}}, color = {0, 0, 0}));
    connect(HeatExchangerInletHot, heatExchanger.infl_2) annotation (
      Line(points = {{-100, -50}, {-60, -50}, {-60, -20}, {-40, -20}}, color = {0, 0, 0}));
    connect(HeatExchangerOutletHot, heatExchanger.outfl_2) annotation (
      Line(points = {{100, -50}, {60, -50}, {60, -20}, {40, -20}}, color = {0, 0, 0}));
    connect(HeatExchangerOutletCold, heatExchanger.outfl_1) annotation (
      Line(points = {{100, 50}, {80, 50}, {80, 20}, {40, 20}}, color = {0, 0, 0}));
    annotation (
      Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {28, 108, 200}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, radius = 20), Text(extent = {{-100, 100}, {100, -100}}, textColor = {28, 108, 200}, textString = "Heat
Exchanger
Supplied")}));
  end HeatExchanger_supplied;

  model Compressor_supplied
    extends PL_Lib.ecs_case_study_mo.Compressor;
    PL_Lib.Components.Compressor_noMaps compressor(redeclare package Medium = compressorMedium, pstart_in = 100000, pstart_out = 100000, Tdes_in = 573.15, Tstart_out = 573.15) annotation (
      choicesAllMatching = true,
      Placement(transformation(extent = {{-60, -60}, {20, 20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J_shaft, w(start = w0, fixed = false)) annotation (
      Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  protected
    parameter Modelica.SIunits.Inertia J_shaft = 200;
    parameter Modelica.SIunits.AngularVelocity w0 = 523.3;
  equation
    connect(compressor.shaft_b, inertia.flange_a) annotation (
      Line(points = {{4, -20}, {40, -20}}, color = {0, 0, 0}));
    connect(CompressorInlet, compressor.inlet) annotation (
      Line(points = {{-100, 50}, {-52, 50}, {-52, 12}}, color = {0, 0, 0}));
    connect(compressor.outlet, CompressorOutlet) annotation (
      Line(points = {{12, 12}, {12, 50}, {100, 50}}, color = {159, 159, 223}));
    annotation (
      Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {28, 108, 200}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, radius = 20), Text(extent = {{-90, 100}, {110, -100}}, textColor = {28, 108, 200}, textString = "Compressor
Supplied")}));
  end Compressor_supplied;

  model AirConditioner_supplied
    extends PL_Lib.ecs_case_study_mo.AirConditioner(
                                             redeclare ecs_case_study_supp.HeatExchanger_supplied heatExchanger(heatExchangerMass=51),   redeclare ecs_case_study_supp.Compressor_supplied compressor(compressorMass=47));
    ThermoPower.Gas.SensT1 sensT(redeclare package Medium = acMediumHot) annotation (
      Placement(transformation(extent = {{70, -40}, {90, -20}})));
    ThermoPower.Gas.SensP sensP(redeclare package Medium = acMediumHot) annotation (
      Placement(transformation(extent = {{50, -40}, {70, -20}})));
  equation
    acMass = heatExchanger.heatExchangerMass + compressor.compressorMass;
    connect(acOutletHot, sensT.flange) annotation (
      Line(points = {{100, -50}, {80, -50}, {80, -34}}, color = {0, 0, 0}));
    connect(acOutletHot, sensP.flange) annotation (
      Line(points = {{100, -50}, {60, -50}, {60, -34}}, color = {0, 0, 0}));
    annotation (
      Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {28, 108, 200}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-100, 100}, {100, -100}}, textColor = {28, 108, 200}, textString = "AC
Supplied")}));
  end AirConditioner_supplied;

  model Evaluation
    extends Modelica.Icons.Example;
    extends PL_Lib.ecs_case_study_mo.Verification(
                                           redeclare ecs_case_study_supp.AirConditioner_supplied airConditioner(redeclare package acMediumCold = ecsMediumCold, redeclare package acMediumHot = ecsMediumHot));
    // Constraints
  protected
    Boolean acMassConstraint = acMass <= acMassLimit;
    Boolean cruiseAmbientTempConstraint = ambientTemp == cruiseAmbientTempLimit;
    Boolean cruiseAmbientPressConstraint = ambientPress == cruiseAmbientPressLimit;
    Boolean taxiAmbientTempConstraint = ambientTemp == taxiAmbientTempLimit;
    Boolean taxiAmbientPressConstraint = ambientPress == taxiAmbientPressLimit;
    Boolean cabinTempLowerLimitConstraint = cabinTemp >= cabinTempLowerLimit;
    Boolean cabinTempUpperLimitConstraint = cabinTemp <= cabinTempUpperLimit;
    Boolean cabinPressLowerLimitConstraint = cabinPress >= cabinPressLowerLimit;
    Boolean cabinPressUpperLimitConstraint = cabinPress <= cabinPressUpperLimit;
    // Requirements
    Boolean acMassRequirement = acMassConstraint "R.1";
    Boolean acPressRequirement = if taxiConditions or cruiseConditions then cabinPressLowerLimitConstraint and cabinPressUpperLimitConstraint else false "R.2";
    Boolean acTempRequirement = if taxiConditions or cruiseConditions then cabinTempLowerLimitConstraint and cabinTempUpperLimitConstraint else false "R.3";
    Boolean acAtmosChangeRateRequirement = true "R.4";
    ThermoPower.Gas.SensT1 sensT(redeclare package Medium = ecsMediumHot) annotation (
      Placement(transformation(extent = {{70, -30}, {90, -10}})));
    ThermoPower.Gas.SensP sensP(redeclare package Medium = ecsMediumHot) annotation (
      Placement(transformation(extent = {{50, -30}, {70, -10}})));
    inner ThermoPower.System system annotation (
      Placement(transformation(extent = {{80, 80}, {100, 100}})));
    ThermoPower.Gas.SourcePressure sourcePressure_hot(redeclare package Medium = ecsMediumHot, use_in_p0 = true, use_in_T = true) annotation (
      Placement(transformation(extent = {{-90, -60}, {-70, -40}})));
    ThermoPower.Gas.SinkMassFlow sinkMassFlow_hot(redeclare package Medium = ecsMediumHot, w0 = 0.025) annotation (
      Placement(transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}})));
    ThermoPower.Gas.SourceMassFlow sourceMassFlow_cold(redeclare package Medium = ecsMediumCold, use_in_T = true) annotation (
      Placement(transformation(extent = {{-90, 40}, {-70, 60}})));
    ThermoPower.Gas.SinkPressure sinkPressure_cold(redeclare package Medium = ecsMediumCold, use_in_p0 = true) annotation (
      Placement(transformation(extent = {{80, 40}, {100, 60}})));
    Modelica.Blocks.Sources.RealExpression inputT_cold_in(y = ambientTemp) annotation (
      Placement(transformation(extent = {{-100, 60}, {-80, 80}})));
    Modelica.Blocks.Sources.RealExpression inputP_hot_in(y = bleedPress) annotation (
      Placement(transformation(extent = {{-100, -36}, {-80, -16}})));
    Modelica.Blocks.Sources.RealExpression inputT_hot_in(y = bleedTemp) annotation (
      Placement(transformation(extent = {{-100, -20}, {-80, 0}})));
    Modelica.Blocks.Sources.RealExpression inputP_cold_in(y = ambientPress) annotation (
      Placement(transformation(extent = {{60, 60}, {80, 80}})));
  equation
    acMass = airConditioner.acMass;
    cabinPress = sensP.p;
    cabinTemp = sensT.T;
    cabinAtmosphereMass = 0;
    cabinAtmosphereChangeRate = 0;
    connect(sourcePressure_hot.flange, bleedAtmoshpere) annotation (
      Line(points = {{-70, -50}, {-50, -50}}, color = {159, 159, 223}));
    connect(inputP_hot_in.y, sourcePressure_hot.in_p0) annotation (
      Line(points = {{-79, -26}, {-72, -26}, {-72, -32}, {-86, -32}, {-86, -43.6}}, color = {0, 0, 127}));
    connect(inputT_hot_in.y, sourcePressure_hot.in_T) annotation (
      Line(points = {{-79, -10}, {-66, -10}, {-66, -36}, {-80, -36}, {-80, -41}}, color = {0, 0, 127}));
    connect(sinkMassFlow_hot.flange, cabinAtmosphere) annotation (
      Line(points = {{80, -50}, {50, -50}}, color = {159, 159, 223}));
    connect(ambientAtomsphere_out, sinkPressure_cold.flange) annotation (
      Line(points = {{50, 50}, {80, 50}}, color = {0, 0, 0}));
    connect(sourceMassFlow_cold.flange, ambientAtmosphere_in) annotation (
      Line(points = {{-70, 50}, {-50, 50}}, color = {159, 159, 223}));
    connect(inputT_cold_in.y, sourceMassFlow_cold.in_T) annotation (
      Line(points = {{-79, 70}, {-70, 70}, {-70, 62}, {-80, 62}, {-80, 55}}, color = {0, 0, 127}));
    connect(inputP_cold_in.y, sinkPressure_cold.in_p0) annotation (
      Line(points = {{81, 70}, {83.55, 70}, {83.55, 55.95}}, color = {0, 0, 127}));
    connect(sinkMassFlow_hot.flange, sensT.flange) annotation (
      Line(points = {{80, -50}, {70, -50}, {70, -24}, {80, -24}}, color = {159, 159, 223}));
    connect(sensP.flange, sensT.flange) annotation (
      Line(points = {{60, -24}, {80, -24}}, color = {159, 159, 223}));
    annotation (
      experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
  end Evaluation;
  annotation ();
end ecs_case_study_supp;
