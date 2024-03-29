within PL_Lib.Components;
model Compressor_noMaps
  // extends ThermoPower.Gas.BaseClasses.CompressorBase;
  extends ThermoPower.Icons.Gas.Compressor;
  extends PL_Lib.Interfaces.CompressorBase;
  import ThermoPower.Choices.TurboMachinery.TableTypes;
  parameter Modelica.SIunits.AngularVelocity Ndesign=523.3 "Design velocity";

  //   parameter Real tablePhic[:,:]=fill(0,0,2) "Table for phic(N_T,beta)";
  //   parameter Real tableEta[:,:]=fill(0,0,2) "Table for eta(N_T,beta)";
  //   parameter Real tablePR[:,:]=fill(0,0,2) "Table for eta(N_T,beta)";

  parameter Real tablePhic[:,:]=tablePhicC "Table for phic(N_T,beta)";
  parameter Real tableEta[:,:]=tableEtaC "Table for eta(N_T,beta)";
  parameter Real tablePR[:,:]=tablePRC "Table for eta(N_T,beta)";

  parameter String fileName="noName" "File where matrix is stored";
  parameter TableTypes Table=TableTypes.matrix "Selection of the way of definition of table matrix";

  parameter Real eta_set=0.95;
  parameter Real PR_set=2.5;
  parameter Modelica.SIunits.Mass mass=1 "Compressor mass";

  Modelica.Blocks.Tables.CombiTable2D Eta(
    tableOnFile=if Table == TableTypes.matrix then false else true,
    table=tableEta,
    tableName=if Table == TableTypes.matrix then "NoName" else "tabEta",
    fileName=if Table == TableTypes.matrix then "NoName" else fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation (Placement(transformation(extent={{-12,60},{8,80}}, rotation=0)));
  Modelica.Blocks.Tables.CombiTable2D PressRatio(
    tableOnFile=if Table == TableTypes.matrix then false else true,
    table=tablePR,
    tableName=if Table == TableTypes.matrix then "NoName" else "tabPR",
    fileName=if Table == TableTypes.matrix then "NoName" else fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation (Placement(transformation(extent={{-12,0},{8,20}}, rotation=0)));
  Modelica.Blocks.Tables.CombiTable2D Phic(
    tableOnFile=if Table == TableTypes.matrix then false else true,
    table=tablePhic,
    tableName=if Table == TableTypes.matrix then "NoName" else "tabPhic",
    fileName=if Table == TableTypes.matrix then "NoName" else fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation (Placement(transformation(extent={{-12,30},{8,50}}, rotation=0)));
  Real N_T "Referred speed ";
  Real N_T_design "Referred design velocity";
  Real phic "Flow number ";
  Real beta(start=integer(size(tablePhic, 1)/2)) "Number of beta line";

protected
  parameter Real tableEtaC[6,4]=[0,95,100,105; 1,82.5e-2,81e-2,80.5e-2; 2,84e-2,82.9e-2,82e-2; 3,83.2e-2,82.2e-2,81.5e-2; 4,82.5e-2,81.2e-2,79e-2; 5,79.5e-2,78e-2,76.5e-2];
  parameter Real tablePhicC[6,4]=[0,95,100,105; 1,38.3e-3,43e-3,46.8e-3; 2,39.3e-3,43.8e-3,47.9e-3; 3,40.6e-3,45.2e-3,48.4e-3; 4,41.6e-3,46.1e-3,48.9e-3; 5,42.3e-3,46.6e-3,49.3e-3];
  parameter Real tablePRC[6,4]=[0,95,100,105; 1,22.6,27,32; 2,22,26.6,30.8; 3,20.8,25.5,29; 4,19,24.3,27.1; 5,17,21.5,24.2];
equation
  N_T_design = Ndesign/sqrt(Tdes_in) "Referred design velocity";
  N_T = 100*omega/(sqrt(gas_in.T)*N_T_design) "Referred speed definition, as percentage of design velocity";
  phic = w*sqrt(gas_in.T)/gas_in.p "Flow number definition";
  // phic = Phic(beta, N_T)
  Phic.u1 = beta;
  Phic.u2 = N_T;
  phic = Phic.y;

  // eta = Eta(beta, N_T)
  Eta.u1 = beta;
  Eta.u2 = N_T;
  //  eta = Eta.y;
  eta = eta_set;

  // PR = PressRatio(beta, N_T)
  PressRatio.u1 = beta;
  PressRatio.u2 = N_T;
  //  PR = PressRatio.y;
  PR = PR_set;

  annotation (Documentation(info="<html>
This model adds the performance characteristics to the Compressor_Base model, by means of 2D interpolation tables.</p>
<p>The perfomance characteristics are specified by two characteristic equations: the first relates the flow number <tt>phic</tt>, the pressure ratio <tt>PR</tt> and the referred speed <tt>N_T</tt>; the second relates the efficiency <tt>eta</tt>, the flow number <tt>phic</tt>, and the referred speed <tt>N_T</tt> [1]. To avoid singularities, the two characteristic equations are expressed in parametric form by adding a further variable <tt>beta</tt> (method of beta lines [2]).
<p>The performance maps are thus tabulated into three differents tables, <tt>tablePhic</tt>,  <tt>tablePR</tt> and <tt>tableEta</tt>, which express <tt>phic</tt>, <tt>PR</tt> and <tt>eta</tt> as a function of <tt>N_T</tt> and <tt>beta</tt>, respectively, where <tt>N_T</tt> is the first row while <tt>beta</tt> is the first column. The referred speed <tt>N_T</tt> is defined as a percentage of the design referred speed and <tt>beta</tt> are arbitrary lines, usually drawn parallel to the surge-line on the performance maps.
<p><tt>Modelica.Blocks.Tables.CombiTable2D</tt> interpolates the tables to obtain values of referred flow, pressure ratio and efficiency at given levels of referred speed and beta.
<p><b>Modelling options</b></p>
<p>The following options are available to determine how the table is defined:
<ul><li><tt>Table = 0</tt>: the table is explicitly supplied as matrix parameter.
<li><tt>Table = 1</tt>: the table is read from a file; the string <tt>fileName</tt> contains the path to the files where the tables are stored, either in ASCII or Matlab binary format.
</ul>
<p><b>References:</b></p>
<ol>
<li>S. L. Dixon: <i>Fluid mechanics, thermodynamics of turbomachinery</i>, Oxford, Pergamon press, 1966, pp. 213.
<li>P. P. Walsh, P. Fletcher: <i>Gas Turbine Performance</i>, 2nd ed., Oxford, Blackwell, 2004, pp. 646.
</ol>
</html>", revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       New method for calculating performance parameters using tables.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Compressor model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"), Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={28,108,200},
          textString="%name")}));
end Compressor_noMaps;
