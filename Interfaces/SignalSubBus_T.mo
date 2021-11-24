within PL_Lib.Interfaces;
expandable connector SignalSubBus_T "Signal sub-bus for temperature signal readings"
  extends Modelica.Icons.SignalSubBus;
  import SI = Modelica.SIunits;

  SI.Temperature PHXin_hot;
  SI.Temperature PHXout_hot;
  SI.Temperature SHXin_hot;
  SI.Temperature SHXout_hot;

  SI.Temperature PACKout_hot;

  SI.Temperature PHXin_cold;
  SI.Temperature PHXout_cold;
  SI.Temperature SHXin_cold;
  SI.Temperature SHXout_cold;
  
  SI.Temperature MIXout_hot;
end SignalSubBus_T;
