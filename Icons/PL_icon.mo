within PL_Lib.Icons;
model PL_icon
  extends Modelica.Icons.Package;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={        Line(
          points={{0,50},{0,-50}},
          color={95,95,95},
          thickness=1),
        Line(
          points={{-50,0},{50,0}},
          color={95,95,95},
          thickness=1),
        Ellipse(
          extent={{0,100},{100,0}},
          lineColor={95,95,95},
          startAngle=180,
          endAngle=450,
          closure=EllipseClosure.None,
          lineThickness=1),
        Ellipse(
          extent={{0,-100},{-100,0}},
          lineColor={95,95,95},
          startAngle=180,
          endAngle=450,
          closure=EllipseClosure.None,
          lineThickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PL_icon;
