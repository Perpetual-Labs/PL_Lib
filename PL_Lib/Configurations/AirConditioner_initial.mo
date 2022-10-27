within PL_Lib.Configurations;
model AirConditioner_initial
  extends PL_Lib.Icons.Configuration_icon;
  extends ecs_case_study_mo.AirConditioner_partial(redeclare PL_Lib.Components.HeatExchanger_supplied heatExchanger(heatExchangerMass=30), redeclare PL_Lib.Components.Compressor_supplied compressor(compressorMass=25));
protected
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_shaft, w(start=w0, fixed=false)) annotation (Placement(transformation(origin={70,-10}, extent={{-10,-10},{10,10}})));
  parameter Modelica.SIunits.Inertia J_shaft=200;
  parameter Modelica.SIunits.AngularVelocity w0=523.3;
equation
  acMass = heatExchanger.heatExchangerMass + compressor.compressorMass;
  connect(compressor.shaft_b, inertia.flange_a) annotation (Line(points={{36,0},{54,0},{54,-10},{60,-10}}, color={0,0,0}));
  annotation (Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          textColor={217,67,180},
          textString="Initial")}));
end AirConditioner_initial;
