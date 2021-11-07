within PL_Lib.Configurations;
model ECS_CruisingTest
  extends Templates.ECS_lossless(
    redeclare Components.HX_extFun PHX,
    redeclare Components.HX_1DCoFlow SHX,
    redeclare Components.Compressor_noMaps compressor,
    redeclare Components.Turbine_noMaps turbine);
  Modelica.Blocks.Sources.Constant inputT_cold_in(k=273.15 + 20) annotation (Placement(visible=true, transformation(
        origin={-284,82},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputP_cold_in(k=101325) annotation (Placement(visible=true, transformation(
        origin={-284,52},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant inputT_hot_in(k=273.15 + 300) annotation (Placement(transformation(extent={{-294,-28},{-274,-8}})));
  Modelica.Blocks.Sources.Constant inputP_hot_in(k=101325*2) annotation (Placement(transformation(extent={{-294,-58},{-274,-38}})));
equation
  connect(inputT_cold_in.y, sourceP_RAin.in_T) annotation (Line(points={{-273,82},{-250,82},{-250,59}}, color={0,0,127}));
  connect(inputP_cold_in.y, sourceP_RAin.in_p0) annotation (Line(points={{-273,52},{-266,52},{-266,56.4},{-256,56.4}}, color={0,0,127}));
  connect(inputT_hot_in.y, sourceP_BAin.in_T) annotation (Line(points={{-273,-18},{-250,-18},{-250,-31}}, color={0,0,127}));
  connect(inputP_hot_in.y, sourceP_BAin.in_p0) annotation (Line(points={{-273,-48},{-266,-48},{-266,-24},{-256,-24},{-256,-33.6}}, color={0,0,127}));
end ECS_CruisingTest;
