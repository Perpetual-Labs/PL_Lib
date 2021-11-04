within PL_Lib.Components;
model HX
  ThermoPower.Gas.Flow1DFV HX_hotSide(
    redeclare package Medium = Medium,
    Cfnom=Cfhex,
    FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    N=Nnodes,
    Nt=Nt,
    dpnom=1000,
    fixedMassFlowSimplified=true,
    initOpt=ThermoPower.Choices.Init.Options.steadyState) annotation (Placement(
        visible=true, transformation(extent={{-10,-50},{10,-30}}, rotation=0)));
  ThermoPower.Gas.Flow1DFV HX_coldSide(
    redeclare package Medium = Medium,
    Cfnom=Cfhex,
    FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    N=Nnodes,
    Nt=Nt,
    dpnom=1000,
    fixedMassFlowSimplified=true,
    initOpt=ThermoPower.Choices.Init.Options.steadyState,
    noInitialPressure=true) annotation (Placement(visible=true, transformation(
        origin={0,40},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV1(
    Nt=Nt,
    Nw=Nnodes - 1,
    lambda=20,
    rext=0.012/2,
    rhomcm=7800*650,
    rint=0.01/2) annotation (Placement(visible=true, transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV1(Nw=
        Nnodes - 1) annotation (Placement(visible=true, transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Integer Nnodes = 10 "number of Nodes";
  parameter Integer Nt = 20 "Number of tubes in parallel";
  parameter Real Cfhex = 0.005 "friction coefficient";
  ThermoPower.Gas.FlangeA infl2(redeclare package Medium = Medium) annotation (
      Placement(transformation(rotation=0, extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-110,-60},{-90,-40}})));
  ThermoPower.Gas.FlangeB outfl2(redeclare package Medium = Medium) annotation (
     Placement(transformation(rotation=0, extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-60},{110,-40}})));
  ThermoPower.Gas.FlangeA infl1(redeclare package Medium = Medium) annotation (
      Placement(transformation(rotation=0, extent={{-110,30},{-90,50}}),
        iconTransformation(extent={{-110,40},{-90,60}})));
  ThermoPower.Gas.FlangeB outfl1(redeclare package Medium = Medium) annotation (
     Placement(transformation(rotation=0, extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,40},{110,60}})));
equation
  connect(HX_coldSide.wall, heatExchangerTopologyFV1.side1)
    annotation (Line(points={{0,35},{0,13}}, color={255,127,0}));
  connect(heatExchangerTopologyFV1.side2,metalTubeFV1. int) annotation (
    Line(points={{0,6.9},{0,-7}},          color = {255, 127, 0}));
  connect(metalTubeFV1.ext, HX_hotSide.wall)
    annotation (Line(points={{0,-13.1},{0,-35}}, color={255,127,0}));
  connect(infl2, HX_hotSide.infl)
    annotation (Line(points={{-100,-40},{-10,-40}}, color={159,159,223}));
  connect(outfl2, HX_hotSide.outfl)
    annotation (Line(points={{100,-40},{10,-40}}, color={159,159,223}));
  connect(infl1, HX_coldSide.infl)
    annotation (Line(points={{-100,40},{-10,40}}, color={159,159,223}));
  connect(outfl1, HX_coldSide.outfl)
    annotation (Line(points={{100,40},{10,40}}, color={159,159,223}));
  annotation (Icon(graphics={
                     Rectangle(lineColor = {89, 89, 89}, fillColor = {236, 236, 236},
            fillPattern =                                                                           FillPattern.Solid,
            lineThickness =                                                                                                            0.5, extent={{
              -100,100},{100,-100}},                                                                                                                                             radius = 30), Line(points={{0,
              -80},{0,-40},{40,-20},{-40,20},{0,40},{0,80}},                                                                                                                                                                                                        color = {85, 0, 255}, thickness = 0.5), Text(origin={0,
              211},                                                                                                                                                                                                        lineColor = {85, 170, 255}, extent = {{-100, -230}, {100, -290}}, textString = "%name")}));
end HX;
