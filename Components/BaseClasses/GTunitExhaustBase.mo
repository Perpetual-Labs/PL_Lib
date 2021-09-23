within PL_Lib.Components.BaseClasses;

partial model GTunitExhaustBase "Adds computation of exhaust composition to GTunitBase"
  extends BaseClasses.GTunitBase(redeclare package Air = ThermoPower.Media.Air "O2, H2O, Ar, N2", redeclare package Fuel = ThermoPower.Media.NaturalGas "N2, CO2, CH4", redeclare package Exhaust = ThermoPower.Media.FlueGas "O2, Ar, H2O, CO2, N2");
  parameter Boolean constantCompositionExhaust = false "Assume exhaust composition equal to reference_X";
  Real wcomb(final quantity = "MolarFlowRate", unit = "mol/s") "Molar Combustion rate (CH4)";
  Real lambda "Stoichiometric ratio (>1 if air flow is greater than stoichiometric)";
protected
  Real Air_in_X[Air.nXi] = inStream(Air_in.Xi_outflow);
  Real Fuel_in_X[Fuel.nXi] = inStream(Fuel_in.Xi_outflow);
equation
  wcomb = wif * Fuel_in_X[3] / Fuel.data[3].MM "Combustion molar flow rate";
  lambda = wia * Air_in_X[1] / Air.data[1].MM / (2 * wcomb);
  assert(lambda >= 1, "Not enough oxygen flow");
  if constantCompositionExhaust then
    FlueGas_out.Xi_outflow[1:Exhaust.nXi] = Exhaust.reference_X[1:Exhaust.nXi] "Reference value for exhaust compostion";
  else
// True mass balances
    0 = wia * Air_in_X[1] + wout * FlueGas_out.Xi_outflow[1] - 2 * wcomb * Exhaust.data[1].MM "oxygen";
    0 = wia * Air_in_X[3] + wout * FlueGas_out.Xi_outflow[2] "argon";
    0 = wia * Air_in_X[2] + wout * FlueGas_out.Xi_outflow[3] + 2 * wcomb * Exhaust.data[3].MM "water";
    0 = wout * FlueGas_out.Xi_outflow[4] + wif * Fuel_in_X[2] + wcomb * Exhaust.data[4].MM "carbondioxide";
    0 = wia * Air_in_X[4] + wout * FlueGas_out.Xi_outflow[5] + wif * Fuel_in_X[1] "nitrogen";
  end if;
  annotation(
    Documentation(info = "<html>
This model extends <tt>GTunitBase</tt>, by adding the computation of the exhaust composition.

<p><b>Modelling options</b></p>
If <tt>constantCompositionExhaust = false</tt>, the exhaust composition is computed according to the exact mass balances; otherwise, the exhaust composition is held fixed to <tt>Exhaust.reference_X</tt>.
</html>", revisions = "<html>
<ul>
<li><i>7 Jun 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       GTunit models further restructured.</li>
</ul>
</html>"));
end GTunitExhaustBase;
