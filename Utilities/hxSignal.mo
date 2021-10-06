within PL_Lib.Utilities;
class hxSignal
  input Real tCold;
  input Real tHot;
  input Real mRateCold;
  input Real mRateHot;
  input Real densityCold;
  input Real densityHot;
  input Real pressureCold;
  input Real pressureHot;

  output Real temperatures[2];
  output Real pressures[2];
equation
(  temperatures,pressures) = hx(tCold,  tHot, mRateCold, mRateHot, pressureCold, pressureHot, densityCold,densityHot);
end hxSignal;
