<html>
<head>
    <link rel="stylesheet" href="/css/examples.css">
</head>
<body>

<h3>Passing arguments to R script from a command line </h3>
<em>args.R</em> script processes the command line and, if arguments are given, assigns the values to the appropriate variables
<br>
<h4>Interactive execution:</h4>
You can execute the code interactively:<br>
<code style="background:#f2f2f2">scc1% R -q --slave --vanilla --args 10000 21.7 2.2 &#60 args.R </code><br>
The first 3 options are optional:<br>
<li>-q option runs R in a "quiet" mode - startup message is not printed</li>
<li>--slave option make R run as quiet as possible - does not print the R script</li>
<li>--vanilla option tells R not to search for user-defined enviroment variables</li>
<br>

The alternative way to run the code interactively:<br>
<code style="background:#f2f2f2">scc1% Rscript args.R 10000 21.7 2.2</code><br>


<h4>Submit R job:</h4>
This directory contains 2 script files - <em>r_job</em> and <em>rscript_job</em>,
 which submit the job using <em>R</em> and <em>Rscript</em> commands respectevely and 
pass arguments to the R script.<br>
<code style="background:#f2f2f2">scc1% qsub r_job</code><br>
or<br>
<code style="background:#f2f2f2">scc1% qsub rscript_job</code><br><br>
Users who are members of any Medical Campus projects must also include their project group name:<br>
<code style="background:#f2f2f2">scc1% qsub -P <i>scv</i> r_job</code><br>
or<br>
<code style="background:#f2f2f2">scc1% qsub -P <i>scv</i> rscript_job</code><br>

<h4>Contact Information:</h4>
Katia Oleinik: <em>koleinik@bu.edu</em>
</body>
</html>
