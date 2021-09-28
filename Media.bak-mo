within PL_Lib;

model Media
  extends Modelica.Icons.Package;

  model BasicGas
    Modelica.SIunits.Pressure p "[Pa]";
    Modelica.SIunits.Temperature T "[K]";
    Modelica.SIunits.Density rho "[kg/m3]";
    Modelica.SIunits.SpecificHeatCapacity c "[J/kg.K]";
  end BasicGas;

  model BasicAirModel = BasicGas(rho = 1.2922, c = 717.1);
equation

end Media;
