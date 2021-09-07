within PL_Lib.Interfaces;

connector FluidPort_a
  extends PL_Lib.Interfaces.ThermoFluidPort;
  annotation(
    Icon(graphics = {Ellipse(lineColor = {170, 0, 255}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, lineThickness = 2,extent = {{-100, 100}, {100, -100}}, endAngle = 360)}));

end FluidPort_a;
