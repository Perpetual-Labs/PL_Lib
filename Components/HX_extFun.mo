within PL_Lib.Components;

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
  hxP.hxSignal hxSignal annotation(
    Placement(visible = true, transformation(origin = {0, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  hxSignal.tHot = BAin_T;
  hxSignal.tCold = RAin_T;
  
  hxSignal.mRateHot = BAin_mdot;
  hxSignal.mRateCold = RAin_mdot;
  
  hxSignal.densityHot = BAin_d;
  hxSignal.densityCold = RAin_d;
  
  hxSignal.pressureCold = RAin_p;
  hxSignal.pressureHot	= BAin_p;
  
annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 120}, {100, -120}}), Text(extent = {{-80, 80}, {80, -80}}, textString = "Ext. Code")}));
end HX_extFun;
