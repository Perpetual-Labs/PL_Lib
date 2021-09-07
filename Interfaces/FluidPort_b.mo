within PL_Lib.Interfaces;

connector FluidPort_b
  extends PL_Lib.Interfaces.ThermoFluidPort;
  annotation(
    Icon(graphics = {Ellipse(lineColor = {170, 0, 255}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(lineColor = {204, 204, 204}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2,extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
end FluidPort_b;
