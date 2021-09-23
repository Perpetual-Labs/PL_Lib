within PL_Lib.Components.BaseClasses;

partial model CombustionChamberBase "Combustion Chamber"
  extends Icons.Gas.Mixer;
  replaceable package Air = Modelica.Media.Interfaces.PartialMedium;
  replaceable package Fuel = Modelica.Media.Interfaces.PartialMedium;
  replaceable package Exhaust = Modelica.Media.Interfaces.PartialMedium;
  parameter SI.Volume V "Inner volume";
  parameter SI.Area S = 0 "Inner surface";
  parameter SI.CoefficientOfHeatTransfer gamma = 0 "Heat Transfer Coefficient" annotation(
    Evaluate = true);
  parameter SI.HeatCapacity Cm = 0 "Metal Heat Capacity" annotation(
    Evaluate = true);
  parameter SI.Temperature Tmstart = 300 "Metal wall start temperature" annotation(
    Dialog(tab = "Initialisation"));
  parameter SI.SpecificEnthalpy HH "Lower Heating value of fuel";
  parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(
    Evaluate = true);
  outer ThermoPower.System system "System wide properties";
  parameter Air.AbsolutePressure pstart = 101325 "Pressure start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Air.Temperature Tstart = 300 "Temperature start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Air.MassFraction Xstart[Exhaust.nX] = Exhaust.reference_X "Start flue gas composition" annotation(
    Dialog(tab = "Initialisation"));
  parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option" annotation(
    Dialog(tab = "Initialisation"));
  parameter Boolean noInitialPressure = false "Remove initial equation on pressure" annotation(
    Dialog(tab = "Initialisation"),
    choices(checkBox = true));
  Exhaust.BaseProperties fluegas(p(start = pstart), T(start = Tstart), Xi(start = Xstart[1:Exhaust.nXi]));
  SI.Mass M "Gas total mass";
  SI.Mass MX[Exhaust.nXi] "Partial flue gas masses";
  SI.InternalEnergy E "Gas total energy";
  SI.Temperature Tm(start = Tmstart) "Wall temperature";
  Air.SpecificEnthalpy hia "Air specific enthalpy";
  Fuel.SpecificEnthalpy hif "Fuel specific enthalpy";
  Exhaust.SpecificEnthalpy ho "Outlet specific enthalpy";
  SI.Power HR "Heat rate";
  SI.Time Tr "Residence time";
  FlangeA ina(redeclare package Medium = Air, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) "inlet air" annotation(
    Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  FlangeA inf(redeclare package Medium = Fuel, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) "inlet fuel" annotation(
    Placement(transformation(extent = {{-20, 80}, {20, 120}}, rotation = 0)));
  FlangeB out(redeclare package Medium = Exhaust, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) "flue gas" annotation(
    Placement(transformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
equation
  M = fluegas.d * V "Gas mass";
  E = fluegas.u * M "Gas energy";
  MX = fluegas.Xi * M "Component masses";
  HR = inf.m_flow * HH;
  der(M) = ina.m_flow + inf.m_flow + out.m_flow "Gas mass balance";
  der(E) = ina.m_flow * hia + inf.m_flow * hif + out.m_flow * ho + HR - gamma * S * (fluegas.T - Tm) "Gas energy balance";
  if Cm > 0 and gamma > 0 then
    Cm * der(Tm) = gamma * S * (fluegas.T - Tm) "Metal wall energy balance";
  else
    Tm = fluegas.T;
  end if;
// Set gas properties
  out.p = fluegas.p;
  out.h_outflow = fluegas.h;
  out.Xi_outflow = fluegas.Xi;
// Boundary conditions
  ina.p = fluegas.p;
  ina.h_outflow = 0;
  ina.Xi_outflow = Air.reference_X[1:Air.nXi];
  inf.p = fluegas.p;
  inf.h_outflow = 0;
  inf.Xi_outflow = Fuel.reference_X[1:Fuel.nXi];
  assert(ina.m_flow >= 0, "The model does not support flow reversal");
  hia = inStream(ina.h_outflow);
  assert(inf.m_flow >= 0, "The model does not support flow reversal");
  hif = inStream(inf.h_outflow);
  assert(out.m_flow <= 0, "The model does not support flow reversal");
  ho = fluegas.h;
  Tr = noEvent(M / max(abs(out.m_flow), Modelica.Constants.eps));
initial equation
// Initial conditions
  if initOpt == Choices.Init.Options.noInit then
// do nothing
  elseif initOpt == Choices.Init.Options.fixedState then
    if not noInitialPressure then
      fluegas.p = pstart;
    end if;
    fluegas.T = Tstart;
    fluegas.Xi = Xstart[1:Exhaust.nXi];
  elseif initOpt == Choices.Init.Options.steadyState then
    if not noInitialPressure then
      der(fluegas.p) = 0;
    end if;
    der(fluegas.T) = 0;
    der(fluegas.Xi) = zeros(Exhaust.nXi);
    if Cm > 0 and gamma > 0 then
      der(Tm) = 0;
    end if;
  elseif initOpt == Choices.Init.Options.steadyStateNoP then
    der(fluegas.T) = 0;
    der(fluegas.Xi) = zeros(Exhaust.nXi);
    if Cm > 0 and gamma > 0 then
      der(Tm) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation(
    Documentation(info = "<html>
This is the model-base of a Combustion Chamber, with a constant volume.
<p>The metal wall temperature and the heat transfer coefficient between the wall and the fluid are uniform. The wall is thermally insulated from the outside. It has been assumed that inlet gases are premixed before entering in the volume.
<p><b>Modelling options</b></p>
<p>This model has three different Medium models to characterize the inlet air, fuel, and flue gas exhaust.
<p>If <tt>gamma = 0</tt>, the thermal effects of the surrounding walls are neglected.</p>
<p>There are two ways to obtain correct energy balances. The first is to explicitly set the lower heating value of the fuel <tt>HH</tt>, and use medium models that do not include the enthalpy of formation, by setting <tt>excludeEnthalpyOfFormation = true</tt>, which is the default option in Modelica.Media. As the heating value is usually provided at 25 degC temperature, it is also necessary to set <tt>referenceChoice =ReferenceEnthalpy.ZeroAt25C</tt> in all medium models for consistency. This is done in the medium models contained within <a href=\"modelica://ThermoPower.Media\">ThermoPower.Media</a>.</p>
<p>Alternatively, one can set <tt>excludeEnthalpyOfFormation = false</tt> in all media and set <tt>HH = 0</tt>. By doing so, the heating value is automatically accounted for by the difference in the enthalpy of formation. 
</html>", revisions = "<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>31 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
    CombustionChamber model restructured using inheritance.
<p> First release.</li>
</ul>
</html>
    "),
    Diagram(graphics));
end CombustionChamberBase;
