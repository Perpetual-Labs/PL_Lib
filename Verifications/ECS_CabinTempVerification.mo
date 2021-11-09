within PL_Lib.Verifications;
model ECS_CabinTempVerification
  extends PL_Lib.Icons.VerificationScenario_icon;
  PL_Lib.Configurations.ECS_TakeOffTest ecs_TakeOffTest annotation (Placement(visible = true, transformation(extent = {{-100, -30}, {-40, 30}}, rotation = 0)));
  inner Modelica_Requirements.Verify.PrintViolations printViolations(printSatisfied = true, printUntested = true, printViolated = true) 
    annotation (Placement(visible = true, transformation(extent = {{80, 80}, {100, 100}}, rotation = 0)));
  Modelica_Requirements.Verify.BooleanRequirement
                                           R_TCabin(text="In the cabin area, the temperature
increase should not exceed 3°C
per hour.") annotation (Placement(visible = true, transformation(extent = {{60, 10}, {140, 30}}, rotation = 0)));
  Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease
                                    maxIncrease(    upperLimit= 3,window= 3600)
    annotation (Placement(visible = true, transformation(extent = {{20, 10}, {40, 30}}, rotation = 0)));
  Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease upperLimit1(upperLimit = 3, window = 600) annotation(
    Placement(visible = true, transformation(extent = {{20, -20}, {40, 0}}, rotation = 0)));
  Modelica_Requirements.Verify.BooleanRequirement R_Tcabin_dummy(text = "Another dummy requirement to test the verification logic.") annotation(
    Placement(visible = true, transformation(extent = {{60, -20}, {140, 0}}, rotation = 0)));
equation
  connect(maxIncrease.y, R_TCabin.u) annotation(
    Line(points = {{41, 20}, {57, 20}}, color = {255, 0, 255}));
  connect(ecs_TakeOffTest.signalBus.T_BA_PACKout, maxIncrease.u) annotation(
    Line(points = {{-40, 0}, {-20, 0}, {-20, 20}, {18, 20}}, color = {0, 0, 127}));
  connect(upperLimit1.y, R_Tcabin_dummy.u) annotation(
    Line(points = {{41, -10}, {56, -10}}, color = {255, 0, 255}));
  connect(ecs_TakeOffTest.signalBus.T_BA_PHXin, upperLimit1.u) annotation(
    Line(points = {{-40, 0}, {-20, 0}, {-20, -10}, {18, -10}}, color = {0, 0, 127}));
  annotation (Diagram(graphics={Text(origin = {60, 40}, lineColor = {0, 140, 72}, extent = {{-40, 10}, {40, -10}}, textString = "Requirements Definitions", textStyle = {TextStyle.Bold}), Text(origin = {-60, 40}, lineColor = {0, 68, 130}, extent = {{-60, 10}, {60, -10}}, textString = "Aircraft configuration to be verified", textStyle = {TextStyle.Bold})}));
end ECS_CabinTempVerification;
