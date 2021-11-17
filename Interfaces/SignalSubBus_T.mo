within PL_Lib.Interfaces;
expandable connector SignalSubBus_T "Signal sub-bus for temperature signal readings"
  extends Modelica.Icons.SignalSubBus;
  import SI = Modelica.SIunits;
  SI.Temperature T_BA_PHXin;
  SI.Temperature T_BA_PHXout;
  SI.Temperature T_BA_SHXin;
  SI.Temperature T_BA_SHXout;
  SI.Temperature T_BA_PACKout;
  SI.Temperature T_RA_PHXin;
  SI.Temperature T_RA_PHXout;
  SI.Temperature T_RA_SHXin;
  SI.Temperature T_RA_SHXout;
end SignalSubBus_T;
