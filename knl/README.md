<html>
<head>
    <link rel="stylesheet" href="/css/examples.css">
</head>
<body>

<h3>RCS EXAMPLES</h3>
RCS examples are provided to assist you in learning the software and the development of your applications on the <a href="http://www.bu.edu/tech/support/research/computing-resources/scc/">Shared Computing Cluster (SCC)</a>. The instructions provided along with the code assume that the underlying OS is Linux. If these examples are run on a different architecture, you might need to make some changes to the code and/or the way the program is built and executed. 
<br>

<h3>RCS Examples for Intel Xeon Phi Knights Landing (KNL)</h3>

<h4>Directory Structure</h4>

<ul>
<li><b>examples</b> - This directory presents KNL example programs. </li>
</ul>


<h4>Usage notes</h4>
</br>

Kinghts Landing (KNL) is an
<a href="https://www.intel.com/content/www/us/en/products/processors/xeon-phi/xeon-phi-processors.html">Intel Xeon Phi</a> 
many-integrated-core (MIC)  processor.
Currently there are two KNL nodes on SCC. 
The host names are <code>scc-ib1</code> and <code>scc-ib2</code>. 
There are 68 physical cores on each KNL node. 
Each core supports 4 computing threads by the hyper-threading technique.
Each node therefore supports a total of 272 threads for multi-threaded programs: 68 cores, 4 hyper threads per core. The optimal number of threads for any program will have to be determined via testing. 

<br></br>
Different from the previous generation of Xeon Phi --- Knights Corner (KNC), the KNL is self-hosted.
The operating system runs directly on the KNL architecture, in contrast with the KNC architecture where an additional Xeon CPU was used to host the OS. The CentOS 7 system is installed on the SCC KNL nodes. Please note that this is an updated version compared with the SCC login and compute nodes which run CentOS 6. 

<br></br>
Intel Omni-path is installed to support data communication between the two KNL nodes.

<br></br>
Note that a single KNL core is much slower than a regular Xeon CPU core. 
It is not recommended to run a serial program on KNL as the run time will be much longer compared with the regular SCC compute nodes. 
To be accelerated on KNL, the programms have to be parallelized, for example by MPI, OpenMP or hybrid MPI-OpenMP. 

<br></br>
C or Fortran codes can be compiled and run on KNL. If the C or Fortran codes are parallelized and optimized appropriately, they can be accelerated considerably by the KNL architeture. Intel Math Kernel Library (MKL) functions can be automatically accelerated on KNL. For Python programmers, if the numpy or scipy libraries are built with Intel MKL, the numpy or scipy functions can be automatically accelerated on KNL too. The SCC has several versions of Python provided by Intel available via the module system which are built with the MKL. 

<br></br>
Please refer to the following instructions to compile and run C or Fortran programs on the KNL nodes. 

<ul>
<li><b>Compile programs</b> </li>
</br>
It is recommended to compile programs directly on KNL nodes, so that they are best optimized.
The compiled version for the KNL nodes will not be able to execute on regular SCC nodes due to the use of CPU instructions that are only available on the KNL nodes. 
To compile, request a single KNL core first,
<ul>
<br> <code>qrsh -l knl</code> </br>
</ul>
</br>
Then load the Intel compiler,
<ul>
<br> <code>module load intel/2017</code> </br>
</ul>
</br>
[Note: the Intel compiler provides the best optimized options for KNL, possibly by a large margin!]
<br></br>
To compile an OpenMP C code,
<ul>
<br> <code>icc -qopenmp -O3 -xmic-avx512 name.c -o executable</code> </br>
</ul>
</br>
or an OpenMP Fortran code,
<ul>
<br> <code>ifort -qopenmp -O3 -xmic-avx512 name.f90 -o executable</code> </br>
</ul>
</br>
[Note: The option <code>-xmic-avx512</code> is to make use of the 512-bit vectorization on KNL. This can accelerate the program signifigcantly. The level-3 optimization (-O3) usually (but not always) yields better performance than the level-2 optimization (-O2).]
<br></br>
To compile MPI programs, load an MPI implementation first,
<ul>
<br> <code>module use /share/module/knl</code> </br>
<code>module load openmpi/3.0.0_intel-2017_knl</code> </br>
</ul>
</br>

