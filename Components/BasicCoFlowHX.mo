within PL_Lib.Components;
model BasicCoFlowHX
  extends Interfaces.HeatExchangerBase;
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  ThermoPower.Gas.Flow1DFV HX_hotSide(redeclare package Medium = Medium, Cfnom=Cfhex, FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom, N=Nnodes, Nt=Nt, dpnom=1000, fixedMassFlowSimplified=true, initOpt=ThermoPower.Choices.Init.Options.steadyState) annotation (Placement(
        visible=true, transformation(extent={{-10,-60},{10,-40}}, rotation=0)));
  ThermoPower.Gas.Flow1DFV HX_coldSide(redeclare package Medium = Medium, Cfnom=Cfhex, FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom, N=Nnodes, Nt=Nt, dpnom=1000, fixedMassFlowSimplified=true, initOpt=ThermoPower.Choices.Init.Options.steadyState, noInitialPressure=true) annotation (Placement(visible=true, transformation(
        origin={0,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(Nt=Nt, Nw=Nnodes - 1, lambda=20, rext=0.012/2, rhomcm=7800*650, rint=0.01/2) annotation (Placement(visible=true, transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw=Nnodes - 1) annotation (Placement(visible=true, transformation(
        origin={0,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Integer Nt = 20 "Number of tubes in parallel";
  parameter Real Cfhex = 0.005 "friction coefficient";
equation
  connect(infl_1, HX_coldSide.infl) annotation (Line(points={{-100,50},{-10,50}}, color={159,159,223}));
  connect(HX_coldSide.outfl, outfl_1) annotation (Line(points={{10,50},{100,50}}, color={159,159,223}));
  connect(infl_2, HX_hotSide.infl) annotation (Line(points={{-100,-50},{-10,-50}}, color={159,159,223}));
  connect(HX_hotSide.outfl, outfl_2) annotation (Line(points={{10,-50},{100,-50}}, color={159,159,223}));
  connect(HX_hotSide.wall, metalTubeFV1.ext) annotation (Line(points={{0,-45},{0,-23.1}}, color={255,127,0}));
  connect(metalTubeFV1.int, heatExchangerTopologyFV1.side2) annotation (Line(points={{0,-17},{0,16.9}}, color={255,127,0}));
  connect(heatExchangerTopologyFV1.side1, HX_coldSide.wall) annotation (Line(points={{0,23},{0,45}}, color={255,127,0}));
  annotation (Icon(graphics={Text(
          extent={{-82,82},{80,-82}},
          textColor={28,108,200},
          textString="Basic Co-Flow HX")}));
end BasicCoFlowHX;
