within PL_Lib.Components;

model HXg2g
  constant Real pi = Modelica.Constants.pi;
  replaceable package GasMedium1 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package GasMedium2 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Boolean StaticGasBalances = false;
  parameter Integer Nr = 2 "Number of tube rows";
  parameter Integer Nt = 2 "Number of parallel tubes in each row";
  parameter Modelica.SIunits.Length Lt = 3 "Length of a tube in a row";
  parameter Modelica.SIunits.Length Dint = 0.01 "Internal diameter of each tube";
  parameter Modelica.SIunits.Length Dext = 0.012 "External diameter of each tube";
  parameter Modelica.SIunits.Density rhom = 7800 "Density of the tube metal walls";
  parameter Modelica.SIunits.SpecificHeatCapacity cm = 650 "Specific heat capacity of the tube metal walls";
  parameter Modelica.SIunits.Area Sb = 8 "Cross-section of the boiler (including tubes)";
  final parameter Modelica.SIunits.Area Sb_net = Sb - Nr * Nt * Dext * pi * Lt "Net cross-section of the boiler";
  parameter Modelica.SIunits.Length Lb = 2 "Length of the boiler";
  parameter Modelica.SIunits.Area St = Dext * pi * Lt * Nt * Nr "Total area of the heat exchange surface";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_nom = 150 "Nominal heat transfer coefficient - gas side";
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Modelica.SIunits.Length Lhex = 200 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  parameter Modelica.SIunits.MassFlowRate whex = 0.05 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex = 2e5 "initial pressure";
  parameter Modelica.SIunits.Temperature Tinhex = 300 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Touthex = 300 "initial outlet temperature";
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  ThermoPower.Gas.Flow1DFV HXgas1(redeclare package Medium = GasMedium1, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-20, 20}, {20, -20}}, rotation = 0)));
  ThermoPower.Gas.FlangeA gasIn1(redeclare package Medium = GasMedium1) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gasOut1(redeclare package Medium = GasMedium1) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV TubeWalls(L = Lhex, Nw = Nnodes - 1, Tstartbar(displayUnit = "K"), lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-20, 20}, {20, -20}}, rotation = 0)));
  ThermoPower.Gas.FlangeA gasIn2(redeclare package Medium = GasMedium2) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gasOut2(redeclare package Medium = GasMedium2) annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HXgas2(redeclare package Medium = GasMedium2, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartin = Tinhex, Tstartout = Touthex, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex, wnom = whex) annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //initial equation
  //  Mbal = Mhex;
equation
//  Mhex = hex.M;
//  der(Mbal) = hex.infl.m_flow + hex.outfl.m_flow;
//  Merr = Mhex - Mbal;
  connect(HXgas1.wall, counterCurrentFV.side1) annotation(
    Line(points = {{0, 50}, {0, 26}}, color = {255, 127, 0}));
  connect(gasIn1, HXgas1.infl) annotation(
    Line(points = {{-100, 0}, {-60, 0}, {-60, 60}, {-20, 60}}, color = {159, 159, 223}, thickness = 0.75));
  connect(HXgas1.outfl, gasOut1) annotation(
    Line(points = {{20, 60}, {60, 60}, {60, 0}, {100, 0}}, color = {159, 159, 223}, thickness = 0.75));
  connect(gasOut2, HXgas2.outfl) annotation(
    Line(points = {{0, -100}, {0, -80}, {40, -80}, {40, -60}, {20, -60}}, color = {159, 159, 223}, thickness = 0.75));
  connect(HXgas2.infl, gasIn2) annotation(
    Line(points = {{-20, -60}, {-40, -60}, {-40, 80}, {0, 80}, {0, 100}}, color = {159, 159, 223}, thickness = 0.75));
  connect(counterCurrentFV.side2, TubeWalls.ext) annotation(
    Line(points = {{0, 14}, {0, -14}}, color = {255, 127, 0}));
  connect(HXgas2.wall, TubeWalls.int) annotation(
    Line(points = {{0, -50}, {0, -26}}, color = {255, 127, 0}));
  annotation(
    Icon(graphics = {Rectangle(lineColor = {89, 89, 89}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}, radius = 30), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {85, 0, 255}, thickness = 0.5), Text(origin = {0, 211}, lineColor = {85, 170, 255}, extent = {{-100, -230}, {100, -290}}, textString = "%name")}));
end HXg2g;
