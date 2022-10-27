within PL_Lib.Components;
model Turbine_initial
  extends PL_Lib.Icons.Turbine_icon;
  extends ecs_case_study_mo.Turbine;
equation
  connect(TurbineInlet, TurbineOutlet) annotation (Line(points={{-100,50},{100,50}}, color={0,0,0}));
end Turbine_initial;
