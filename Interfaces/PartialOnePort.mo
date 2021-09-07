within PL_Lib.Interfaces;

model PartialOnePort
  import Modelica.Constants;
  outer Modelica.Fluid.System system "System wide properties";
  
  FluidPort_b fluidPort_b annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

end PartialOnePort;
