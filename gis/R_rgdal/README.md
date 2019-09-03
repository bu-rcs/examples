<html>
<head>
    <link rel="stylesheet" href="/css/examples.css">
</head>
<body>

<h3>Python gdal/ogr example </h3>
This directory contains a simple R script that utilizes rgdal ro read a shapefile.

<h4>Directory Structure</h4>

<ul>
<li><b>read_shapefile_ex.R</b> - Sample R script for opening a Shapefile and subsetting the data and saving the results into a new Shapefile. </li>
<li><b>read_shapefile.qsub</b> - Bash script for the qsub command to submit a job that executes read_shapefile_ex.py</li>
</ul>


<br>
<h4>Interactive execution:</h4>
Load R:<br>
<code>geo % <b>module load R/3.6.0</b></code><br>
<br>

Execute R script:<br>
<code> geo % <b>Rscript read_shapefile_ex.R</b></code><br>

<h4>Submit a batch job:</h4>
This directory contains a simple <em>read_shapefile.qsub</em> script that, when submitted to the batch system, will execute the <em>read_shapefile_ex.py</em> script. To submit the job, type the following command at the SCC prompt:<br>
<code>geo % <b>qsub read_shapefile.qsub</b></code><br>

<h4>Helpful Links:</h4>
<a href="http://www.bu.edu/tech/support/research/system-usage/running-jobs/">Running Jobs on the SCC</a><br>


<h4>Contact Information</h4>

Research Computing Services: <em>help@scc.bu.edu</em>
<br><br>
<b>Note: </b>RCS example programs are provided "as is" without any warranty of any kind. The user assumes the intire risk of quality, performance, and repair of any defect. You are welcome to copy and modify any of the given examples for your own use. 

</body>
</html>
