<html>
<head>
  <link rel="stylesheet" href="/scc/examples.css">
</head>

<body>
<h3> PROJ examples </h3>

This directory contains some simple examples of using the PROJ library on the SCC.

<h4>Directory Structure</h4>

<ul>
<li><b>cs2cs_ex</b> - Script for testing cs2cs tool.</li>
<li><b>geod_ex</b> - Script for testing geod tool.</li>
<li><b>gie_ex.gie</b> - Script for testing gie tool.</li>
<li><b>job.qsub</b> - Bash script for qsub command to run a `proj` command as a bash job.</li>
<li><b>proj_ex</b> - Example script to test proj tool.</li>
</ul>





<h4>Interactive execution:</h4>
Load Proj module<br>
<br>
<code>geo % <b>module load proj4/5.1.0</b></code><br>


Simple commands to execute:<br><br>
<code>
   geo %  <b>echo 55.2 12.2 | proj +proj=merc +lat_ts=56.5 +ellps=GRS80</b><br>
   3399483.80      752085.60<br>
   <br>
   geo % <b>echo 3399483.80 752085.60 | cs2cs +proj=merc +lat_ts=56.5 +ellps=GRS80 +to +proj=utm +zone=32</b><br>
   6103992.36      1924052.47 0.00<br>
   <br>
   geo % <b>echo 56 12 | cs2cs +init=epsg:4326 +to +init=epsg:25832</b><br>
   6231950.54      1920310.71 0.00<br>
   <br>
   geo % <b>echo 0.0 | cs2cs +proj=latlong +datum=WGS84 +to +proj=latlong +datum=WGS84 +pm=madrid</b><br>
   3d41'16.58"E    0dN 0.000<br>
   <br>
   <br>
</code>

Simple scripts to test tools available with Proj. (Based on these examples: <a href="https://proj.org/apps/index.html#apps">https://proj.org/apps/index.html#apps</a>) <br><br>


Test proj tool - source the "proj_ex" file in this directory to test the proj tool.<br><br>
   <code>geo % <b>source proj_ex</b><br>
   460769.27       5011648.45<br>
   460769.27       5011648.45<br>
   460769.27       5011648.45<br>
   <br>
   </code>
Test cct tool<br><br>
<code>
   geo % <b>echo 12 55 | cct -z0 -t0 +proj=utm +zone=32 +ellps=GRS80</b><br>
   691875.6321   6098907.8250        0.0000        0.0000<br>
   <br>
</code>
Test cs2cs tool<br><br>
<code>   geo % <b>source cs2cs_ex</b><br>
   1402224.57      5076275.42 -0.00<br>
   1402224.57      5076275.42 -0.00<br>
   1402224.57      5076275.42 -0.00<br>
   <br>
</code>
Test geod tool - source the "geod_ex" file in this directory to run the test.<br><br>
<code>
   geo % <b>source geod_ex</b><br>
   -66d31'50.141"  75d39'13.083"   2587.504<br>
   <br>
</code>
Test gie tool - use the "gie_ex.gie" file in this directory as the input for "gie" commmand.<br><br>
<code>   geo %<b> gie -vvvv gie_ex.gie</b><br>
   -------------------------------------------------------------------------------<br>
   Reading file 'gie_ex.gie'<br>
   -------------------------------------------------------------------------------<br>
   proj=utm zone=32 ellps=GRS80<br>
     12 55<br>
   NOT INVERTED<br>
   forward<br>
   angular in<br>
   linear out<br>
   left: 4   right:  1<br>
   EXPECTS  691875.632140000002  6098907.825050000101  0.000000000000  0.000000000000<br>
   ACCEPTS  0.209439510239  0.959931088597  0.000000000000  0.000000000000<br>
   GOT      691875.632139660651  6098907.825005011633  0.000000000000  0.000000000000<br>
   -------------------------------------------------------------------------------<br>
   total:  1 tests succeeded,  0 tests skipped,  0 tests failed.<br>
   -------------------------------------------------------------------------------<br>
   Failing roundtrips:    0,    Succeeding roundtrips:    0<br>
   Failing failures:      0,    Succeeding failures:      0<br>
   Failing builtins:      0,    Succeeding builtins:      0<br>
   Internal counters:                            0001(0001)<br>
   -------------------------------------------------------------------------------<br>
</code>

<h3> Submit PROJ job </h3>
A sample batch script to submit a job running proj commands can be found in this directory. TO submit a job, run:<br>
<code>qsub job.qsub </code><br>


<h4>Helpful Links:</h4>
<a href="https://proj.org/usage/index.html">Proj.org</a>
<a href="http://www.bu.edu/tech/support/research/system-usage/running-jobs/">Running Jobs on the SCC</a><br>


<h4>Contact Information</h4>

Research Computing Services: <em>help@scc.bu.edu</em>
<br><br>
<b>Note: </b>RCS example programs are provided "as is" without any warranty of any kind. The user assumes the intire risk of quality, performance, and repair of any defect. You are welcome to copy and modify any of the given examples for your own use. 

</body>
</html>