[Note: The openmpi/3.0.0_intel-2017_knl is an MPI implementation working for KNL on SCC.]
<br></br>

Then compile an MPI C code,
<ul>
<br> <code>mpicc -O3 -xmic-avx512 name.c -o executable</code> </br>
</ul>
</br>
or an MPI Fortran code,
<ul>
<br> <code>mpifort -O3 -xmic-avx512 name.f90 -o executable</code> </br>
</ul>
</br>

Adding the following compiling options may yield better performance in general.
<br></br>
<code> -fma </code>:  to generate fused multiply-add (FMA) instructions.
</br>
<code> -finline-functions </code>:  to enable function inlining.
<br></br>

</ul>

<ul>
<li><b>Run OpenMP programs</b> </li>
</br>
First request one KNL node by <code>qrsh</code>,

<ul>
<br> <code>qrsh -l knl -pe omp 68</code> </br>
</ul>
</br>

[Note: the "-pe omp 68" means 68 pysical cores are requested. The queue system is only aware of the physical cores on the KNL nodes. Users can specifiy <code>OMP_NUM_THREADS=272</code> to make use of the total 272 threads.]
<br></br>

Then run the OpenMP program,
</br>

<ul>
<br><code>export OMP_NUM_THREADS=272</code></br>
<code>/path/to/executable</code> </br>
</ul>
</br>

</ul>

<ul>
<li><b>Run MPI programs</b> </li>
</br>

First request the KNL nodes by <code>qrsh</code>. For exampele, request one KNL node, 

<ul>
<br> <code>qrsh -l knl -pe mpi_68_tasks_per_node 68</code> </br>
</ul>
</br>

or two KNL nodes,

<ul>
<br> <code>qrsh -l knl -pe mpi_68_tasks_per_node 136</code> </br>
</ul>
</br>

Then load the MPI implementation, 
<ul>
<br> <code>module use /share/module/knl</code> </br>
<code>module load openmpi/3.0.0_intel-2017_knl</code> </br>
</ul>
</br>

Then run the MPI program on one KNL node,

<ul>
<br> <code>mpirun -np 68 /path/to/executable </code> </br>
</ul>
</br>

or on two KNL nodes,

<ul>
<br> <code>mpirun -np 136 /path/to/executable </code> </br>
</ul>
</br>

[Note: It is recommended to run up to 68 (other than 272) MPI tasks per node. If the program is a hybrid MPI-OpenMP code then each task can be allowed up to 4 threads using the command: <code>export OMP_NUM_THREADS=4</code>.]
<br></br>

</ul>

<ul>
<li><b>Run programs in background</b> </li>
</br>

Users can run batch jobs in the background using <code>qsub</code>,

<ul>
<br> <code>qsub script </code> </br>
</ul>
</br>

Please refer to example scripts for OpenMP or MPI programs in the <code>example</code> directory.
<br></br>

[Note: Currently the maximum runtime on the SCC KNL nodes is 24 hours.]
<br></br>

</ul>




<h4>Contact Information</h4>

<em>help@scc.bu.edu</em><br>

<h4>Operating System Requirements</h4>

   The examples presented in this directory were written in C or Fortran.
<br>   - c or Fortran compilers available </br>
   
<h4>External References</h4>
<ul>
For more KNL examples, please refer to the
<a href="http://www.prace-ri.eu/best-practice-guide-knights-landing-january-2017">Best Practice Guide --- Knights Landing</a>.
</ul>


<!--#include virtual="/css/footer.html" -->
</body>
</html>
