
# SAS Basic example

This directory contains "Hello, World!" SAS code.

### Interactive Notebook Execution:

Start a SAS interactive session:
```
scc1% sas &
```

In "Program Editor" window, open helloWorld.sas program: File->Open.

To execute the program, select Run command from the menu.
The output will be written into "SAS: Log" window


### Interactive Command-line execution:

Start a SAS command line interactive session:
```
scc1% sas -nodms
```

At the SAS prompt, type:
```
> %put "Hello, World!";
> proc product_status; run;
```

To exit the program, type 
```
> endsas;. 
```
at the prompt (notice the dot at the end of the command!).


### Batch execution:

At the SCC prompt, execute:
```
scc1% sas helloWorld.sas
```
The output will be written into the file "helloWorld.log"


### Submit SAS job:

To submit a SAS job to the batch system that will execute the "helloWord.sas" 
script, type the following command at the SCC prompt:
```
scc1% qsub SASjob
```

Users who are members of any Medical Campus projects must also include their project group name:
```
scc1% qsub -P scv SASjob
```



### Operating System Requirements

The SAS script presented in this directory was written under Linux OS, but should work on any OS.


### Helpful Links:

RCS: SAS Basics: 
<a href="http://www.bu.edu/tech/support/research/software-and-programming/software-and-applications/rcs-software-packages/sas-basics/">http://www.bu.edu/tech/support/research/software-and-programming/software-and-applications/rcs-software-packages/sas-basics/</a>


Running Jobs on the SCC:
<a href="http://www.bu.edu/tech/support/research/system-usage/running-jobs/">http://www.bu.edu/tech/support/research/system-usage/running-jobs/</a>
