within PL_Lib.Utilities;

function hx
  input Real tCold;
  input Real tHot;
  input Real mRateCold;
  input Real mRateHot;
  input Real densityCold;
  input Real densityHot;
  input Real pressuresCold;
  input Real pressureHot;
  output Real temperatures[2];
  output Real pressures[2];
algorithm
  temperatures[1] := 2;
  temperatures[2] := 5;
  pressures[1] := 34;
  pressures[2] := 7;
//  external "C" hx(tCold,tHot,mRateCold,mRateHot,densityCold,densityHot,temperatures,pressures) annotation( IncludeDirectory = "modelica://hxP", Include = "#include \"hx.c\"");
end hx;
