within PL_Lib.Components.BaseClasses;

partial model GTunitBase "Gas Turbine"
  extends ThermoPower.Icons.Gas.GasTurbineUnit;
  replaceable package Air = Modelica.Media.Interfaces.PartialMedium;
  replaceable package Fuel = Modelica.Media.Interfaces.PartialMedium;
  replaceable package Exhaust = Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.SIunits.Pressure pstart "start pressure value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Exhaust.Temperature Tstart "start temperature value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Modelica.SIunits.MassFraction Xstart[Air.nX] = Air.reference_X "start gas composition" annotation(
    Dialog(tab = "Initialisation"));
  constant Exhaust.AbsolutePressure pnom = 1.013e5 "ISO reference pressure";
  constant Air.Temperature Tnom = 288.15 "ISO reference temperature";
  parameter SI.SpecificEnthalpy HH "Lower Heating value";
  parameter SI.PerUnit eta_mech = 0.95 "mechanical efficiency";
  parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(
    Evaluate = true);
  outer ThermoPower.System system "System wide properties";
  Air.BaseProperties gas(p(start = pstart), T(start = Tstart), Xi(start = Xstart[1:Air.nXi]));
  Air.MassFlowRate wia "Air mass flow";
  Air.MassFlowRate wia_ISO "Air mass flow, referred to ISO conditions";
  Fuel.MassFlowRate wif "Fuel mass flow";
  Exhaust.MassFlowRate wout "FlueGas mass flow";
  Air.SpecificEnthalpy hia "Air specific enthalpy";
  Fuel.SpecificEnthalpy hif "Fuel specific enthalpy";
  Exhaust.SpecificEnthalpy hout "FlueGas specific enthalpy";
  SI.Angle phi "shaft rotation angle";
  SI.Torque tau "net torque acting on the turbine";
  SI.AngularVelocity omega "shaft angular velocity";
  SI.Power ZLPout "zero_loss power output";
  SI.Power ZLPout_ISO "zero_loss power output, referred to ISO conditions ";
  SI.Power Pout "Net power output";
  SI.Power HI "Heat input";
  SI.Power HI_ISO "Heat input, referred to ISO conditions";
  SI.PerUnit PR "pressure ratio";
  Exhaust.AbsolutePressure pc "combustion pressure";
  Air.AbsolutePressure pin "inlet pressure";
  FlangeA Air_in(redeclare package Medium = Air, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
    Placement(transformation(extent = {{-100, 20}, {-80, 40}}, rotation = 0)));
  FlangeA Fuel_in(redeclare package Medium = Fuel, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
    Placement(transformation(extent = {{-10, 62}, {10, 82}}, rotation = 0)));
  FlangeB FlueGas_out(redeclare package Medium = Exhaust, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(
    Placement(transformation(extent = {{80, 20}, {100, 40}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation(
    Placement(transformation(extent = {{88, -10}, {108, 10}}, rotation = 0)));
equation
  PR = pc / pin "pressure ratio";
  HI = wif * HH "Heat input";
  HI_ISO = HI * sqrt(Tnom / gas.T) * (pnom / gas.p) "heat input, referred to ISO conditions";
  0 = Air_in.m_flow + Fuel_in.m_flow + FlueGas_out.m_flow "Mass balance";
  0 = wia * gas.h + wif * (hif + HH) + wout * hout - ZLPout "Energy balance";
  ZLPout_ISO = ZLPout * sqrt(Tnom / gas.T) * (pnom / gas.p) "Net power output, referred to ISO conditions";
  Pout = ZLPout * eta_mech "Net power output";
  Pout = tau * omega "Mechanical boundary condition";
  wia_ISO = wia * sqrt(gas.T / Tnom) / (gas.p / pnom) "Air mass flow, referred to ISO conditions";
// Set inlet gas properties
  gas.p = Air_in.p;
  gas.h = inStream(Air_in.h_outflow);
  gas.Xi = inStream(Air_in.Xi_outflow);
// Boundary conditions
  assert(Air_in.m_flow >= 0, "The model does not support flow reversal");
  wia = Air_in.m_flow;
  hia = inStream(Air_in.h_outflow);
  Air_in.p = pin;
  Air_in.h_outflow = 0;
  Air_in.Xi_outflow = Air.reference_X[1:Air.nXi];
  assert(Fuel_in.m_flow >= 0, "The model does not support flow reversal");
  wif = Fuel_in.m_flow;
  hif = inStream(Fuel_in.h_outflow);
  Fuel_in.p = pc;
  Fuel_in.h_outflow = 0;
  Fuel_in.Xi_outflow = Fuel.reference_X[1:Fuel.nXi];
  assert(FlueGas_out.m_flow <= 0, "The model does not support flow reversal");
  wout = FlueGas_out.m_flow;
  hout = FlueGas_out.h_outflow;
// Flue gas composition FlueGas_out.XBA to be determined by extended model
// Mechanical boundaries
  shaft_b.phi = phi;
  shaft_b.tau = -tau;
  der(phi) = omega;
  annotation(
    Icon(graphics = {Text(extent = {{-126, -60}, {130, -100}}, lineColor = {0, 0, 255}, textString = "%name")}),
    Diagram(graphics),
    Documentation(info = "<html>
This model describes a gas turbine unit as a single model, including the interface and all equations, except the computation of the performance characteristics and of the exhaust composition.
<p>Actual operating conditions are related to ISO standard conditions <tt>pnom</tt> and <tt>Tnom</tt> by the following relationship:
<ul><li> HI_ISO = HI*sqrt(Tnom/gas.T)*(pnom/gas.p)</li>
<li> ZLPout_ISO = ZLPout*sqrt(Tnom/gas.T)*(pnom/gas.p)</li>
<li> wia_ISO = wia*pnom/gas.p*sqrt(gas.T/Tnom)</li></ul>
<p> where <tt>HI</tt> is the heat input, <tt>ZLPout</tt> the zero loss power output and <tt>wia</tt> the air inlet flow.
<p><b>Modelling options</b></p>
<p>This model has three different Medium models to characterize the inlet air, fuel, and flue gas exhaust.
</html>", revisions = "<html>
<ul>
<li><i>19 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       GTunit model restructured using inheritance.<br>
       First release.</li>
</ul>
</html>"));
end GTunitBase;
