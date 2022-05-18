within PL_Lib.ModelsWIP;
model ECS1to5_composed
  extends Modelica.Icons.Example;
  inner ThermoPower.System system annotation (
    Placement(visible = true, transformation(extent = {{-300, 180}, {-280, 200}}, rotation = 0)));
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
  parameter Modelica.SIunits.Temperature Thex_in_BA = 273.15 + 300;
  parameter Modelica.SIunits.Temperature Thex_out_BA = 273.15 + 60;
  //  parameter Temperature deltaT=10 "height of temperature step";
  //  parameter Modelica.SIunits.EnergyFlowRate W = 500 "height of power step";
  //  Real gamma = Medium.specificHeatCapacityCp(hex.gas[1].state) / Medium.specificHeatCapacityCv(hex.gas[1].state) "cp/cv";
  //  Real dMtot_dp = hex.Mtot / (hex.p * gamma) "compressibility";
  //  Real dw_dp = valve.Kv "sensitivity of valve flow to pressure";
  //  Modelica.SIunits.Time tau = dMtot_dp / dw_dp "time constant of pressure transient";
  //  Modelica.SIunits.Mass Mhex "Mass in the heat exchanger";
  //  Modelica.SIunits.Mass Mbal "Mass resulting from the mass balance";
  //  Modelica.SIunits.Mass Merr(min = -1e9) "Mass balance error";
  Modelica.Blocks.Sources.Ramp ramp_T_RAin(duration = 600, height = -45, offset = Thex_in_RA, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-360, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P_RAin(duration = 600, height = -74825, offset = 101325, startTime = 300) annotation (
    Placement(visible = true, transformation(origin = {-360, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout1(redeclare package Medium = Medium, p0 = 101325, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {-76, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_RAin(redeclare package Medium = Medium, T = 273.15 + 20, p0 = 101325, use_in_T = true, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(origin = {-336, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourcePressure sourceP_BAin(redeclare package Medium = Medium, T = Thex_in_BA, p0 = phex_BA, use_in_T = false, use_in_p0 = false) annotation (
    Placement(visible = true, transformation(origin = {-340, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PL_Lib.Components.Compressor_noMaps Compressor(redeclare package Medium = Medium, Ndesign = 523.3, PR_set = 2.5, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 273.15 + 90, Tstart_in = 273.15 + 90, Tstart_out = 273.15 + 200, eta_set = 0.9, pstart_in = 2e5, pstart_out = 5e5, tableEta = tableEtaC, tablePR = tablePRC, tablePhic = tablePhicC) annotation (
    Placement(visible = true, transformation(origin = {-70, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkP_RAout2(redeclare package Medium = Medium, use_in_p0 = true) annotation (
    Placement(visible = true, transformation(extent = {{116, 0}, {136, 20}}, rotation = 0)));
  PL_Lib.Components.Turbine_noMaps Turbine(redeclare package Medium = Medium, Ndesign = 523.3, Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, Tdes_in = 1400, Tstart_in = 1270, Tstart_out = 883, pstart_in = 7.85e5, pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) annotation (
    Placement(visible = true, transformation(origin = {160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 10) annotation (
    Placement(visible = true, transformation(origin = {30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.Mixer Mixer(redeclare package Medium = Medium, S = 1, Tstart = 273.15 + 20, V = 3, gamma = 0.8, noInitialPressure = false, noInitialTemperature = false, pstart = 101325) annotation (
    Placement(visible = true, transformation(extent = {{270, -40}, {290, -20}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {340, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure sinkPressure(redeclare package Medium = Medium, T = 273.15 + 22) annotation (
    Placement(visible = true, transformation(origin = {380, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Tcabin_set(height = 5, offset = 273.15 + 20, startTime = 1000) annotation (
    Placement(visible = true, transformation(origin = {320, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin(redeclare package Medium = Medium, R = 100) annotation (
    Placement(visible = true, transformation(origin = {310, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ValveLin valve_Tcontrol(redeclare package Medium = Medium, Kv = 1) annotation (
    Placement(visible = true, transformation(origin = {240, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PIDcontrol(Td = 0, Ti = 60, k = 0.4, limitsAtInit = true, withFeedForward = false, yMax = 0.25) annotation (
    Placement(visible = true, transformation(origin = {360, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow1(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-210, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow3(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-250, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.ThroughMassFlow throughMassFlow(redeclare package Medium = Medium, w0 = 0.25) annotation (
    Placement(visible = true, transformation(origin = {-250, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0, offset = 0, startTime = 1000) annotation (
    Placement(visible = true, transformation(origin = {220, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Obsolete.HX PHX(
    redeclare package Medium = Medium,
    Nnodes=Nnodes,
    Nt=Nt,
    Cfhex=Cfhex,
    HX_hotSide(
      A=Ahex,
      Dhyd=Dihex,
      L=Lhex,
      Tstartbar=Thex_in_BA,
      omega=omegahex,
      wnom=whex_BA),
    HX_coldSide(
      A=Ahex,
      Dhyd=Dihex,
      L=Lhex,
      Tstartbar=Thex_in_RA,
      omega=omegahex,
      wnom=whex_RA),
    metalTubeFV1(
      L=Lhex,
      Tstart1=Thex_in_BA,
      TstartN=Thex_in_BA,
      Tstartbar(displayUnit="K") = Thex_in_BA)) annotation (Placement(transformation(rotation=0, extent={{-220,-20},{-180,20}})));
  Components.Obsolete.HX SHX(
    redeclare package Medium = Medium,
    Nnodes=Nnodes,
    Nt=Nt,
    Cfhex=Cfhex,
    HX_hotSide(
      A=Ahex,
      Dhyd=Dihex,
      L=Lhex,
      Tstartbar=Thex_in_BA,
      omega=omegahex,
      wnom=whex_BA),
    HX_coldSide(
      A=Ahex,
      Dhyd=Dihex,
      L=Lhex,
      Tstartbar=Thex_in_RA,
      omega=omegahex,
      wnom=whex_RA),
    metalTubeFV1(
      L=Lhex,
      Tstart1=Thex_in_BA,
      TstartN=Thex_in_BA,
      Tstartbar(displayUnit="K") = Thex_in_BA)) annotation (Placement(transformation(rotation=0, extent={{40,-20},{80,20}})));
  ThermoPower.Gas.SensT sensT1(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-280, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT2(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {-160, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT3(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {10, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT4(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {98, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  ThermoPower.Gas.SensT sensT5(redeclare package Medium = Medium) annotation (
    Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin1(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-310, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin2(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-130, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin3(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {-22, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin4(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {120, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.PressDropLin pressDropLin5(redeclare package Medium = Medium, R = 1000) annotation (
    Placement(visible = true, transformation(origin = {242, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real tableEtaC[6, 4] = [0, 95, 100, 105; 1, 82.5e-2, 81e-2, 80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4, 82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4] = [0, 95, 100, 105; 1, 38.3e-3, 43e-3, 46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3; 4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePRC[6, 4] = [0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22, 26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tablePhicT[5, 4] = [1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3, 4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3, 4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4] = [1, 90, 100, 110; 2.36, 89e-2, 89.5e-2, 89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2, 90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
initial equation
  inertia.w = 523.3;
equation
  connect(ramp_T_RAin.y, sourceP_RAin.in_T) annotation (
    Line(points = {{-349, 100}, {-336, 100}, {-336, 59}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sourceP_RAin.in_p0) annotation (
    Line(points = {{-349, 70}, {-342, 70}, {-342, 56.4}}, color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sinkP_RAout1.in_p0) annotation (
    Line(points={{-349,70},{-82.45,70},{-82.45,15.95}},
                                                      color = {0, 0, 127}));
  connect(ramp_P_RAin.y, sinkP_RAout2.in_p0) annotation (
    Line(points={{-349,70},{119.55,70},{119.55,15.95}},
                                                      color = {0, 0, 127}));
  connect(Compressor.shaft_b, inertia.flange_a) annotation (
    Line(points = {{-58, -60}, {20, -60}}));
  connect(inertia.flange_b, Turbine.shaft_a) annotation (
    Line(points = {{40, -60}, {148, -60}}));
  connect(sensT.outlet, sinkPressure.flange) annotation (
    Line(points = {{346, -30}, {370, -30}}, color = {159, 159, 223}));
  connect(Mixer.out, pressDropLin.inlet) annotation (
    Line(points = {{290, -30}, {300, -30}}, color = {159, 159, 223}));
  connect(pressDropLin.outlet, sensT.inlet) annotation (
    Line(points = {{320, -30}, {334, -30}}, color = {159, 159, 223}));
  connect(valve_Tcontrol.outlet, Mixer.in1) annotation (
    Line(points = {{250, -20}, {260, -20}, {260, -24}, {272, -24}}, color = {159, 159, 223}));
  connect(Tcabin_set.y, PIDcontrol.u_s) annotation (
    Line(points = {{331, 10}, {348, 10}}, color = {0, 0, 127}));
  connect(sensT.T, PIDcontrol.u_m) annotation (
    Line(points = {{347, -20}, {360, -20}, {360, -2}}, color = {0, 0, 127}));
  connect(step.y, valve_Tcontrol.cmd) annotation (
    Line(points = {{231, 10}, {240, 10}, {240, -13}}, color = {0, 0, 127}));
  connect(throughMassFlow.outlet, PHX.infl1) annotation (
    Line(points = {{-240, 10}, {-220, 10}}, color = {159, 159, 223}));
  connect(throughMassFlow3.outlet, PHX.infl2) annotation (
    Line(points = {{-240, -40}, {-230, -40}, {-230, -10}, {-220, -10}}, color = {159, 159, 223}));
  connect(PHX.outfl1, sinkP_RAout1.flange) annotation (
    Line(points = {{-180, 10}, {-86, 10}}, color = {159, 159, 223}));
  connect(sensT1.outlet, throughMassFlow3.inlet) annotation (
    Line(points = {{-274, -40}, {-260, -40}}, color = {159, 159, 223}));
  connect(PHX.outfl2, sensT2.inlet) annotation (
    Line(points = {{-180, -10}, {-166, -10}}, color = {159, 159, 223}));
  connect(SHX.infl2, sensT3.outlet) annotation (
    Line(points = {{40, -10}, {16, -10}}, color = {159, 159, 223}));
  connect(SHX.outfl2, sensT4.inlet) annotation (
    Line(points = {{80, -10}, {94, -10}, {94, -20}}, color = {159, 159, 223}));
  connect(Turbine.outlet, sensT5.inlet) annotation (
    Line(points = {{176, -44}, {204, -44}}, color = {159, 159, 223}));
  connect(SHX.outfl1, sinkP_RAout2.flange) annotation (
    Line(points = {{80, 10}, {116, 10}}, color = {159, 159, 223}));
  connect(throughMassFlow1.outlet, SHX.infl1) annotation (
    Line(points = {{-200, 50}, {-12, 50}, {-12, 10}, {40, 10}}, color = {159, 159, 223}));
  connect(sourceP_BAin.flange, pressDropLin1.inlet) annotation (
    Line(points = {{-330, -40}, {-320, -40}}, color = {159, 159, 223}));
  connect(pressDropLin1.outlet, sensT1.inlet) annotation (
    Line(points = {{-300, -40}, {-286, -40}}, color = {159, 159, 223}));
  connect(sensT2.outlet, pressDropLin2.inlet) annotation (
    Line(points = {{-154, -10}, {-140, -10}}, color = {159, 159, 223}));
  connect(pressDropLin2.outlet, Compressor.inlet) annotation (
    Line(points = {{-120, -10}, {-96, -10}, {-96, -44}, {-86, -44}}, color = {159, 159, 223}));
  connect(sensT3.inlet, pressDropLin3.outlet) annotation (
    Line(points = {{4, -10}, {-12, -10}}, color = {159, 159, 223}));
  connect(pressDropLin3.inlet, Compressor.outlet) annotation (
    Line(points = {{-32, -10}, {-44, -10}, {-44, -44}, {-54, -44}}, color = {159, 159, 223}));
  connect(sensT4.outlet, pressDropLin4.inlet) annotation (
    Line(points = {{94, -32}, {94, -44}, {110, -44}}, color = {159, 159, 223}));
  connect(pressDropLin4.outlet, Turbine.inlet) annotation (
    Line(points = {{130, -44}, {144, -44}}, color = {159, 159, 223}));
  connect(sensT5.outlet, pressDropLin5.inlet) annotation (
    Line(points = {{216, -44}, {232, -44}}, color = {159, 159, 223}));
  connect(pressDropLin5.outlet, Mixer.in2) annotation (
    Line(points = {{252, -44}, {264, -44}, {264, -36}, {272, -36}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, throughMassFlow1.inlet) annotation (
    Line(points = {{-326, 50}, {-220, 50}}, color = {159, 159, 223}));
  connect(sourceP_RAin.flange, throughMassFlow.inlet) annotation (
    Line(points = {{-326, 50}, {-270, 50}, {-270, 10}, {-260, 10}}, color = {159, 159, 223}));
  annotation (
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}}), graphics={  Text(origin = {-330, -20}, lineColor = {170, 0, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Bleed air (hot side)", horizontalAlignment = TextAlignment.Left), Text(origin = {-330, 30}, lineColor = {0, 85, 255}, extent = {{-30, 10}, {30, -10}}, textString = "Ram air (cold side)",
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
end ECS1to5_composed;
