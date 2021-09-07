within PL_Lib.Interfaces;

connector ThermoFluidPort
    Modelica.SIunits.Pressure p;
    flow Modelica.SIunits.MassFlowRate m_flow;
    Modelica.SIunits.Temperature T;
    flow Modelica.SIunits.HeatFlowRate q;
end ThermoFluidPort;
