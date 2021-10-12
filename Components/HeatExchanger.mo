within PL_Lib.Components;
model HeatExchanger "Base class for heat exchanger gas - gas"
  constant Real pi = Modelica.Constants.pi;
  replaceable package GasMedium1 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package GasMedium2 = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  parameter Boolean StaticGasBalances = false;
  parameter Integer Nr = 2 "Number of tube rows";
  parameter Integer Nt = 2 "Number of parallel tubes in each row";
  parameter Modelica.SIunits.Length Lt "Length of a tube in a row";
  parameter Modelica.SIunits.Length Dint "Internal diameter of each tube";
  parameter Modelica.SIunits.Length Dext "External diameter of each tube";
  parameter Modelica.SIunits.Density rhom "Density of the tube metal walls";
  parameter Modelica.SIunits.SpecificHeatCapacity cm "Specific heat capacity of the tube metal walls";
  parameter Modelica.SIunits.Area Sb "Cross-section of the boiler (including tubes)";
  final parameter Modelica.SIunits.Area Sb_net = Sb - Nr * Nt * Dext * pi * Lt "Net cross-section of the boiler";
  parameter Modelica.SIunits.Length Lb "Length of the boiler";
  parameter Modelica.SIunits.Area St = Dext * pi * Lt * Nt * Nr "Total area of the heat exchange surface";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_nom = 150 "Nominal heat transfer coefficient - gas side";

  ThermoPower.Gas.FlangeA gasIn(redeclare package Medium = GasMedium1) annotation (
    Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gasOut(redeclare package Medium = GasMedium1) annotation (
    Placement(transformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
  ThermoPower.Gas.FlangeB gas2Out(redeclare package Medium = GasMedium2) annotation (
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.FlangeA gas2In(redeclare package Medium = GasMedium2) annotation (
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  ThermoPower.Thermal.MetalTubeFV TubeWalls(L = Lt * Nr, Nw = Nr, Tstart1(displayUnit = "K") = 300, TstartN(displayUnit = "K") = 340, lambda = 20, rext = Dext / 2, rhomcm = rhom * cm, rint = Dint / 2) "Tube" annotation (
    Placement(visible = true, transformation(extent = {{-20, 0}, {20, -40}}, rotation = 0)));
  ThermoPower.Thermal.CounterCurrentFV CounterCurrent1(Nw = Nr) annotation (
    Placement(transformation(extent = {{-20, -8}, {20, 32}}, rotation = 0)));

  ThermoPower.Gas.Flow1DFV GasSide(redeclare package Medium = GasMedium1, redeclare
      model                                                                               HeatTransfer =
        ThermoPower.Thermal.HeatTransferFV.FlowDependentHeatTransferCoefficient
        (                                                                                                                                                                        gamma_nom = gamma_nom, alpha = 0.6), A = Sb, Dhyd = St / Lb, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 0.1, L = Lb, N = Nr + 1, QuasiStatic = StaticGasBalances, Tstartin = 670, Tstartout = 370, dpnom = 5000, omega = St / Lb, wnom = 10) annotation (
    Placement(transformation(extent = {{-20, 60}, {20, 20}}, rotation = 0)));

  ThermoPower.Gas.Flow1DFV GasSide2(redeclare package Medium = GasMedium2, redeclare
      model                                                                                HeatTransfer =
        ThermoPower.Thermal.HeatTransferFV.FlowDependentHeatTransferCoefficient
        (                                                                                                                                                                         gamma_nom = gamma_nom, alpha = 0.6), A = Sb, Dhyd = St / Lb, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Kfnom, Kfnom = 0.1, L = Lb, N = Nr + 1, QuasiStatic = StaticGasBalances, Tstartin = 670, Tstartout = 370, dpnom = 5000, omega = St / Lb, wnom = 10) annotation (
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(CounterCurrent1.side2, TubeWalls.ext) annotation (
    Line(points = {{0, 5.8}, {0, -14}}, color = {255, 127, 0}));
  connect(GasSide.infl, gasIn) annotation (
    Line(points = {{-20, 40}, {-60, 40}, {-60, 0}, {-100, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(GasSide.outfl, gasOut) annotation (
    Line(points = {{20, 40}, {60, 40}, {60, 0}, {100, 0}}, color = {159, 159, 223}, thickness = 0.5));
  connect(GasSide.wall, CounterCurrent1.side1) annotation (
    Line(points = {{0, 30}, {0, 18}}, color = {255, 127, 0}, smooth = Smooth.None));
  connect(gas2Out, GasSide2.outfl) annotation (
    Line(points = {{0, -100}, {0, -72}, {30, -72}, {30, -50}, {20, -50}}, color = {170, 0, 255}, thickness = 0.5));
  connect(GasSide2.infl, gas2In) annotation (
    Line(points = {{-20, -50}, {-40, -50}, {-40, 70}, {0, 70}, {0, 100}}, color = {170, 0, 255}, thickness = 0.5));
  connect(TubeWalls.int, GasSide2.wall) annotation (
    Line(points = {{0, -26}, {0, -40}}, color = {255, 127, 0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
    Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(origin = {0, 211},lineColor = {85, 170, 255}, extent = {{-100, -230}, {100, -290}}, textString = "%name"), Text(origin = {100, 40}, extent = {{-20, 20}, {20, -20}}, textString = "g1o"), Text(origin = {-100, 40}, extent = {{-20, 20}, {20, -20}}, textString = "g1i"), Text(origin = {-40, 120}, extent = {{-20, 20}, {20, -20}}, textString = "g2i"), Text(origin = {40, -100}, extent = {{-20, 20}, {20, -20}}, textString = "g2o")}),
    Documentation(revisions = "<html>
<ul>
<li><i>12 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Model restructured.</li>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>", info = "<html>
This is the model of a very simple heat exchanger. The modelling assumptions are as follows:
<ul>
<li> The boiler contains <tt>Nr</tt> rows of tubes, connected in series; each one is made of <tt>Nt</tt> identical tubes in parallel. 
<li>Each tube has a length <tt>L</tt>, internal and external diameters <tt>Dint</tt> and <tt>Dext</tt>, and is made of a metal having density <tt>rhom</tt> and a specific heat capacity of <tt>cm</tt>. 
<li>The series connection of the tubes is discretised with <tt>Nr+1</tt> nodes, so that each cell between two nodes corresponds to a single row.
<li>The gas flow is also discretised with <tt>Nr+1</tt> nodes, so that each gas cell interacts with a single tube row. 
<li>The gas flows through a volume having a (net) cross-section <tt>Sb</tt> and a (net) length <tt>Lb</tt>. 
<li>Mass and energy dynamic balances are assumed for the water side.
<li>The mass and energy balances for the gas side are either static or dynamic, depending on the value of the <tt>StaticGasBalances</tt> parameter.
<li>The fluid in the water side remains liquid throughout the boiler.
<li>The heat transfer coefficient on the water side is computed by Dittus-Boelter's correlation.
<li>The external heat transfer coefficient is computed according to the simple law declared <tt>Flow1DGasHT</tt>. To change that correlation, it is only necessary to change equations in that model.
</ul>
</html>"));
end HeatExchanger;
