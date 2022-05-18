within PL_Lib.Components;
model HX_1DShellTube
  extends PL_Lib.Interfaces.HeatExchangerBase;
  extends PL_Lib.Icons.HeatExchanger_icon;
  import SI = Modelica.SIunits;

  parameter Integer Nnodes=10 "number of Nodes";
  parameter Integer Nt=20 "Number of tubes in parallel";
  parameter Real Cfhex=0.005 "friction coefficient";
  parameter SI.Length Lhex=10 "total length";
  parameter SI.Diameter Dihex=0.02 "internal diameter";
  parameter SI.Radius rhex=Dihex/2 "internal radius";
  parameter SI.Length omegahex=Modelica.Constants.pi*Dihex "internal perimeter";
  parameter SI.Area Ahex=Modelica.Constants.pi*rhex^2 "internal cross section";
  parameter ThermoPower.Choices.Init.Options initOpt=ThermoPower.Choices.Init.Options.steadyState "Initialisation option" annotation (Dialog(tab="Initialisation"));
  parameter SI.AbsolutePressure pstart_c=1e5 "Pressure start value - cold side" annotation (Dialog(tab="Initialisation", group="Cold side"));
  parameter SI.Temperature Tstartbar_c=300 "Avarage temperature start value - cold side" annotation (Dialog(tab="Initialisation", group="Cold side"));
  parameter SI.Temperature Tstartin_c=HX_coldSide.Tstartbar "Inlet temperature start value - cold side" annotation (Dialog(tab="Initialisation", group="Cold side"));
  parameter SI.Temperature Tstartout_c=HX_coldSide.Tstartbar "Outlet temperature start value - cold side" annotation (Dialog(tab="Initialisation", group="Cold side"));
  parameter SI.AbsolutePressure pstart_h=1e5 "Pressure start value - hot side" annotation (Dialog(tab="Initialisation", group="Hot side"));
  parameter SI.Temperature Tstartbar_h=300 "Avarage temperature start value - hot side" annotation (Dialog(tab="Initialisation", group="Hot side"));
  parameter SI.Temperature Tstartin_h=HX_hotSide.Tstartbar "Inlet temperature start value - hot side" annotation (Dialog(tab="Initialisation", group="Hot side"));
  parameter SI.Temperature Tstartout_h=HX_hotSide.Tstartbar "Outlet temperature start value - hot side" annotation (Dialog(tab="Initialisation", group="Hot side"));
  parameter SI.Length rint=0.01/2 "Internal radius (single tube)" annotation (Dialog(group="HX parameters"));
  parameter SI.Length rext=0.012/2 "External radius (single tube)" annotation (Dialog(group="HX parameters"));
  parameter SI.HeatCapacity rhomcm=7800*650 "Metal heat capacity per unit volume [J/m^3.K]" annotation (Dialog(group="HX parameters"));
  parameter SI.ThermalConductivity lambda=20 "Thermal conductivity" annotation (Dialog(group="HX parameters"));
  parameter SI.MassFlowRate wnom_c=0.1 "Nominal mass flowrate (total) - cold side";
  parameter SI.MassFlowRate wnom_h=0.1 "Nominal mass flowrate (total) - hot side";
  parameter SI.Temperature Tstartbar_wall=300 "Avarage temperature - wall" annotation (Dialog(tab="Initialisation", group="Wall"));
  parameter SI.Temperature Tstart1_w=metalTubeFV.Tstartbar "Temperature start value - first volume - wall" annotation (Dialog(tab="Initialisation", group="Wall"));
  parameter SI.Temperature TstartN_w=metalTubeFV.Tstartbar "Temperature start value - last volume - wall" annotation (Dialog(tab="Initialisation", group="Wall"));

  ThermoPower.Gas.Flow1DFV HX_hotSide(
    redeclare package Medium = HotFluid,
    A=Ahex,
    omega=omegahex,
    wnom=wnom_h,
    Cfnom=Cfhex,
    Dhyd=Dihex,
    FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    L=Lhex,
    N=Nnodes,
    dpnom=1000,
    pstart=pstart_h,
    Tstartbar=Tstartbar_h,
    Tstartin=Tstartin_h,
    Tstartout=Tstartout_h,
    initOpt=initOpt,
    noInitialPressure=false) annotation (Placement(visible=true, transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Gas.Flow1DFV HX_coldSide(
    redeclare package Medium = ColdFluid,
    A=Ahex,
    omega=omegahex,
    wnom=wnom_c,
    Cfnom=Cfhex,
    Dhyd=Dihex,
    FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    L=Lhex,
    N=Nnodes,
    dpnom=1000,
    pstart=pstart_c,
    Tstartbar=Tstartbar_c,
    Tstartin=Tstartin_c,
    Tstartout=Tstartout_c,
    initOpt=initOpt,
    noInitialPressure=false) annotation (Placement(visible=true, transformation(
        origin={0,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  ThermoPower.Thermal.MetalTubeFV metalTubeFV(
    L=Lhex,
    Nt=Nt,
    Nw=Nnodes - 1,
    lambda=lambda,
    rext=rext,
    rhomcm=rhomcm,
    rint=rint,
    Tstartbar=Tstartbar_wall,
    Tstart1=Tstart1_w,
    TstartN=TstartN_w) annotation (Placement(visible=true, transformation(
        origin={0,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower.Thermal.HeatExchangerTopologyFV heatExchangerTopologyFV(Nw=Nnodes - 1, redeclare model HeatExchangerTopology =
        ThermoPower.Thermal.HeatExchangerTopologies.ShellAndTube (
        Nw=Nnodes - 1,
        Ntp=Nnodes - 1,
        inletTubeAtTop=true,
        inletShellAtTop=false)) annotation (Placement(visible=true, transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(infl_1, HX_coldSide.infl) annotation (Line(points={{-100,50},{-10,50}}, color={159,159,223}));
  connect(infl_2, HX_hotSide.infl) annotation (Line(points={{-100,-50},{-10,-50}}, color={159,159,223}));
  connect(HX_coldSide.outfl, outfl_1) annotation (Line(points={{10,50},{100,50}}, color={159,159,223}));
  connect(HX_hotSide.outfl, outfl_2) annotation (Line(points={{10,-50},{100,-50}}, color={159,159,223}));
  connect(metalTubeFV.ext, heatExchangerTopologyFV.side1) annotation (Line(points={{0,16.9},{0,-17}}, color={255,127,0}));
  connect(heatExchangerTopologyFV.side2, HX_hotSide.wall) annotation (Line(points={{0,-23.1},{0,-45}}, color={255,127,0}));
  connect(metalTubeFV.int, HX_coldSide.wall) annotation (Line(points={{0,23},{0,45}}, color={255,127,0}));
  annotation (Icon(graphics={Text(
          origin={0,43.3385},
          lineColor={28,108,200},
          extent={{-80,-153.338},{80,-193.339}},
          textString="%name"), Text(
          lineColor={102,44,145},
          extent={{-80,100},{80,60}},
          textString="1D Shell & Tube")}));
end HX_1DShellTube;
