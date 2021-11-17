within PL_Lib.Interfaces;
expandable connector SignalSubBus_p "Signal sub-bus for pressure signal readings"
  extends Modelica.Icons.SignalSubBus;
  import SI = Modelica.SIunits;
  SI.Pressure p_BA_PHXin;
  SI.Pressure p_BA_PHXout;
  SI.Pressure p_BA_SHXin;
  SI.Pressure p_BA_SHXout;
  SI.Pressure p_BA_PACKout;
  SI.Pressure p_RA_PHXin;
  SI.Pressure p_RA_PHXout;
  SI.Pressure p_RA_SHXin;
  SI.Pressure p_RA_SHXout;
end SignalSubBus_p;
