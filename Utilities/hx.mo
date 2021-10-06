within PL_Lib.Utilities;
function hx
  input Real tCold;
  input Real tHot;
  input Real mRateCold;
  input Real mRateHot;
  input Real pressuresCold;
  input Real pressureHot;
  input Real densityCold;
  input Real densityHot;

  output Real temperatures[2];
  output Real pressures[2];

  external "C" hx(tCold,tHot,mRateCold,mRateHot,densityCold,densityHot,temperatures,pressures) annotation (
      IncludeDirectory = "modelica://PL_Lib/Utilities",
      Include = "#include \"hx.c\"");
end hx;
