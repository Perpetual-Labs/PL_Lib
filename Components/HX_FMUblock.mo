within PL_Lib.Components;
model HX_FMUblock
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Integer Nt = 20 "Number of tubes in parallel";
  parameter Modelica.SIunits.Length Lhex = 10 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA = 101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA = 101325 * 2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA = 273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA = 273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA = 273.15 + 200;
  parameter Modelica.SIunits.Temperature Thex_out_BA = 273.15 + 60;

  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw = Nnodes - 1) annotation (
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Flow1DFV HEX1_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation (
    Placement(visible = true, transformation(extent = {{-10, -50}, {10, -30}}, rotation = 0)));

  ThermoPower.Gas.Flow1DFV HEX1_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_RA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_RA) annotation (
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstart1 = Thex_in_BA, TstartN = Thex_in_BA, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation (
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor4(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {30, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.MassFlowToPressureAdapter massFlowToPressureAdaptor2(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {30, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor1(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PL_Lib.Utilities.PressureToMassFlowAdapter pressureToMassFlowAdaptor3(redeclare
      package                                                                             Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));




  Modelica.Blocks.Interfaces.RealInput T1
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput p1                                                                      "Pressure in port medium"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput T2
    annotation (Placement(transformation(extent={{-120,-46},{-80,-6}})));
  Modelica.Blocks.Interfaces.RealInput p2                                                                      "Pressure in port medium"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T3                                                                                 "Temperature in port medium"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput p3                                                                              "Pressure in port medium"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput d1
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput T4                                                                                 "Temperature in port medium"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput p4                                                                              "Pressure in port medium"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput d2
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealInput m_dot1                                                                                     "Mass flow rate in port medium"
    annotation (Placement(transformation(extent={{-120,-10},{-80,30}})));
  Modelica.Blocks.Interfaces.RealInput m_dot2                                                                                     "Mass flow rate in port medium"
    annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealOutput m_dot3
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_dot4
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
equation
  connect(HEX1_RA.wall, heatExchangerTopologyFV1.side1) annotation (
    Line(points = {{0, 35}, {0, 13}}, color = {255, 127, 0}, thickness = 1));
  connect(heatExchangerTopologyFV1.side2, metalTubeFV1.int) annotation (
    Line(points = {{0, 6.9}, {0, -7}}, color = {255, 127, 0}));
  connect(pressureToMassFlowAdaptor3.flange, HEX1_BA.infl) annotation (
    Line(points = {{-26, -40}, {-10, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.flange, HEX1_RA.infl) annotation (
    Line(points = {{-26, 40}, {-10, 40}}, color = {159, 159, 223}));
  connect(HEX1_RA.outfl, massFlowToPressureAdaptor2.flange) annotation (
    Line(points = {{10, 40}, {26, 40}}, color = {159, 159, 223}));
  connect(HEX1_BA.wall, metalTubeFV1.ext) annotation (
    Line(points = {{0, -35}, {0, -13.1}}, color = {255, 127, 0}, thickness = 1));
  connect(HEX1_BA.outfl, massFlowToPressureAdaptor4.flange) annotation (
    Line(points = {{10, -40}, {26, -40}}, color = {159, 159, 223}));
  connect(pressureToMassFlowAdaptor1.T, T1) annotation (Line(points={{-36,54},{
          -72,54},{-72,70},{-100,70}}, color={0,0,127}));
  connect(pressureToMassFlowAdaptor1.p, p1) annotation (Line(points={{-36,48},{
          -36,64},{-74,64},{-74,40},{-100,40}}, color={0,0,127}));
  connect(pressureToMassFlowAdaptor3.T, T2) annotation (Line(points={{-36,-26},
          {-36,-16},{-74,-16},{-74,-26},{-100,-26}}, color={0,0,127}));
  connect(pressureToMassFlowAdaptor3.p, p2) annotation (Line(points={{-36,-32},
          {-68,-32},{-68,-60},{-100,-60}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor2.T, T3) annotation (Line(points={{36,54},{
          94,54},{94,70},{110,70}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor2.p, p3) annotation (Line(points={{36,48},{
          36,76},{96,76},{96,50},{110,50}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor2.d, d1) annotation (Line(points={{36,42},{
          94,42},{94,30},{110,30}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor4.T, T4) annotation (Line(points={{36,-26},{
          66,-26},{66,-16},{110,-16},{110,-10}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor4.p, p4) annotation (Line(points={{36,-32},{
          36,-16},{60,-16},{60,-30},{110,-30}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor4.d, d2) annotation (Line(points={{36,-38},{
          84,-38},{84,-50},{110,-50}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor2.m_dot, m_dot1) annotation (Line(points={{
          36,26},{50,26},{50,10},{-100,10}}, color={0,0,127}));
  connect(massFlowToPressureAdaptor4.m_dot, m_dot2) annotation (Line(points={{
          36,-54},{40,-54},{40,-66},{-100,-66},{-100,-90}}, color={0,0,127}));
  connect(pressureToMassFlowAdaptor1.m_dot, m_dot3) annotation (Line(points={{
          -36,26},{-42,26},{-42,10},{110,10}}, color={0,0,127}));
  connect(pressureToMassFlowAdaptor3.m_dot, m_dot4) annotation (Line(points={{
          -36,-54},{-48,-54},{-48,-70},{110,-70}}, color={0,0,127}));
end HX_FMUblock;
