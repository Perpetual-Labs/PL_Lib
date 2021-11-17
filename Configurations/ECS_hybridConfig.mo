within PL_Lib.Configurations;
model ECS_hybridConfig
  extends PL_Lib.Icons.ConfigurationHybrid_icon;
  parameter Modelica.SIunits.MassFlowRate whex_cold "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_hot "nominal (and initial) mass flow rate";
  extends Templates.ECS_lossless(
    redeclare Components.HX_extFun_dummy PHX,
    redeclare Components.HX_1DCounterFlow SHX(wnom_c=whex_cold, wnom_h=whex_hot),
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine,
    throughMassFlow_RAin(w0=whex_cold*2),
    throughMassFlow_RA_SHXin(w0=whex_cold),
    throughMassFlow_BAin(w0=whex_hot));
  annotation (Diagram(coordinateSystem(extent={{-300,-100},{300,100}})), Icon(graphics={Rectangle(
          extent={{80,40},{30,-40}},
          lineColor={217,67,180},
          fillColor={255,255,255},
          fillPattern=FillPattern.CrossDiag),Rectangle(
          extent={{38,8},{22,-8}},
          lineColor={217,67,180},
          fillColor={217,67,180},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-10,12},{-10,12}}, lineColor={28,108,200}),
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
        Line(points={{8,0},{22,0}}, color={217,67,180})}));
end ECS_hybridConfig;
