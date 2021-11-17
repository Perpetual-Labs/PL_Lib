within PL_Lib.Icons;
model ConfigurationHybrid_icon
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={0,86,134},
          extent={{-100,-100},{100,100}},
          radius=25,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-28,0},{30,0}}, color={0,86,134}),
        Rectangle(extent={{-30,40},{-80,-40}}, lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-22,8},{-38,-8}},
          lineColor={0,86,134},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,8},{0,-8},{8,0},{0,8}},
          lineColor={217,67,180},
          fillColor={217,67,180},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,8},{-8,0},{0,-8},{0,8}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{10,0},{24,0}},color={217,67,180}),                                Rectangle(
          extent={{80,40},{30,-40}},
          lineColor={217,67,180},
          fillColor={255,255,255},
          fillPattern=FillPattern.CrossDiag),Rectangle(
          extent={{38,8},{22,-8}},
          lineColor={217,67,180},
          fillColor={217,67,180},
          fillPattern=FillPattern.Solid)}),                           Diagram(coordinateSystem(preserveAspectRatio=false)));
end ConfigurationHybrid_icon;
