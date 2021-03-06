within PL_Lib.Models.Obsolete;
model PACK "Simple plant model with HRB"
  extends Modelica.Icons.Example;
  replaceable package GasMedium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation (
    Placement(visible = true, transformation(extent = {{160, 80}, {180, 100}}, rotation = 0)));
  parameter Modelica.SIunits.Time Ts = 4 "Temperature sensor time constant";
  // Compressor maps:
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  // Turbine maps:
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  ThermoPower.Gas.SinkPressure sinkPressure_BA(redeclare package Medium = GasMedium, T = 273.15) annotation (
    Placement(visible = true, transformation(extent = {{180, -64}, {200, -44}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXin(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(extent = {{-150, -6}, {-130, 14}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_PHXout(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {-60, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_MHXout(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {104, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Compressor Compressor(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 244.4, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePR, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(extent = {{-34, -90}, {6, -50}}, rotation = 0)));
  ThermoPower.Gas.Turbine Turbine(redeclare package Medium = GasMedium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 273.15 + 60, Tstart_out = 273.15, pstart_in = 5e5, pstart_out = 101325, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(extent = {{130, -90}, {170, -50}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_BA_MHXin(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {24, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //initial equation
  //  Inertia1.w = 523.3;
  PL_Lib.Components.Obsolete.HeatExchanger PHX(
    redeclare package GasMedium1 = GasMedium,
    redeclare package GasMedium2 = GasMedium,
    Dext=0.012,
    Dint=0.01,
    Lb=2,
    Lt=3,
    Nr=10,
    Nt=250,
    Sb=8,
    StaticGasBalances=false,
    cm=650,
    rhom(displayUnit="kg/m3") = 7800) annotation (Placement(visible=true, transformation(
        origin={-100,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_PHXin(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {-168, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_RA_PHXout(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {-80, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Obsolete.HeatExchanger MHX(
    redeclare package GasMedium1 = GasMedium,
    Dext=0.012,
    Dint=0.01,
    Lb=2,
    Lt=3,
    Nr=10,
    Nt=250,
    Sb=8,
    StaticGasBalances=false,
    cm=650,
    rhom=7800,
    redeclare package GasMedium2 = GasMedium) annotation (Placement(visible=true, transformation(
        origin={64,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  ThermoPower.Gas.SensT sensT_RA_MHXout(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {80, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure_RA_MHXout(redeclare package Medium = GasMedium) annotation (
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_BA_PHXout(redeclare package Medium = GasMedium, R = 100) annotation (
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.FlowSplit flowSplit annotation (
    Placement(visible = true, transformation(origin = {-150, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow annotation (
    Placement(visible = true, transformation(origin = {-190, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1 annotation (
    Placement(visible = true, transformation(origin = {-170, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.8)  annotation (
    Placement(visible = true, transformation(origin = {68, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_RA_MHXin annotation (
    Placement(visible = true, transformation(origin = {-60, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_RA_PHXin annotation (
    Placement(visible = true, transformation(origin = {-122, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure_RA_PHXout annotation (
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pipe_BA_MHXin annotation (
    Placement(visible = true, transformation(origin = {2, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ThermoPower.Gas.PressDropLin pipe_BA_MHXout annotation (
    Placement(visible = true, transformation(origin = {134, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(sensT_BA_PHXin.outlet, PHX.gasIn) annotation (
    Line(points = {{-134, 0}, {-120, 0}}, color = {159, 159, 223}));
  connect(PHX.gasOut, sensT_BA_PHXout.inlet) annotation (
    Line(points = {{-80, 0}, {-66, 0}}, color = {159, 159, 223}));
  connect(PHX.gas2Out, sensT_RA_PHXout.inlet) annotation (
    Line(points = {{-100, -20}, {-100, -40}, {-86, -40}}, color = {159, 159, 223}));
  connect(sensT_BA_MHXin.outlet, MHX.gasIn) annotation (
    Line(points = {{30, 0}, {44, 0}}, color = {159, 159, 223}, thickness = 0.75));
  connect(MHX.gasOut, sensT_BA_MHXout.inlet) annotation (
    Line(points = {{84, 0}, {98, 0}}, color = {159, 159, 223}));
  connect(sensT_RA_MHXout.outlet, sinkPressure_RA_MHXout.flange) annotation (
    Line(points = {{86, -40}, {100, -40}}, color = {159, 159, 223}));
  connect(Turbine.outlet, sinkPressure_BA.flange) annotation (
    Line(points = {{166, -54}, {180, -54}}, color = {159, 159, 223}));
  connect(pipe_BA_PHXout.outlet, Compressor.inlet) annotation (
    Line(points = {{-30, -40}, {-30, -54}}, color = {159, 159, 223}, thickness = 0.75));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{-2, -70}, {58, -70}}, thickness = 0.5));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{78, -70}, {138, -70}}, thickness = 0.5));
  connect(MHX.gas2Out, sensT_RA_MHXout.inlet) annotation (
    Line(points = {{64, -20}, {64, -40}, {74, -40}}, color = {159, 159, 223}));
  connect(sourceMassFlow.flange, sensT_RA_PHXin.inlet) annotation (
    Line(points = {{-180, 40}, {-174, 40}}, color = {159, 159, 223}));
  connect(sourceMassFlow1.flange, sensT_BA_PHXin.inlet) annotation (
    Line(points = {{-160, 0}, {-146, 0}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXin.outlet, flowSplit.inlet) annotation (
    Line(points = {{-162, 40}, {-156, 40}}, color = {159, 159, 223}));
  connect(flowSplit.outlet1, pipe_RA_MHXin.inlet) annotation (
    Line(points = {{-144, 44}, {-70, 44}}, color = {159, 159, 223}));
  connect(pipe_RA_MHXin.outlet, MHX.gas2In) annotation (
    Line(points = {{-50, 44}, {64, 44}, {64, 20}}, color = {159, 159, 223}));
  connect(pipe_RA_PHXin.outlet, PHX.gas2In) annotation (
    Line(points = {{-112, 36}, {-100, 36}, {-100, 20}}, color = {159, 159, 223}));
  connect(flowSplit.outlet2, pipe_RA_PHXin.inlet) annotation (
    Line(points = {{-144, 36}, {-132, 36}}, color = {159, 159, 223}));
  connect(sensT_RA_PHXout.outlet, sinkPressure_RA_PHXout.flange) annotation (
    Line(points = {{-74, -40}, {-60, -40}}, color = {159, 159, 223}));
  connect(Compressor.outlet, pipe_BA_MHXin.inlet) annotation (
    Line(points = {{2, -54}, {2, -40}}, color = {159, 159, 223}));
  connect(pipe_BA_MHXin.outlet, sensT_BA_MHXin.inlet) annotation (
    Line(points = {{2, -20}, {2, 0}, {18, 0}}, color = {159, 159, 223}));
  connect(sensT_BA_PHXout.outlet, pipe_BA_PHXout.inlet) annotation (
    Line(points = {{-54, 0}, {-30, 0}, {-30, -20}}, color = {159, 159, 223}));
  connect(sensT_BA_MHXout.outlet, pipe_BA_MHXout.inlet) annotation (
    Line(points = {{110, 0}, {134, 0}, {134, -20}}, color = {159, 159, 223}));
  connect(pipe_BA_MHXout.outlet, Turbine.inlet) annotation (
    Line(points = {{134, -40}, {134, -54}}, color = {159, 159, 223}));
  annotation (
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
