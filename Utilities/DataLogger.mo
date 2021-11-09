within PL_Lib.Utilities;
model DataLogger
  extends Modelica.Icons.RoundSensor;
  extends PL_Lib.Interfaces.DataLoggerBase;
  annotation (Icon(graphics={Line(points={{-70,0},{-90,0}}), Text(
          extent={{-80,-60},{80,-100}},
          textColor={28,108,200},
          textString="%name")}));
end DataLogger;
