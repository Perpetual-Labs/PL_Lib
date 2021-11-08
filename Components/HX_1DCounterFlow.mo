within PL_Lib.Components;
model HX_1DCounterFlow
  extends PL_Lib.Interfaces.HeatExchangerBase;
  extends PL_Lib.Icons.HeatExchanger_icon;

//  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer Nnodes=10 "number of Nodes";
  parameter Integer Nt=20 "Number of tubes in parallel";
  parameter Real Cfhex=0.005 "friction coefficient";
  parameter Modelica.SIunits.Length Lhex=10 "total length";
  parameter Modelica.SIunits.Diameter Dihex=0.02 "internal diameter";
  parameter Modelica.SIunits.Radius rhex=Dihex/2 "internal radius";
  parameter Modelica.SIunits.Length omegahex=Modelica.Constants.pi*Dihex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex=Modelica.Constants.pi*rhex^2 "internal cross section";

  ThermoPower.Gas.Flow1DFV HX_hotSide(redeclare package Medium = HotFluid, A = Ahex,
    omega=omegahex,
    wnom=0.1,                                                                        Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, noInitialPressure = false) annotation (Placement(visible=true, transformation(extent={{-10,-60},{10,-40}}, rotation=0)));
  ThermoPower.Gas.Flow1DFV HX_coldSide(redeclare package Medium = ColdFluid, A = Ahex,
    omega=omegahex,
    wnom=0.1,                                                                          Cfnom = Cfhex, Dhyd = Dihex, FFtype = ThermoPower.Choices.Flow1D.FFtypes.Cfnom, L = Lhex, N = Nnodes, dpnom = 1000, initOpt = ThermoPower.Choices.Init.Options.steadyState, noInitialPressure = false) annotation (Placement(visible=true, transformation(
        origin={0,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(
    L = Lhex,Nt=Nt,
    Nw=Nnodes - 1,
    lambda=20,
    rext=0.012/2,
    rhomcm=7800*650,
    rint=0.01/2) annotation (Placement(visible=true, transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw=Nnodes - 1, redeclare model HeatExchangerTopology = ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow)
                                                                                      annotation (Placement(visible=true, transformation(
        origin={0,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));

equation
  connect(infl_1, HX_coldSide.infl) annotation (Line(points={{-100,50},{-10,50}}, color={159,159,223}));
  connect(HX_coldSide.outfl, outfl_1) annotation (Line(points={{10,50},{100,50}}, color={159,159,223}));
  connect(infl_2, HX_hotSide.infl) annotation (Line(points={{-100,-50},{-10,-50}}, color={159,159,223}));
  connect(HX_hotSide.outfl, outfl_2) annotation (Line(points={{10,-50},{100,-50}}, color={159,159,223}));
  connect(HX_hotSide.wall, metalTubeFV1.ext) annotation (Line(points={{0,-45},{0,-23.1}}, color={255,127,0}));
  connect(metalTubeFV1.int, heatExchangerTopologyFV1.side2) annotation (Line(points={{0,-17},{0,16.9}}, color={255,127,0}));
  connect(heatExchangerTopologyFV1.side1, HX_coldSide.wall) annotation (Line(points={{0,23},{0,45}}, color={255,127,0}));
  annotation (Icon(graphics={Text(
          origin={0,43.3385},
          lineColor={28,108,200},
          extent={{-80,-153.338},{80,-193.339}},
          textString="%name"), Text(
          extent={{-80,100},{80,60}},
          textColor={102,44,145},
          textString="1D Counter-Flow")}));
end HX_1DCounterFlow;
