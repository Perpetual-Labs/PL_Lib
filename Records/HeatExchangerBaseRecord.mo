within PL_Lib.Records;
partial record HeatExchangerBaseRecord
  extends Modelica.Icons.Record;
  parameter Integer Nnodes "number of Nodes";
  parameter Integer Nt "Number of tubes in parallel";
  parameter Real Cfhex "friction coefficient";
  parameter Modelica.SIunits.Length Lhex "total length";
  parameter Modelica.SIunits.Diameter Dihex "internal diameter";
  parameter Modelica.SIunits.Radius rhex "internal radius";
  parameter Modelica.SIunits.Length omegahex "internal perimeter";
  parameter Modelica.SIunits.Area Ahex "internal cross section";
end HeatExchangerBaseRecord;
