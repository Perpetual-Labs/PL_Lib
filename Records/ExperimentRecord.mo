within PL_Lib.Records;
record ExperimentRecord
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  parameter SI.Time simDuration=1000;
  parameter Integer numSteps=500;

  parameter SI.Time t_takeoff=300;
  parameter SI.Time t_startCruise=600;
  parameter SI.MassFlowRate whex_RA=0.25 "nominal (and initial) mass flow rate";
  parameter SI.MassFlowRate whex_BA=0.25 "nominal (and initial) mass flow rate";
  parameter SI.Pressure phex_RA_00km=101325 "initial pressure";
  parameter SI.Pressure phex_RA_10km=26500 "Atmospheric pressure at 10km elevation";
  parameter SI.Pressure phex_BA=101325*2 "initial pressure";
  parameter SI.Temperature Thex_in_RA_00km=273.15 + 20 "initial inlet temperature at ground level";
  parameter SI.Temperature Thex_in_RA_10km=273.15 - 25 "Inlet ram air temperature at 10km elevation";
  parameter SI.Temperature Thex_in_BA=273.15 + 300;
end ExperimentRecord;
