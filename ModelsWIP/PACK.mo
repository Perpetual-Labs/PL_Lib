within PL_Lib.ModelsWIP;

model PACK "Simple plant model with HRB"
  extends Modelica.Icons.Example;
  replaceable package GasMedium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  
  inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
    Placement(visible = true, transformation(extent = {{180, 180}, {200, 200}}, rotation = 0)));
  parameter Modelica.SIunits.Time Ts = 4 "Temperature sensor time constant";
  // Compressor maps:
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  // Turbine maps:
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  ThermoPower.Gas.SinkPressure sinkPressure_BA(redeclare package Medium = GasMedium, T = 298.15) annotation(
    Placement(visible = true, transformation(extent = {{180, -10}, {200, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(extent = {{-130, -6}, {-110, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_MHXout(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {150, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Compressor Compressor(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 244.4, Tstart_in = 244.4, Tstart_out = 691.4, pstart_in = 0.343e5, pstart_out = 8.3e5, tableEta = tableEtaC, tablePR = tablePR, tablePhic = tablePhicC) annotation(
    Placement(visible = true, transformation(extent = {{-60, -130}, {-20, -90}}, rotation = 0)));
  ThermoPower.Gas.Turbine Turbine(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 691.4, Tstart_out = 298, pstart_in = 8.3e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation(
    Placement(visible = true, transformation(extent = {{60, -130}, {100, -90}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure1(redeclare package Medium = GasMedium, T = 298.15) annotation(
    Placement(visible = true, transformation(extent = {{124, -104}, {144, -84}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed ConstantSpeed1(useSupport = false, w_fixed = 523.3) annotation(
    Placement(visible = true, transformation(extent = {{-94, -120}, {-74, -100}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_MHXin(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_BA_PHXout(redeclare package Medium = GasMedium, R = 100) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure(redeclare package Medium = GasMedium, T = 244.4, p0 = 0.35e5) annotation(
    Placement(visible = true, transformation(extent = {{-122, -104}, {-102, -84}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.8) annotation(
    Placement(visible = true, transformation(origin = {20, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = GasMedium, R = 1000) annotation(
    Placement(visible = true, transformation(origin = {20, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //initial equation
  //  Inertia1.w = 523.3;
  ThermoPower.Gas.SourcePressure sourcePressure_BA(redeclare package Medium = GasMedium, T = 473.15, p0 = 200000) annotation(
    Placement(visible = true, transformation(origin = {-150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.HeatExchanger PHX(redeclare package GasMedium1 = GasMedium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom = 7800, redeclare package GasMedium2 = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourcePressure_RA(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-150, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-120, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_RA_PHXout(redeclare package Medium = GasMedium, R = 100)  annotation(
    Placement(visible = true, transformation(origin = {0, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.HeatExchanger MHX(redeclare package GasMedium1 = GasMedium, Dext = 0.012, Dint = 0.01, Lb = 2, Lt = 3, Nr = 10, Nt = 250, Sb = 8, StaticGasBalances = false, cm = 650, rhom = 7800, redeclare package GasMedium2 = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_MHXout(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {150, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_MHXin(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure_RA(redeclare package Medium = GasMedium) annotation(
    Placement(visible = true, transformation(origin = {190, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Turbine.outlet, sinkPressure1.flange) annotation(
    Line(points = {{96, -94}, {124, -94}}, color = {159, 159, 223}, thickness = 0.5));
  connect(ConstantSpeed1.flange, Compressor.shaft_a) annotation(
    Line(points = {{-74, -110}, {-52, -110}}, thickness = 0.5));
  connect(sensT_BA_PHXout.outlet, pipe_BA_PHXout.inlet) annotation(
    Line(points = {{-24, 0}, {-10, 0}}, color = {159, 159, 223}));
  connect(sourcePressure.flange, Compressor.inlet) annotation(
    Line(points = {{-102, -94}, {-56, -94}}, color = {159, 159, 223}, thickness = 0.5));
  connect(Compressor.shaft_b, inertia.flange_a) annotation(
    Line(points = {{-28, -110}, {10, -110}}, thickness = 0.5));
  connect(inertia.flange_b, Turbine.shaft_a) annotation(
    Line(points = {{30, -110}, {68, -110}}, thickness = 0.5));
  connect(Compressor.outlet, pressDropLin2.inlet) annotation(
    Line(points = {{-24, -94}, {-23, -94}, {-23, -80}, {10, -80}}, color = {159, 159, 223}, thickness = 0.5));
  connect(pressDropLin2.outlet, Turbine.inlet) annotation(
    Line(points = {{30, -80}, {65, -80}, {65, -94}, {64, -94}}, color = {159, 159, 223}, thickness = 0.5));
  connect(sensT_BA_MHXout.outlet, sinkPressure_BA.flange) annotation(
    Line(points = {{156, 0}, {180, 0}}, color = {159, 159, 223}));
  connect(sourcePressure_BA.flange, sensT_BA_PHXin.inlet) annotation(
    Line(points = {{-140, 0}, {-126, 0}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXin.outlet, PHX.gasIn) annotation(
    Line(points = {{-114, 0}, {-100, 0}}, color = {159, 159, 223}));
  connect(PHX.gasOut, sensT_BA_PHXout.inlet) annotation(
    Line(points = {{-60, 0}, {-36, 0}}, color = {159, 159, 223}));
  connect(sourcePressure_RA.flange, sensT_RA_PHXin.inlet) annotation(
    Line(points = {{-140, 40}, {-126, 40}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, PHX.gas2In) annotation(
    Line(points = {{-114, 40}, {-80, 40}, {-80, 20}}, color = {159, 159, 223}));
  connect(PHX.gas2Out, sensT_RA_PHXout.inlet) annotation(
    Line(points = {{-80, -20}, {-80, -34}, {-36, -34}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXout.outlet, pipe_RA_PHXout.inlet) annotation(
    Line(points = {{-24, -34}, {-10, -34}}, color = {159, 159, 223}));
  connect(sensT_BA_MHXin.outlet, MHX.gasIn) annotation(
    Line(points = {{56, 0}, {80, 0}}, color = {159, 159, 223}));
  connect(MHX.gasOut, sensT_BA_MHXout.inlet) annotation(
    Line(points = {{120, 0}, {144, 0}}, color = {159, 159, 223}));
  connect(MHX.gas2Out, sensT_RA_MHXout.inlet) annotation(
    Line(points = {{100, -20}, {100, -34}, {144, -34}}, color = {159, 159, 223}));
  connect(pipe_RA_PHXout.outlet, sensT_RA_MHXin.inlet) annotation(
    Line(points = {{10, -34}, {44, -34}}, color = {159, 159, 223}));
  connect(sensT_RA_MHXin.outlet, MHX.gas2In) annotation(
    Line(points = {{56, -34}, {70, -34}, {70, 30}, {100, 30}, {100, 20}}, color = {159, 159, 223}));
  connect(pipe_BA_PHXout.outlet, sensT_BA_MHXin.inlet) annotation(
    Line(points = {{10, 0}, {44, 0}}, color = {159, 159, 223}));
  connect(sensT_RA_MHXout.outlet, sinkPressure_RA.flange) annotation(
    Line(points = {{156, -34}, {180, -34}}, color = {159, 159, 223}));
protected
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {200, 200}}, initialScale = 0.1), graphics),
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
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end PACK;
