within PL_Lib.Components;
model ShellAndTubeFV
  "Connects two DHTVolume ports according to a shell and tube configuration"
  extends ThermoPower.Thermal.HeatExchangerTopologyFV(
 redeclare model HeatExchangerTopology =
   ThermoPower.Thermal.HeatExchangerTopologies.ShellAndTube);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-74, 2}, {-48, 8}, {-74, 16}, {-56, 8}, {-74, 2}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{74, -16}, {60, -10}, {74, -2}, {52, -10}, {74, -16}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}),
    Documentation(info = "<HTML>
<p>This component can be used to model counter-current heat transfer. The temperature and flux vectors on one side are swapped with respect to the other side. This means that the temperature of node <tt>j</tt> on side 1 is equal to the temperature of note <tt>N-j+1</tt> on side 2; heat fluxes behave correspondingly.
<p>
The swapping is performed if the counterCurrent parameter is true (default value).
</HTML>", revisions = "<html>
<ul>
<li><i>25 Aug 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>counterCurrent</tt> parameter added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>

</html>
    "));
end ShellAndTubeFV;
