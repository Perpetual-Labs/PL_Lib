within PL_Lib.Icons;
model Configuration_icon
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={0,86,134},
          extent={{-100,-100},{100,100}},
          radius=25,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-28,0},{30,0}}, color={0,86,134}),
        Rectangle(
          extent={{-30,40},{-80,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-22,8},{-38,-8}},
          lineColor={0,86,134},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,40},{30,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{38,8},{22,-8}},
          lineColor={0,86,134},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-120},{100,-160}},
          textColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Configuration_icon;
