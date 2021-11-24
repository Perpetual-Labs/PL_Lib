within PL_Lib.Verifications;
model ECS_CabinTempVerification
  extends Experiments.ECS_TakeOffTest;
  extends PL_Lib.Icons.VerificationScenario_icon;

//   inner Modelica_Requirements.Verify.PrintViolations printViolations(
//     printSatisfied=true,
//     printUntested=true,
//     printViolated=true) annotation (Placement(visible=true, transformation(extent={{50,80},{70,100}}, rotation=0)));
//   Modelica_Requirements.Verify.BooleanRequirement R_TCabin(text="In the cabin area, the temperature increase should not exceed 3°C per hour.") annotation (Placement(visible=true, transformation(extent={{20,-100},{100,-80}}, rotation=0)));
//   Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease maxIncrease(upperLimit=3, window=3600) annotation (Placement(visible=true, transformation(extent={{-20,-100},{0,-80}}, rotation=0)));
//   Modelica.Blocks.Sources.RealExpression realExpression(y=DataLogger.T.PACKout_hot) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
equation
//   connect(maxIncrease.y, R_TCabin.u) annotation (Line(points={{1,-90},{17.3333,-90}}, color={255,0,255}));
//   connect(realExpression.y, maxIncrease.u) annotation (Line(points={{-39,-90},{-22,-90}}, color={0,0,127}));
end ECS_CabinTempVerification;
