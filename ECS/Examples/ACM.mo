within PL_Lib.ECS.Examples;

model ACM
  ThermoCycle.Components.Units.ExpansionAndCompressionMachines.Compressor compressor1 annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.Units.ExpansionAndCompressionMachines.SteamTurbine steamTurbine annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 0.8)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoCycle.Components.Units.HeatExchangers.Hx1D PHX annotation(
    Placement(visible = true, transformation(origin = {-54, 50}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  ThermoCycle.Components.Units.HeatExchangers.Hx1D SHX annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe1 annotation(
    Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe2 annotation(
    Placement(visible = true, transformation(origin = {-58, 8}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe3 annotation(
    Placement(visible = true, transformation(origin = {-110, 38}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe4 annotation(
    Placement(visible = true, transformation(origin = {-10, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe5 annotation(
    Placement(visible = true, transformation(origin = {82, -24}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe6 annotation(
    Placement(visible = true, transformation(origin = {22, 30}, extent = {{-12, -12}, {12, 12}}, rotation = -90)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe8 annotation(
    Placement(visible = true, transformation(origin = {80, 46}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Pipes.Flow1Dim pipe7 annotation(
    Placement(visible = true, transformation(origin = {82, 8}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Reservoirs.SourceMdot sourceMdot(Mdot_0 = 0.09)  annotation(
    Placement(visible = true, transformation(origin = {-140, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Reservoirs.SourceMdot sourceMdot2(Mdot_0 = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-140, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Reservoirs.SinkP sinkP1 annotation(
    Placement(visible = true, transformation(origin = {128, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoCycle.Components.FluidFlow.Reservoirs.SinkP sinkP2 annotation(
    Placement(visible = true, transformation(origin = {128, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(compressor1.flange_elc, inertia1.flange_a) annotation(
    Line(points = {{-20, 0}, {-10, 0}}));
  connect(inertia1.flange_b, steamTurbine.shaft_a) annotation(
    Line(points = {{10, 0}, {23, 0}}));
  connect(pipe1.OutFlow, PHX.inlet_fl2) annotation(
    Line(points = {{-100, 70}, {-30, 70}, {-30, 56}, {-44, 56}}, color = {0, 0, 255}));
  connect(pipe2.OutFlow, compressor1.InFlow) annotation(
    Line(points = {{-48, 8}, {-43, 8}, {-43, 10}, {-38, 10}}, color = {0, 0, 255}));
  connect(PHX.outlet_fl2, pipe2.InFlow) annotation(
    Line(points = {{-64, 56}, {-80, 56}, {-80, 8}, {-68, 8}}, color = {0, 0, 255}));
  connect(pipe3.OutFlow, PHX.inlet_fl1) annotation(
    Line(points = {{-100, 38}, {-75, 38}, {-75, 45}, {-64, 45}}, color = {0, 0, 255}));
  connect(PHX.outlet_fl1, pipe4.InFlow) annotation(
    Line(points = {{-44, 45}, {-29, 45}, {-29, 40}, {-20, 40}}, color = {0, 0, 255}));
  connect(pipe4.OutFlow, SHX.inlet_fl1) annotation(
    Line(points = {{0, 40}, {11, 40}, {11, 45}, {40, 45}}, color = {0, 0, 255}));
  connect(compressor1.OutFlow, pipe5.InFlow) annotation(
    Line(points = {{-20, -5}, {-20, -24}, {72, -24}}, color = {0, 0, 255}));
  connect(pipe5.OutFlow, SHX.inlet_fl2) annotation(
    Line(points = {{92, -24}, {108, -24}, {108, 56}, {60, 56}}, color = {0, 0, 255}));
  connect(SHX.outlet_fl2, pipe6.InFlow) annotation(
    Line(points = {{40, 56}, {22, 56}, {22, 40}}, color = {0, 0, 255}));
  connect(pipe6.OutFlow, steamTurbine.inlet) annotation(
    Line(points = {{22, 20}, {23, 20}, {23, 8}}, color = {0, 0, 255}));
  connect(SHX.outlet_fl1, pipe8.InFlow) annotation(
    Line(points = {{60, 46}, {70, 46}}, color = {0, 0, 255}));
  connect(pipe8.OutFlow, sinkP1.flangeB) annotation(
    Line(points = {{90, 46}, {120, 46}}, color = {0, 0, 255}));
  connect(steamTurbine.outlet, pipe7.InFlow) annotation(
    Line(points = {{36, 8}, {72, 8}}, color = {0, 0, 255}));
  connect(pipe7.OutFlow, sinkP2.flangeB) annotation(
    Line(points = {{92, 8}, {120, 8}}, color = {0, 0, 255}));
  connect(sourceMdot.flangeB, pipe1.InFlow) annotation(
    Line(points = {{-130, 70}, {-120, 70}}, color = {0, 0, 255}));
  connect(sourceMdot2.flangeB, pipe3.InFlow) annotation(
    Line(points = {{-131, 38}, {-120, 38}}, color = {0, 0, 255}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {2, 0}, pattern = LinePattern.Dash, extent = {{-44, 16}, {44, -16}})}));
end ACM;
