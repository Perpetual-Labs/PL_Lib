within PL_Lib.Components;

model HeatExchanger_CoFlow
  constant Real pi = Modelica.Constants.pi;
  replaceable package GasMedium1 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package GasMedium2 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Boolean StaticGasBalances = false;
  parameter Integer Nnodes = 10 "number of Nodes";  
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
  parameter Modelica.SIunits.Length Lhex = 200 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  
  parameter Modelica.SIunits.MassFlowRate whex_gas1 = 0.05 "nominal (and initial) mass flow rate" annotation(Dialog(tab = "Operating Conditions", group = "Gas 1"));
  parameter Modelica.SIunits.MassFlowRate whex_gas2 = 0.05 "nominal (and initial) mass flow rate" annotation(Dialog(tab = "Operating Conditions", group = "Gas 2"));
  parameter Modelica.SIunits.Pressure dpnom_gas1 = 1000 annotation(Dialog(tab = "Operating Conditions", group = "Gas 1"));
  parameter Modelica.SIunits.Pressure dpnom_gas2 = 1000 annotation(Dialog(tab = "Operating Conditions", group = "Gas 2"));
  parameter Modelica.SIunits.Pressure phex_gas1 = 1e5 "initial pressure" annotation(Dialog(tab = "Operating Conditions", group = "Gas 1"));
  parameter Modelica.SIunits.Pressure phex_gas2 = 1e5 "initial pressure" annotation(Dialog(tab = "Operating Conditions", group = "Gas 2"));
  parameter Modelica.SIunits.Temperature Thex_in_gas1 = 300 "initial inlet temperature" annotation(Dialog(tab = "Operating Conditions", group = "Gas 1"));
  parameter Modelica.SIunits.Temperature Thex_in_gas2 = 300 "initial inlet temperature" annotation(Dialog(tab = "Operating Conditions", group = "Gas 2"));
  parameter Modelica.SIunits.Temperature Thex_out_gas1 = 300 "initial outlet temperature" annotation(Dialog(tab = "Operating Conditions", group = "Gas 1"));
  parameter Modelica.SIunits.Temperature Thex_out_gas2 = 300 "initial outlet temperature" annotation(Dialog(tab = "Operating Conditions", group = "Gas 2"));
  
  ThermoPower.Gas.FlangeA gas1_in(redeclare package Medium = GasMedium1) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gas1_out(redeclare package Medium = GasMedium1) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlangeA gas2_in(redeclare package Medium = GasMedium2) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gas2_out(redeclare package Medium = GasMedium2) annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw = Nnodes - 1) annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV TubeWalls1(L = Lhex, Nw = Nnodes - 1, Tstart1 = Thex_in_gas1, TstartN = Thex_out_gas1, Tstartbar(displayUnit = "K"), lambda = 20, rext = Dext / 2, rhomcm = rhom * cm, rint = Dint / 2) annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  ThermoPower.Gas.Flow1DFV HX_gas1(redeclare package Medium = GasMedium1, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartin = Thex_in_gas1, Tstartout = Thex_out_gas1, dpnom = dpnom_gas1, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, noInitialPressure = true, omega = omegahex, pstart = phex_gas1, wnom = whex_gas1) annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-20, 20}, {20, -20}}, rotation = 0)));
  
  ThermoPower.Gas.Flow1DFV HX_gas2(redeclare package Medium = GasMedium2, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartin = Thex_in_gas2, Tstartout = Thex_out_gas2, dpnom = dpnom_gas2, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, noInitialPressure = true, omega = omegahex, pstart = phex_gas2, wnom = whex_gas2) annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(HX_gas1.wall, heatExchangerTopologyFV.side1) annotation(
    Line(points = {{0, 50}, {0, 26}}, color = {255, 127, 0}));
  connect(heatExchangerTopologyFV.side2, TubeWalls1.int) annotation(
    Line(points = {{0, 13.8}, {0, -14.2}}, color = {255, 127, 0}));
  connect(TubeWalls1.ext, HX_gas2.wall) annotation(
    Line(points = {{0, -26.2}, {0, -50.2}}, color = {255, 127, 0}));
  connect(gas1_in, HX_gas1.infl) annotation(
    Line(points = {{-100, 0}, {-80, 0}, {-80, 60}, {-20, 60}}, color = {159, 159, 223}));
  connect(HX_gas1.outfl, gas1_out) annotation(
    Line(points = {{20, 60}, {80, 60}, {80, 0}, {100, 0}}, color = {159, 159, 223}));
  connect(gas2_out, HX_gas2.outfl) annotation(
    Line(points = {{0, -100}, {0, -80}, {40, -80}, {40, -60}, {20, -60}}, color = {159, 159, 223}));
  connect(HX_gas2.infl, gas2_in) annotation(
    Line(points = {{-20, -60}, {-40, -60}, {-40, 80}, {0, 80}, {0, 100}}, color = {159, 159, 223}));
  annotation(
    Icon(graphics = {Rectangle(lineColor = {89, 89, 89}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}, radius = 30), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {85, 0, 255}, thickness = 0.5), Text(origin = {0, 211}, lineColor = {85, 170, 255}, extent = {{-100, -230}, {100, -290}}, textString = "%name")}));
end HeatExchanger_CoFlow;
