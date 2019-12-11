<html>
<head>
    <link rel="stylesheet" href="/css/examples.css">
</head>
<body>

<h3>RCS sample Stata code </h3>
This directory contains a simple "Hello, World!" Stata script.
<br>
<h4>Interactive execution:</h4>
Start an Interactive Stata sessions by typing <em>xstata</em> at the SCC prompt:<br>
<code>scc1% module load stata/16</code><br>
<code>scc1% xstata</code><br>
In the File menu, select Do and chose helloWorld.do file.<br>

<h4>Batch execution:</h4>
At the SCC prompt execute:<br>
<code>scc1% stata -b do helloWorld.do</code><br>
The output will be written to the log file <em>helloWorld.log</em>
<br>
<h4>Submit Stata job:</h4>
This directory contains a simple <em>Statajob</em> script that, when submitted to the batch system, will execute the <em>helloWorld.do</em> script. To submit the job, type the following command at the SCC prompt:<br>
<code>scc1% qsub Statajob</code><br><br>
Users who are members of any Medical Campus projects must also include their project group name:<br>
<code>scc1% qsub -P <i>scv</i> Statajob</code><br>

<h4>Helpful Links:</h4>
<a href="http://www.bu.edu/tech/support/research/software-and-programming/software-and-applications/rcs-software-packages/stata-basics/">Stata Basics</a><br>
<a href="http://www.bu.edu/tech/support/research/system-usage/running-jobs/">Running Jobs on the SCC</a><br>
</body>
</html>
