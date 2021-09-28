within PL_Lib.Components;

model Pipe
  extends PL_Lib.Interfaces.PartialTwoPort;
  parameter Modelica.SIunits.Length L = 1;
  parameter Modelica.SIunits.Diameter Dh = 1 "Hydraulic diameter of the pipe";
  parameter Modelica.SIunits.Diameter D = 1 "Pipe diameter";
  parameter Modelica.SIunits.Density rho = 1 "Air density";
  parameter Real k = 0.1 "Roughness factor for aluminium pipe";
  parameter Modelica.SIunits.Area A = 1 "Cross-sectional area of the pipe";
  parameter Modelica.SIunits.Length Wp = 1 "Wetted perimeter of the pipe";
  
  
  Modelica.SIunits.Pressure dP;
  Modelica.SIunits.ReynoldsNumber Re;
  Modelica.SIunits.Velocity u;
  Modelica.SIunits.DynamicViscosity mu;
  Modelica.SIunits.MassFlowRate m_dot;
  Real f "Friction coefficient";
  Real K "Loss coefficient";
equation
  port_a.m_flow = m_dot;

  dP = K*rho*u^2/2;
  K = f*L/Dh;
  f = 0.25/(log( k/(3.7*Dh) + 5.74/(Re^0.9)))^2;
  Dh = 4 * A/Wp;
  Re = (m_dot*D)/(A * mu);
  m_dot = rho * A * u;
  
  port_a.m_flow = port_b.m_flow;
  port_a.T = port_b.T;
  port_a.q = port_b.q;
  port_a.p = port_b.p + dP;
annotation(
    Icon(graphics = {Rectangle(fillColor = {85, 170, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 40}, {100, -40}}), Text(origin = {0, 60}, extent = {{-60, 20}, {60, -20}}, textString = "%name")}));
end Pipe;
