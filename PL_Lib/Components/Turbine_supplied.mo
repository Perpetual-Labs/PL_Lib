within PL_Lib.Components;
model Turbine_supplied
  extends PL_Lib.Icons.Turbine_icon;
  extends ecs_case_study_mo.Turbine;
  PL_Lib.Components.Turbine_noMaps turbine(
    redeclare package Medium = turbineMedium,
    Tdes_in=573.15,
    Tstart_out=573.15, eta_set = 0.41, phic_set = 1.2e-6,
    pstart_in=100000,
    pstart_out=100000) annotation (choicesAllMatching=true, Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (Placement(transformation(extent={{-70,-10},{-50,10}}), iconTransformation(extent={{-70,-10},{-50,10}})));
equation
  connect(TurbineInlet, turbine.inlet) annotation (Line(points={{-100,50},{-32,50},{-32,32}}, color={0,0,0}));
  connect(TurbineOutlet, turbine.outlet) annotation (Line(points={{100,50},{32,50},{32,32}}, color={0,0,0}));
  connect(turbine.shaft_a, shaft_a) annotation (Line(points={{-24,0},{-60,0}}, color={0,0,0}));
end Turbine_supplied;
