within PL_Lib.Components;

model SensD "Pressure sensor for gas flows"
  extends ThermoPower.Icons.Gas.SensP;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealOutput d(final quantity="Density",
                                          final unit="kg/m3",
                                          displayUnit="g/cm3",
                                          min=0) "Density in port medium" annotation(
    Placement(transformation(extent = {{60, 50}, {72, 70}}, rotation = 0), iconTransformation(extent = {{60, 50}, {80, 70}})));
  ThermoPower.Gas.FlangeA flange(redeclare package Medium = Medium, m_flow(min = 0)) annotation(
    Placement(transformation(extent = {{-20, -60}, {20, -20}}, rotation = 0)));
equation
  flange.m_flow = 0 "Mass balance";
//  flange.p = p "Sensor output";
  d = Medium.density(Medium.setState_phX(flange.p, inStream(flange.h_outflow), inStream(flange.Xi_outflow)));
  
  flange.h_outflow = 0;
  flange.Xi_outflow = zeros(Medium.nXi);
  annotation(
    Documentation(info = "<html>
<p>This component can be connected to any A-type or B-type connector to measure the pressure of the fluid flowing through it.
</html>", revisions = "<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Icon(graphics = {Text(extent = {{-42, 92}, {44, 36}}, textString = "d")}),
    Diagram(graphics));
end SensD;
