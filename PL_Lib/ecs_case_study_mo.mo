within PL_Lib;
package ecs_case_study_mo

  connector ThermalFluidPort "Thermal Fluid Port"
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);

    flow Medium.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
    Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
    stream Medium.SpecificEnthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
    stream Medium.MassFraction Xi_outflow[Medium.nXi] "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
    stream Medium.ExtraProperty C_outflow[Medium.nC] "Properties c_i/m close to the connection point if m_flow < 0";
  end ThermalFluidPort;

  connector ThermalFluidInlet "Thermal Fluid Inlet"
    extends ThermalFluidPort;
  end ThermalFluidInlet;

  connector ThermalFluidOutlet "Thermal Fluid Outlet"
    extends ThermalFluidPort;
  end ThermalFluidOutlet;

  partial model Compressor "C.1.1"
    parameter Modelica.SIunits.Mass compressorMass "Q.16";
    replaceable package compressorMedium = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    ecs_case_study_mo.ThermalFluidInlet CompressorInlet(redeclare package Medium = compressorMedium) annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
    ecs_case_study_mo.ThermalFluidOutlet CompressorOutlet(redeclare package Medium = compressorMedium) annotation (Placement(transformation(extent={{90,40},{110,60}})));
  end Compressor;

  partial model HeatExchanger "C.1.2"
    parameter Modelica.SIunits.Mass heatExchangerMass "Q.17";
    replaceable package heatExchangerMediumCold = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    replaceable package heatExchangerMediumHot = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    ecs_case_study_mo.ThermalFluidInlet HeatExchangerInletCold(redeclare package Medium = heatExchangerMediumCold) "Heat Exchanger Inlet Cold" annotation (Placement(transformation(extent={{-112,40},{-92,60}})));
    ecs_case_study_mo.ThermalFluidOutlet HeatExchangerOutletCold(redeclare package Medium = heatExchangerMediumCold) "Heat Exchanger Outlet Cold" annotation (Placement(transformation(extent={{90,40},{110,60}})));
    ecs_case_study_mo.ThermalFluidInlet HeatExchangerInletHot(redeclare package Medium = heatExchangerMediumHot) "Heat Exchanger Inlet Hot" annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
    ecs_case_study_mo.ThermalFluidOutlet HeatExchangerOutletHot(redeclare package Medium = heatExchangerMediumHot) "Heat Exchanger Outlet Hot" annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
  end HeatExchanger;

  partial model AirConditioner "C.1"
    replaceable package acMediumCold = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    replaceable package acMediumHot = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable ecs_case_study_mo.HeatExchanger heatExchanger(redeclare package heatExchangerMediumCold = acMediumCold, redeclare package heatExchangerMediumHot = acMediumHot) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    replaceable ecs_case_study_mo.Compressor compressor(redeclare package compressorMedium = acMediumHot) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

    Real acMass(quantity="Mass", unit="kg") "Q.1";

    ecs_case_study_mo.ThermalFluidInlet acInletCold(redeclare package Medium = acMediumCold) annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
    ecs_case_study_mo.ThermalFluidInlet acInletHot(redeclare package Medium = acMediumHot) annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
    ecs_case_study_mo.ThermalFluidOutlet acOutletCold(redeclare package Medium = acMediumCold) annotation (Placement(transformation(extent={{90,40},{110,60}})));
    ecs_case_study_mo.ThermalFluidOutlet acOutletHot(redeclare package Medium = acMediumHot) annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
  equation
    connect(heatExchanger.HeatExchangerOutletHot, compressor.CompressorInlet) annotation (Line(points={{-20,-5},{14,-5},{14,5},{20,5}}, color={0,0,0}));
    connect(acOutletHot, compressor.CompressorOutlet) annotation (Line(points={{100,-50},{44,-50},{44,5},{40,5}}, color={0,0,0}));
    connect(acInletCold, heatExchanger.HeatExchangerInletCold) annotation (Line(points={{-100,50},{-44,50},{-44,5},{-40.2,5}}, color={0,0,0}));
    connect(acInletHot, heatExchanger.HeatExchangerInletHot) annotation (Line(points={{-100,-50},{-46,-50},{-46,-5},{-40,-5}}, color={0,0,0}));
    connect(acOutletCold, heatExchanger.HeatExchangerOutletCold) annotation (Line(points={{100,50},{-12,50},{-12,5},{-20,5}}, color={0,0,0}));
  end AirConditioner;

  model Verification
    replaceable package ecsMediumHot = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
    replaceable package ecsMediumCold = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
    Real acMass(quantity="Mass", unit="kg") "Q.1";
    Real cabinPress(quantity="Pressure", unit="Pa", displayUnit="bar") "Q.4";
    Real cabinTemp(quantity="ThermodynamicTemperature", unit="K", displayUnit="degC") "Q.5";
    Real cabinAtmosphereMass(quantity="Mass", unit="kg") "Q.17";
    Real cabinAtmosphereChangeRate(quantity="MassFlowRate", unit="kg/s") "Q.18";

    replaceable ecs_case_study_mo.AirConditioner airConditioner(redeclare package acMediumCold = ecsMediumCold, redeclare package acMediumHot = ecsMediumHot) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    // Scenarios
    parameter Integer S=1;
    parameter Boolean cruiseConditions=S == 1 "S.1";
    parameter Boolean taxiConditions=S == 2 "S.2";
    Modelica.SIunits.Pressure ambientPress=if cruiseConditions then cruiseAmbientPressLimit elseif taxiConditions then taxiAmbientPressLimit else 0 "Q.2";
    Modelica.SIunits.Temperature ambientTemp=if cruiseConditions then cruiseAmbientTempLimit elseif taxiConditions then taxiAmbientTempLimit else 0 "Q.3";
    Modelica.SIunits.Pressure bleedPress=if cruiseConditions then cruiseBleedPressLimit elseif taxiConditions then taxiBleedPressLimit else 0 "Q.6";
    Modelica.SIunits.Temperature bleedTemp=if cruiseConditions then cruiseBleedTempLimit elseif taxiConditions then taxiBleedTempLimit else 0 "Q.7";

    // Constraint Values
    parameter Modelica.SIunits.Mass acMassLimit=100;
    parameter Modelica.SIunits.Temperature cruiseAmbientTempLimit=223.15;
    parameter Modelica.SIunits.Pressure cruiseAmbientPressLimit=26.5e3;
    parameter Modelica.SIunits.Temperature cruiseBleedTempLimit=273.15 + 400;
    parameter Modelica.SIunits.Pressure cruiseBleedPressLimit=344748;

    parameter Modelica.SIunits.Temperature taxiAmbientTempLimit=311;
    parameter Modelica.SIunits.Pressure taxiAmbientPressLimit=101.325e3;
    parameter Modelica.SIunits.Temperature taxiBleedTempLimit=273.15 + 300;
    parameter Modelica.SIunits.Pressure taxiBleedPressLimit=206843;

    parameter Modelica.SIunits.Temperature cabinTempLowerLimit=292;
    parameter Modelica.SIunits.Temperature cabinTempUpperLimit=294;
    parameter Modelica.SIunits.Pressure cabinPressLowerLimit=98e3;
    parameter Modelica.SIunits.Pressure cabinPressUpperLimit=104e3;
  protected
    ecs_case_study_mo.ThermalFluidInlet ambientAtmosphere_in(redeclare package Medium = ecsMediumCold) annotation (Placement(transformation(extent={{-60,40},{-40,60}}), iconTransformation(extent={{-60,40},{-40,60}})));
    ecs_case_study_mo.ThermalFluidInlet bleedAtmoshpere(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}}), iconTransformation(extent={{-60,-60},{-40,-40}})));
    ecs_case_study_mo.ThermalFluidOutlet ambientAtomsphere_out(redeclare package Medium = ecsMediumCold) annotation (Placement(transformation(extent={{40,40},{60,60}}), iconTransformation(extent={{40,40},{60,60}})));
    ecs_case_study_mo.ThermalFluidOutlet cabinAtmosphere(redeclare package Medium = ecsMediumHot) annotation (Placement(transformation(extent={{40,-60},{60,-40}}), iconTransformation(extent={{40,-60},{60,-40}})));
  equation
    connect(ambientAtmosphere_in, airConditioner.acInletCold) annotation (Line(points={{-50,50},{-20,50},{-20,5},{-10,5}}, color={0,0,0}));
    connect(bleedAtmoshpere, airConditioner.acInletHot) annotation (Line(points={{-50,-50},{-20,-50},{-20,-5},{-10,-5}}, color={0,0,0}));
    connect(ambientAtomsphere_out, airConditioner.acOutletCold) annotation (Line(points={{50,50},{20,50},{20,5},{10,5}}, color={0,0,0}));
    connect(cabinAtmosphere, airConditioner.acOutletHot) annotation (Line(points={{50,-50},{20,-50},{20,-5},{10,-5}}, color={0,0,0}));
  end Verification;
  annotation ();
end ecs_case_study_mo;
