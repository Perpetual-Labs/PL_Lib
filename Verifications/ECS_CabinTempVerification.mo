within PL_Lib.Verifications;
model ECS_CabinTempVerification
  extends Experiments.ECS_TakeOffTest(redeclare Configurations.ECS_hybridConfig ECS_config);
  extends PL_Lib.Icons.VerificationScenario_icon;
  inner Modelica_Requirements.Verify.PrintViolations printViolations(
    printSatisfied=true,
    printUntested=true,
    printViolated=true) annotation (Placement(visible=true, transformation(extent={{80,80},{100,100}}, rotation=0)));
  Modelica_Requirements.Verify.BooleanRequirement R_TCabin(text="In the cabin area, the temperature increase should not exceed 3°C per hour.") annotation (Placement(visible=true, transformation(extent={{20,-80},{100,-60}}, rotation=0)));
  Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease maxIncrease(upperLimit=3, window=3600) annotation (Placement(visible=true, transformation(extent={{-20,-80},{0,-60}},rotation=0)));
equation
  connect(maxIncrease.y, R_TCabin.u) annotation (Line(points={{1,-70},{17.3333,-70}},
                                                                                   color={255,0,255}));
  annotation (Diagram(graphics={Text(
          origin={20,-50},
          lineColor={0,140,72},
          extent={{-40,10},{40,-10}},
          textString="Requirements Definitions",
          textStyle={TextStyle.Bold})}));
end ECS_CabinTempVerification;
