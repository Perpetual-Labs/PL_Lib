within PL_Lib.ModelsWIP;

model TTECCSfree_testing
  TTECCSfree.Machines.Air.CentComp_DL1 centComp_DL1 annotation(
    Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TTECCSfree.Machines.Air.Turbine_DL1 turbine_DL1 annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TTECCSfree.HeatExchangers.AirToAir.AirToAirHX_DL1 airToAirHX_DL1 annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TTECCSfree.HeatExchangers.AirToAir.AirToAirHX_DL1 airToAirHX_DL11 annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner TTECCSfree.System.SystemState systemState(detailLevel = TTECCSfree.Types.DetailLevel.One)  annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TTECCSfree.Valves.Air.AirCheckValve airCheckValve annotation(
    Placement(visible = true, transformation(origin = {-64, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TTECCSfree.Ducting.Air.AirDuct_DL1 duct annotation(
    Placement(visible = true, transformation(origin = {-78, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

end TTECCSfree_testing;
