within PL_Lib.Interfaces;
expandable connector SignalSubBus_p "Signal sub-bus for pressure signal readings"
  extends Modelica.Icons.SignalSubBus;
  import SI = Modelica.SIunits;

  SI.Pressure PHXin_hot;
  SI.Pressure PHXout_hot;
  SI.Pressure SHXin_hot;
  SI.Pressure SHXout_hot;

  SI.Pressure PACKout_hot;

  SI.Pressure PHXin_cold;
  SI.Pressure PHXout_cold;
  SI.Pressure SHXin_cold;
  SI.Pressure SHXout_cold;
end SignalSubBus_p;
