within PL_Lib.ModelsWIP;

model PACK_water_cooled "Simple plant model with HRB"
  replaceable package GasMedium = Modelica.Media.IdealGases.MixtureGases.CombustionAir constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package WaterMedium = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
  
  inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
    Placement(transformation(extent = {{140, 140}, {160, 160}})));
  parameter Modelica.SIunits.Time Ts = 4 "Temperature sensor time constant";
  // Compressor maps:
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  // Turbine maps:
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  
  ThermoPower.Examples.HRB.Models.HeatExchanger PHX(redeclare package GasMedium = GasMedium, redeclare package WaterMedium = WaterMedium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom(displayUnit = "kg/m3") = 7800) annotation(
    Placement(visible = true, transformation(extent = {{-100, -20}, {-60, 20}}, rotation = 0)));
  ThermoPower.Water.SinkPressure SinkP1(redeclare package Medium = WaterMedium, p0 = 100000) annotation(
    Placement(visible = true, transformation(extent = {{200, -44}, {220, -24}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow SourceW2(redeclare package Medium = GasMedium, T = 463, p0 = 200000, use_in_w0 = false, w0 = 10) annotation(
    Placement(visible = true, transformation(extent = {{-162, -10}, {-142, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure SinkP2(redeclare package Medium = GasMedium, T = 300) annotation(
    Placement(visible = true, transformation(extent = {{200, -10}, {220, 10}}, rotation = 0)));
  ThermoPower.Water.SensT WaterIn(redeclare package Medium = WaterMedium) annotation(
    Placement(visible = true, transformation(extent = {{-130, 40}, {-110, 60}}, rotation = 0)));
  ThermoPower.Water.SensT WaterMid(redeclare package Medium = WaterMedium) annotation(
    Placement(visible = true, transformation(extent = {{-40, -40}, {-20, -20}}, rotation = 0)));
  ThermoPower.Gas.SensT GasIn(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(extent = {{-130, -6}, {-110, 14}}, rotation = 0)));
  ThermoPower.Water.SourcePressure SourceP1(redeclare package Medium = WaterMedium, T = 298.15, p0 = 500000) annotation(
    Placement(visible = true, transformation(extent = {{-160, 36}, {-140, 56}}, rotation = 0)));
  ThermoPower.Examples.HRB.Models.HeatExchanger MHX(redeclare package GasMedium = GasMedium, redeclare package WaterMedium = WaterMedium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom(displayUnit = "kg/m3") = 7800) annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Water.SensT WaterOut(redeclare package Medium = WaterMedium) annotation(
    Placement(visible = true, transformation(origin = {170, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT GasPHXOut(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-36, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT GasMHXOut(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {170, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Compressor Compressor(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 244.4, Tstart_in = 244.4, Tstart_out = 691.4, pstart_in = 0.343e5, pstart_out = 8.3e5, tableEta = tableEtaC, tablePR = tablePR, tablePhic = tablePhicC) annotation(
    Placement(visible = true, transformation(extent = {{20, -80}, {60, -40}}, rotation = 0)));
  ThermoPower.Gas.Turbine Turbine1(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation(
    Placement(visible = true, transformation(extent = {{60, -160}, {100, -120}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = GasMedium, T = 883, p0 = 1.52e5) annotation(
    Placement(visible = true, transformation(extent = {{140, -134}, {160, -114}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(J = 10000) annotation(
    Placement(visible = true, transformation(extent = {{110, -150}, {130, -130}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure1(redeclare package Medium = GasMedium, T = 1270, p0 = 7.85e5) annotation(
    Placement(visible = true, transformation(extent = {{20, -134}, {40, -114}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed ConstantSpeed1(useSupport = false, w_fixed = 523.3) annotation(
    Placement(visible = true, transformation(extent = {{-10, -70}, {10, -50}}, rotation = 0)));
  ThermoPower.Gas.SensT GasMHXIn(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {80, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  Inertia1.w = 523.3;
equation
  connect(WaterMid.inlet, PHX.waterOut) annotation(
    Line(points = {{-36, -34}, {-80, -34}, {-80, -20}}, color = {0, 0, 255}, thickness = 0.5));
  connect(PHX.gasIn, GasIn.outlet) annotation(
    Line(points = {{-100, 0}, {-114, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(PHX.waterIn, WaterIn.outlet) annotation(
    Line(points = {{-80, 20}, {-80, 46}, {-114, 46}}, color = {0, 0, 255}, thickness = 0.5));
  connect(SourceP1.flange, WaterIn.inlet) annotation(
    Line(points = {{-140, 46}, {-126, 46}}, color = {0, 0, 255}, thickness = 0.5));
  connect(WaterOut.outlet, SinkP1.flange) annotation(
    Line(points = {{176, -34}, {200, -34}}, color = {0, 0, 255}));
  connect(WaterMid.outlet, MHX.waterIn) annotation(
    Line(points = {{-24, -34}, {-10, -34}, {-10, 40}, {120, 40}, {120, 20}}, color = {0, 0, 255}));
  connect(MHX.waterOut, WaterOut.inlet) annotation(
    Line(points = {{120, -20}, {120, -34}, {164, -34}}, color = {0, 0, 255}));
  connect(PHX.gasOut, GasPHXOut.inlet) annotation(
    Line(points = {{-60, 0}, {-42, 0}}, color = {159, 159, 223}));
  connect(MHX.gasOut, GasMHXOut.inlet) annotation(
    Line(points = {{140, 0}, {164, 0}}, color = {159, 159, 223}));
  connect(GasMHXOut.outlet, SinkP2.flange) annotation(
    Line(points = {{176, 0}, {200, 0}}, color = {159, 159, 223}));
  connect(Turbine1.shaft_b, Inertia1.flange_a) annotation(
    Line(points = {{92, -140}, {96, -140}, {96, -140}, {110, -140}}, thickness = 0.5));
  connect(Turbine1.outlet, sinkPressure1.flange) annotation(
    Line(points = {{96, -124}, {140, -124}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sourcePressure1.flange, Turbine1.inlet) annotation(
    Line(points = {{40, -124}, {64, -124}}, color = {159, 159, 223}, thickness = 0.5));
  connect(ConstantSpeed1.flange, Compressor.shaft_a) annotation(
    Line(points = {{10, -60}, {10, -60}, {14, -60.2}, {28, -60}}, thickness = 0.5));
  connect(Compressor.outlet, GasMHXIn.inlet) annotation(
    Line(points = {{56, -44}, {56, 0}, {74, 0}}, color = {159, 159, 223}));
  connect(GasMHXIn.outlet, MHX.gasIn) annotation(
    Line(points = {{86, 0}, {100, 0}}, color = {159, 159, 223}));
  connect(SourceW2.flange, GasIn.inlet) annotation(
    Line(points = {{-142, 0}, {-126, 0}}, color = {159, 159, 223}));
  connect(GasPHXOut.outlet, Compressor.inlet) annotation(
    Line(points = {{-30, 0}, {24, 0}, {24, -44}}, color = {159, 159, 223}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}, initialScale = 0.1), graphics),
    Documentation(revisions = "<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>
          ", info = "<html>
Very simple plant model, providing boundary conditions to the <tt>HRB</tt> model.
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1)));
end PACK_water_cooled;
