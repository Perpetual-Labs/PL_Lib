within PL_Lib.Icons;
class C_icon
  annotation (Icon(graphics={
        Polygon(
          points={{-80,40},{-80,-40},{0,-92},{80,-40},{80,40},{0,92}},
          fillColor={100,153,209},
          fillPattern=FillPattern.Solid,
          lineColor={162,29,33},
          pattern=LinePattern.None),
        Polygon(
          points={{-80,-40},{0,-92},{80,-40},{0,0},{-80,-40}},
          fillColor={0,68,130},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-45,45},{45,-45}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          lineThickness=1),
        Polygon(
          points={{0,0},{80,40},{80,-40}},
          fillColor={0,89,156},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-25,25},{25,-25}},
          fillColor={100,153,209},
          fillPattern=FillPattern.Solid,
          startAngle=154,
          endAngle=334,
          lineThickness=1,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-25,25},{25,-25}},
          fillColor={0,68,130},
          fillPattern=FillPattern.Solid,
          startAngle=26,
          endAngle=154,
          lineThickness=1,
          pattern=LinePattern.None,
          lineColor={0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio=true)));
end C_icon;
