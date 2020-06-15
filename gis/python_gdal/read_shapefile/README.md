<html>
<head>
    <link rel="stylesheet" href="/css/examples.css">
</head>
<body>

<h3>Python gdal/ogr example </h3>
This directory contains a simple Python script that calls GDAL/OGR API.

<h4>Directory Structure</h4>

<ul>
<li><b>read_shapefile_ex.py</b> - Sample Python script for opening and subsetting data in a Shapefile. </li>
<li><b>read_shapefile.qsub</b> - Bash script for the qsub command to submit a job that executes read_shapefile_ex.py</li>
</ul>


<br>
<h4>Interactive execution:</h4>
Load GDAL and Python modules:<br>
<code>geo % <b>module load python3/3.6.5</b></code><br>
<code>geo % <b>module load gdal/2.3.2</b></code><br>
<br>

Execute python script:<br>
<code> geo % <b>python read_shapefile_ex.py</b></code><br>

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
