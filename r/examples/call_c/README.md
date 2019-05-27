<html>
<head>
  <link rel="stylesheet" href="/scc/examples.css">
</head>

<body>
<h3>RCS Example of R script call C function</h3>

Compile C code:<br>
<pre>[scc1 ~] R CMD SHLIB  c_lib.c -o c_lib.so</pre><br>

From R script load the dynamic library:<br>
<pre> dyn.load("c_lib.so")</pre>

Execute C function :
<pre>result <- .Call("cfunction", a=21.7, b=3.14)</pre><br>


<h4>For help email </h4>

Research Computing Services: <em>help@scc.bu.edu</em>
<br><br>
<b>Note: </b>RCS example programs are provided "as is" without any warranty of any kind. The user assumes the intire risk of quality, performance, and repair of any defect. You are welcome to copy and modify any of the given examples for your own use. 

</body>
</html>
