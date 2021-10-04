within PL_Lib.Utilities;

model HX_extFun
  Modelica.Blocks.Interfaces.RealInput BAin_T annotation(
    Placement(visible = true, transformation(origin = {-100, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BAin_p annotation(
    Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BAin_mdot annotation(
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BAin_d annotation(
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput RAin_T annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput RAin_p annotation(
    Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput RAin_mdot annotation(
    Placement(visible = true, transformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput RAin_d annotation(
    Placement(visible = true, transformation(origin = {-100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealOutput Thot_out annotation(
    Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Tcold_out annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Phot_out annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pcold_out annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real temperatures[2];
  Real pressures[2];
equation
//(temperatures, pressures) = hx(tCold , tHot, mRateCold, mRateHot, pressureCold, pressureHot, densityCold, densityHot);
  (temperatures, pressures) = hx(RAin_T, BAin_T, RAin_mdot, BAin_mdot, RAin_p, BAin_p, RAin_d, BAin_d);
  
  Thot_out = temperatures[1];
  Tcold_out = temperatures[2];
  Phot_out = pressures[1];
  Pcold_out = pressures[2];
  annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 120}, {100, -120}}), Text(extent = {{-80, 80}, {80, -80}}, textString = "Ext. Code")}));
end HX_extFun;
