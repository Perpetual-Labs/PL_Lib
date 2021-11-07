within PL_Lib.Components.Obsolete;
model StateReader_gas "State reader for the visualization of the state in the simulation (gas)"
  extends ThermoPower.PowerPlants.HRSG.Components.BaseReader_gas;
  Medium.BaseProperties gas;
  Modelica.SIunits.Temperature T "Temperature";
  Modelica.SIunits.Pressure p "Pressure";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  Modelica.SIunits.MassFlowRate w "Mass flow rate";
  Modelica.Blocks.Interfaces.RealOutput T_out annotation (
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput p_out annotation (
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput mdot_out annotation (
    Placement(visible = true, transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput d_out annotation (
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
// Set gas properties
  inlet.p = gas.p;
  gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
  gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow) else actualStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));
  T = gas.T;
  p = gas.p;
  h = gas.h;
  w = inlet.m_flow;

  T_out = T;
  p_out = p;
  mdot_out = w;
  d_out = gas.d;

end StateReader_gas;
