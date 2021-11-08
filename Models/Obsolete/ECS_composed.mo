within PL_Lib.Models.Obsolete;
model ECS_composed
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{-200, 180}, {-180, 200}}, rotation = 0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  //  HX Geometry Parameters:
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Integer Nt = 20 "Number of tubes in parallel";
  parameter Modelica.SIunits.Length Lhex = 10 "total length";
  parameter Modelica.SIunits.Diameter Dihex = 0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex = Dihex / 2 "internal radius";
  parameter Modelica.SIunits.Length omegahex = Modelica.Constants.pi * Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex = Modelica.Constants.pi * rhex ^ 2 "internal cross section";
  parameter Real Cfhex = 0.005 "friction coefficient";
  //  Operating Conditions:
  parameter Modelica.SIunits.MassFlowRate whex_RA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.MassFlowRate whex_BA = 0.25 "nominal (and initial) mass flow rate";
  parameter Modelica.SIunits.Pressure phex_RA = 101325 "initial pressure";
  parameter Modelica.SIunits.Pressure phex_BA = 101325 * 2 "initial pressure";
  parameter Modelica.SIunits.Temperature Thex_in_RA = 273.15 + 20 "initial inlet temperature";
  parameter Modelica.SIunits.Temperature Thex_out_RA = 273.15 + 162 "initial outlet temperature";
  parameter Modelica.SIunits.Temperature Thex_in_BA = 273.15 + 200;
  parameter Modelica.SIunits.Temperature Thex_out_BA = 273.15 + 60;
  ThermoPower.Gas.SinkPressure sinkP_RAout1(redeclare package Medium = Medium, p0 = 101325, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-170, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-170, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow_BAin(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-140, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium, Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {0, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout2(redeclare package Medium = Medium, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(extent = {{120, -20}, {140, 0}}, rotation = 0)));

//  ThermoPower.Gas.Flow1DFV HEX1_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation(
  //    Placement(visible = true, transformation(extent = {{-100, -120}, {-80, -100}}, rotation = 0)));
  //  ThermoPower.Gas.Flow1DFV HEX1_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_RA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_RA) annotation(
  //    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  //  ThermoPower.Gas.Flow1DFV HEX2_BA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Nt = Nt, Tstartbar = Thex_in_BA, dpnom = 1000, fixedMassFlowSimplified = true, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, wnom = whex_BA) annotation(
  //    Placement(visible = true, transformation(extent = {{-60, -120}, {-40, -100}}, rotation = 0)));
  //  ThermoPower.Gas.Flow1DFV HEX2_RA(redeclare package Medium = Medium, A = Ahex, Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, Tstartbar = 273.15 + 20, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, omega = omegahex, pstart = phex_RA, wnom = whex_RA) annotation(
  //    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  //  ThermoPower.Thermal.MetalTubeFV metalTubeFV2(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
  //    Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(L = Lhex, Nt = Nt, Nw = Nnodes - 1, Tstart1 = Thex_in_BA, TstartN = Thex_in_BA, Tstartbar(displayUnit = "K") = Thex_in_BA, lambda = 20, rext = 0.012 / 2, rhomcm = 7800 * 650, rint = 0.01 / 2) annotation(
  //    Placement(visible = true, transformation(origin = {-90, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw = Nnodes - 1) annotation(
  //    Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-98, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(extent = {{150, -60}, {170, -40}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 10) annotation (
    Placement(visible = true, transformation(origin = {60, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Obsolete.HeatExchanger_CoFlow PHX(
    redeclare package GasMedium1 = Medium,
    redeclare package GasMedium2 = Medium,
    Thex_in_gas1=293.15,
    Thex_in_gas2=473.15,
    Thex_out_gas1=293.15,
    Thex_out_gas2=473.15,
    phex_gas2=200000,
    whex_gas1=0.25,
    whex_gas2=0.25) annotation (Placement(visible=true, transformation(
        origin={-60,-20},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  PL_Lib.Components.Obsolete.HeatExchanger_CoFlow SHX(
    redeclare package GasMedium1 = Medium,
    redeclare package GasMedium2 = Medium,
    Thex_in_gas2=473.15,
    Thex_out_gas2=473.15,
    phex_gas1=99999.99999999999,
    phex_gas2=499999.9999999999,
    whex_gas1=0.25,
    whex_gas2=0.25) annotation (Placement(visible=true, transformation(
        origin={60,-20},
        extent={{-20,-20},{20,20}},
        rotation=0)));
protected
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePRC[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
initial equation
  inertia.w = 523.3;
equation
  connect(sourceP_BAin.flange, throughMassFlow_BAin.inlet) annotation (
    Line(points = {{-160, -30}, {-150, -30}}, color = {159, 159, 223}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{12, -80}, {50, -80}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{70, -80}, {108, -80}}));
  connect(PHX.gas1_out, sinkP_RAout1.flange) annotation (
    Line(points = {{-40, -10}, {-20, -10}}, color = {159, 159, 223}));
  connect(throughMassFlow_BAin.outlet, PHX.gas2_in) annotation (
    Line(points = {{-130, -30}, {-80, -30}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, PHX.gas1_in) annotation (
    Line(points = {{-160, 10}, {-120, 10}, {-120, -10}, {-80, -10}}, color = {159, 159, 223}));
  connect(PHX.gas2_out, Compressor.inlet) annotation (
    Line(points = {{-40, -30}, {-30, -30}, {-30, -64}, {-16, -64}}, color = {159, 159, 223}));
  connect(Compressor.outlet, SHX.gas2_in) annotation (
    Line(points = {{16, -64}, {28, -64}, {28, -30}, {40, -30}}, color = {159, 159, 223}));
  connect(SHX.gas2_out, Turbine.inlet) annotation (
    Line(points = {{80, -30}, {90, -30}, {90, -64}, {104, -64}}, color = {159, 159, 223}));
  connect(Turbine.outlet, sinkPressure.flange) annotation (
    Line(points = {{136, -64}, {144, -64}, {144, -50}, {150, -50}}, color = {159, 159, 223}));
  connect(SHX.gas1_out, sinkP_RAout2.flange) annotation (
    Line(points = {{80, -10}, {120, -10}}, color = {159, 159, 223}));
  connect(throughMassFlow.outlet, SHX.gas1_in) annotation (
    Line(points = {{-88, 10}, {20, 10}, {20, -10}, {40, -10}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, throughMassFlow.inlet) annotation (
    Line(points = {{-160, 10}, {-108, 10}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics={  Text(origin = {-170, -50}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", horizontalAlignment = TextAlignment.Left), Text(origin = {-170, 30}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)",
            horizontalAlignment =                                                                                                                                                                                                        TextAlignment.Left)}),
    experiment(StopTime = 3000, Tolerance = 1e-06, StartTime = 0, Interval = 6),
    Documentation(info = "<html>
<p>The model is designed to test the component <code>Gas.Flow1DFV</code> (fluid side of a heat exchanger, finite volumes). A uniform prescribed heat flux is applied to the lateral boundary. The working fluid is pure nitrogen.</p>
<p>The model starts at steady state. </p>
<p><ul>
<li>At t = 10 s, step variation of the temperature of the fluid entering the heat exchanger. The temperature change is propagated at the outlet with a delay approximately equal to the residence time</li>
<li>At t = 20 s, a thermal power flow W is applied to the heat exchanger lateral surface. The outlet temperature undergoes a ramp change, whose duration is approximately equal to the residence time, and whose amplitude is equal to W/(whex*cp)</li>
<li>At t = 50 s, step reduction of the outlet valve opening</li>
</ul></p>
<p>Simulation Interval = [0...80] sec </p>
<p>Integration Algorithm = DASSL </p>
<p>Algorithm Tolerance = 1e-6 </p>
</html>"),
    __Dymola_experimentSetupOutput);
end ECS_composed;
