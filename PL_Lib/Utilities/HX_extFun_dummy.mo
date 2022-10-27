within PL_Lib.Utilities;
model HX_extFun_dummy
  extends PL_Lib.Icons.ExtFun_icon;
  extends PL_Lib.Interfaces.HeatExchangerCausal;
  Real temperatures[2];
  Real pressures[2];
  Real t;
equation
  t = time;
  (temperatures,pressures) = hxDummy(
    T_cold_in,
    T_hot_in,
    w_cold_in,
    w_hot_in,
    p_cold_in,
    p_hot_in,
    d_cold_in,
    d_hot_in,
    t);

  T_cold_out = temperatures[1];
  T_hot_out = temperatures[2];
  p_cold_out = pressures[1];
  p_hot_out = pressures[2];

  annotation (Icon(coordinateSystem(extent={{-100,-140},{100,140}})), Diagram);
end HX_extFun_dummy;
