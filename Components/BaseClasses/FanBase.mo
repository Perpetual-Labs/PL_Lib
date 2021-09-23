within PL_Lib.Components.BaseClasses;

partial model FanBase "Base model for fans"
  extends Icons.Gas.Fan;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching = true);
  Medium.BaseProperties inletFluid(h(start = hstart)) "Fluid properties at the inlet";
  // Flow Characteristic curves
  parameter Boolean useFlowModel = false "Use function from replaceable model for flow characteristic" annotation(
    Evaluate = true,
    choices(CheckBox = true),
    Dialog(group = "Characteristic curves"));
  replaceable function flowCharacteristic = Functions.FanCharacteristics.dummyFlow constrainedby Functions.FanCharacteristics.baseFlow "Head vs. q_flow characteristic at nominal speed and density" annotation(
     Dialog(group = "Characteristic curves"),
     choicesAllMatching = true,
     enable = not useFlowCharacteristicModel);
  replaceable model FlowCharacteristicModel = Functions.FanCharacteristics.Models.BaseFlow annotation(
    Dialog(group = "Characteristic curves"),
    choicesAllMatching = true,
    enable = not useFlowCharacteristicModel);
  // Power characteristic curves
  parameter Boolean usePowerCharacteristic = false "Use powerCharacteristic (vs. efficiencyCharacteristic)" annotation(
    Dialog(group = "Characteristic curves"));
  replaceable function powerCharacteristic = Functions.FanCharacteristics.constantPower constrainedby Functions.FanCharacteristics.basePower "Power consumption vs. q_flow at nominal speed and density" annotation(
     Dialog(group = "Characteristic curves", enable = usePowerCharacteristic),
     choicesAllMatching = true);
  // Efficiency characteristic curves
  replaceable function efficiencyCharacteristic = Functions.FanCharacteristics.constantEfficiency(eta_nom = 0.8) constrainedby Functions.PumpCharacteristics.baseEfficiency "Efficiency vs. q_flow at nominal speed and density" annotation(
     Dialog(group = "Characteristic curves", enable = not usePowerCharacteristic),
     choicesAllMatching = true);
  parameter Integer Np0(min = 1) = 1 "Nominal number of fans in parallel";
  parameter SI.PerUnit bladePos0 = 1 "Nominal blade position" annotation(
    Dialog(group = "Nominal values"));
  parameter Medium.Density rho0 = 1.229 "Nominal Gas Density" annotation(
    Dialog(group = "Nominal values"));
  parameter NonSI.AngularVelocity_rpm n0 = 1500 "Nominal rotational speed" annotation(
    Dialog(group = "Nominal values"));
  parameter SI.Volume V = 0 "Fan Internal Volume" annotation(
    Evaluate = true);
  parameter Boolean CheckValve = false "Reverse flow stopped";
  parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(
    Evaluate = true);
  outer ThermoPower.System system "System wide properties";
  parameter SI.VolumeFlowRate q_single_start = q_single0 "Volume Flow Rate Start Value (single pump)" annotation(
    Dialog(tab = "Initialisation"));
  parameter Medium.SpecificEnthalpy hstart = 1e5 "Fluid Specific Enthalpy Start Value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Medium.Density rho_start = rho0 "Inlet Density start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter NonSI.AngularVelocity_rpm n_start = n0 "Rotational speed start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter SI.SpecificEnergy H_start = H0 "Specific energy start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter SI.PerUnit bladePos_start = bladePos0 "Blade position start value" annotation(
    Dialog(tab = "Initialisation"));
  parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option" annotation(
    Dialog(tab = "Initialisation"));
  parameter Medium.MassFlowRate w0 "Nominal mass flow rate" annotation(
    Dialog(group = "Nominal values"));
  parameter SI.Pressure dp0 "Nominal pressure increase" annotation(
    Dialog(group = "Nominal values"));
  final parameter SI.VolumeFlowRate q_single0 = w0 / (Np0 * rho0) "Nominal volume flow rate (single fan)";
  final parameter SI.SpecificEnergy H0 = dp0 / rho0 "Nominal specific energy";
  final parameter Real dH_dq_start = if useFlowModel then flowModel.dH_dq(q_single_start, bladePos_start) else dH_dq(q_single_start, bladePos_start) "Derivative of specific energy w.r.t. volume flow at start conditions";
  final parameter Real dH_dn_start = 2 * H_start / n_start - dH_dq_start * q_single_start / n_start "Derivative of flow characteristic w.r.t. fan speed at start conditions";
  Medium.MassFlowRate w_single(start = q_single_start * rho_start) "Mass flow rate (single fan)";
  Medium.MassFlowRate w = Np * w_single "Mass flow rate (total)";
  SI.VolumeFlowRate q_single "Volume flow rate (single fan)";
  SI.VolumeFlowRate q = Np * q_single "Volume flow rate (totale)";
  SI.PressureDifference dp "Outlet pressure minus inlet pressure";
  SI.SpecificEnergy H "Specific energy";
  Medium.SpecificEnthalpy h(start = hstart) "Fluid specific enthalpy";
  Medium.SpecificEnthalpy hin(start = hstart) "Enthalpy of entering fluid";
  Medium.SpecificEnthalpy hout(start = hstart) "Enthalpy of outgoing fluid";
  Units.LiquidDensity rho "Gas density";
  Medium.Temperature Tin "Gas inlet temperature";
  NonSI.AngularVelocity_rpm n "Shaft r.p.m.";
  Real bladePos "Blade position";
  Integer Np(min = 1) "Number of fans in parallel";
  SI.Power W_single "Power Consumption (single fan)";
  SI.Power W = Np * W_single "Power Consumption (total)";
  constant SI.Power W_eps = 1e-8 "Small coefficient to avoid numerical singularities";
  constant NonSI.AngularVelocity_rpm n_eps = 1e-6;
  SI.PerUnit eta "Fan efficiency";
  Real s "Auxiliary Variable";
  FlangeA infl(h_outflow(start = hstart), redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
    Placement(transformation(extent = {{-100, 2}, {-60, 42}}, rotation = 0)));
  FlangeB outfl(h_outflow(start = hstart), redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(
    Placement(transformation(extent = {{40, 52}, {80, 92}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerInput in_Np "Number of  parallel pumps" annotation(
    Placement(transformation(origin = {28, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput in_bladePos annotation(
    Placement(transformation(origin = {-40, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  FlowCharacteristicModel flowModel "Model for flow characteristic function with static parameters";
protected
  function dH_dq "Approximated partial derivative of flow characteristic w.r.t. volume flow"
    input SI.VolumeFlowRate q_flow;
    input SI.PerUnit bladePos;
    output Real dH;
  algorithm
    dH := (flowCharacteristic(1.05 * q_flow, bladePos) - flowCharacteristic(0.95 * q_flow, bladePos)) / 0.1;
    annotation(
      Inline = true);
  end dH_dq;
equation
// Number of fans in parallel
  Np = in_Np;
  if cardinality(in_Np) == 0 then
    in_Np = Np0 "Number of fans selected by parameter";
  end if;
// Blade position
  bladePos = in_bladePos;
  if cardinality(in_bladePos) == 0 then
    in_bladePos = bladePos0 "Blade position selected by parameter";
  end if;
// Fluid properties (always uses the properties upstream of the inlet flange)
  inletFluid.p = infl.p;
  inletFluid.h = inStream(infl.h_outflow);
  rho = inletFluid.d;
  Tin = inletFluid.T;
// Flow equations
  q_single = w_single / homotopy(rho, rho0);
  H = dp / homotopy(rho, rho0);
  if noEvent(s > 0 or not CheckValve) then
// Flow characteristics when check valve is open
    q_single = s;
    H = homotopy(if useFlowModel then (n / n0) ^ 2 * flowModel.flowCharacteristic(q_single * n0 / (n + n_eps), bladePos) else (n / n0) ^ 2 * flowCharacteristic(q_single * n0 / (n + n_eps), bladePos), H_start + dH_dq_start * (q_single - q_single_start) + dH_dn_start * (n - n_start));
  else
// Flow characteristics when check valve is closed
    q_single = 0;
    H = homotopy(if useFlowModel then (n / n0) ^ 2 * flowModel.flowCharacteristic(0, bladePos) - s else (n / n0) ^ 2 * flowCharacteristic(0, bladePos - s), H_start + dH_dn_start * (n - n_start) - s);
  end if;
// Power consumption
  if usePowerCharacteristic then
    W_single = (n / n0) ^ 3 * (rho / rho0) * powerCharacteristic(q_single * n0 / (n + n_eps), bladePos) "Power consumption (single fan)";
    eta = dp * q_single / (W_single + W_eps) "Hydraulic efficiency";
  else
    eta = efficiencyCharacteristic(q_single * n0 / (n + n_eps), bladePos);
    W_single = dp * q_single / eta;
  end if;
// Boundary conditions
  dp = outfl.p - infl.p;
  w = infl.m_flow "Fan total flow rate";
  hin = homotopy(if not allowFlowReversal then inStream(infl.h_outflow) else if w >= 0 then inStream(infl.h_outflow) else h, inStream(infl.h_outflow));
  hout = homotopy(if not allowFlowReversal then h else if w >= 0 then h else inStream(outfl.h_outflow), h);
// Mass balance
  infl.m_flow + outfl.m_flow = 0 "Mass balance";
// Energy balance
  if V > 0 then
    rho * V * der(h) = outfl.m_flow / Np * hout + infl.m_flow / Np * hin + W_single "Dynamic energy balance (single fan)";
    outfl.h_outflow = h;
    infl.h_outflow = h;
  else
    outfl.h_outflow = inStream(infl.h_outflow) + W_single / w "Energy balance for w > 0";
    infl.h_outflow = inStream(outfl.h_outflow) + W_single / w "Energy balance for w < 0";
    h = homotopy(if not allowFlowReversal then outfl.h_outflow else if w >= 0 then outfl.h_outflow else infl.h_outflow, outfl.h_outflow) "Definition of h";
  end if;
initial equation
  if initOpt == Choices.Init.Options.noInit then
// do nothing
  elseif initOpt == Choices.Init.Options.fixedState then
    if V > 0 then
      h = hstart;
    end if;
  elseif initOpt == Choices.Init.Options.steadyState then
    if V > 0 then
      der(h) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation(
    Icon(graphics),
    Diagram(graphics),
    Documentation(info = "<HTML>
<p>This is the base model for the <tt>FanMech</tt> fan model.
<p>The model describes a fan, or a group of <tt>Np</tt> identical fans, with optional blade angle regulation. The fan model is based on the theory of kinematic similarity: the fan characteristics are given for nominal operating conditions (rotational speed and fluid density), and then adapted to actual operating condition, according to the similarity equations.
<p>In order to avoid singularities in the computation of the outlet enthalpy at zero flowrate, the thermal capacity of the fluid inside the fan body can be taken into account.
<p>The model can either support reverse flow conditions or include a built-in check valve to avoid flow reversal.
<p><b>Modelling options</b></p>
<p> The nominal flow characteristic (specific energy vs. volume flow rate) is given by the the replaceable function <tt>flowCharacteristic</tt>. If the blade angles are fixed, it is possible to use implementations which ignore the <tt>bladePos</tt> input.
<p> The fan energy balance can be specified in two alternative ways:
<ul>
<li><tt>usePowerCharacteristic = false</tt> (default option): the replaceable function <tt>efficiencyCharacteristic</tt> (efficiency vs. volume flow rate in nominal conditions) is used to determine the efficiency, and then the power consumption. The default is a constant efficiency of 0.8.
<li><tt>usePowerCharacteristic = true</tt>: the replaceable function <tt>powerCharacteristic</tt> (power consumption vs. volume flow rate in nominal conditions) is used to determine the power consumption, and then the efficiency.
</ul>
<p>
Several functions are provided in the package <tt>Functions.FanCharacteristics</tt> to specify the characteristics as a function of some operating points at nominal conditions.
<p>Depending on the value of the <tt>checkValve</tt> parameter, the model either supports reverse flow conditions, or includes a built-in check valve to avoid flow reversal.
<p>If the <tt>in_Np</tt> input connector is wired, it provides the number of fans in parallel; otherwise,  <tt>Np0</tt> parallel fans are assumed.</p>
<p>It is possible to take into account the heat capacity of the fluid inside the fan by specifying its volume <tt>V</tt> at nominal conditions; this is necessary to avoid singularities in the computation of the outlet enthalpy in case of zero flow rate. If zero flow rate conditions are always avoided, this dynamic effect can be neglected by leaving the default value <tt>V = 0</tt>, thus avoiding a fast state variable in the model.
<p>The <tt>CheckValve</tt> parameter determines whether the fan has a built-in check valve or not.
</HTML>", revisions = "<html>
<ul>
<li><i>10 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Adapted from the <tt>Water.PumpBase</tt> model.</li>
</ul>
</html>"));
end FanBase;
