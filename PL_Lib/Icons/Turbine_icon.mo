within PL_Lib.Icons;
model Turbine_icon
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-28,76},{-28,28},{-22,28},{-22,82},{-60,82},{-60,76},{-28,76}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{26,56},{32,56},{32,76},{60,76},{60,82},{26,82},{26,56}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,8},{60,-8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Polygon(
          points={{-28,28},{-28,-26},{32,-60},{32,60},{-28,28}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-120},{100,-160}},
          lineColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Turbine_icon;
