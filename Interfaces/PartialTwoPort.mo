within PL_Lib.Interfaces;

partial model PartialTwoPort "Partial component with two ports"
  import Modelica.Constants;
  outer Modelica.Fluid.System system "System wide properties";

  PL_Lib.Interfaces.FluidPort_a port_a annotation (Placement(visible = true, transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  PL_Lib.Interfaces.FluidPort_b port_b annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
end PartialTwoPort;
