within PL_Lib.Icons;
model HeatExchanger_icon
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={89,89,89},
          fillColor={236,236,236},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          extent={{-100,100},{100,-100}},
          radius=30),
        Line(
          points={{0,-80},{0,-40},{40,-20},{-40,20},{0,40},{0,80}},
          color={85,0,255},
          thickness=0.5),
        Text(
          extent={{-100,-120},{100,-160}},
          textColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatExchanger_icon;
