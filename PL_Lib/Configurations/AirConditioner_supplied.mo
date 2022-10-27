within PL_Lib.Configurations;
model AirConditioner_supplied
  extends PL_Lib.Icons.ConfigurationHybrid_icon;
  extends ecs_case_study_mo.AirConditioner_full(
    redeclare PL_Lib.Components.HeatExchanger_supplied heatExchangerPrimary(heatExchangerMass=30),
    redeclare PL_Lib.Components.HeatExchanger_supplied heatExchangerSecondary(heatExchangerMass=30),
    redeclare PL_Lib.Components.Compressor_supplied compressor(compressorMass=25),
    redeclare Components.Turbine_supplied turbine(turbineMass=10));

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(transformation(origin={30,-30}, extent={{-10,-10},{10,10}})));
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  acMass = heatExchangerPrimary.heatExchangerMass + compressor.compressorMass + heatExchangerSecondary.heatExchangerMass + turbine.turbineMass;
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{-14,-30},{20,-30}}, color={0,0,0}));
  connect(turbine.shaft_a, inertia.flange_b) annotation (Line(points={{64,-30},{40,-30}}, color={0,0,0}));
  annotation (Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          textColor={217,67,180},
          textString="Supplied")}));
end AirConditioner_supplied;
