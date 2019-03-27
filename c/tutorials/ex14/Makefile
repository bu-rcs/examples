.SUFFIXES:
.SUFFIXES: .c .o
.c.o:
	gcc -c $*.c

dotprod: dp.o dotprod.o
	gcc -o $@ dp.o dotprod.o

dp.o dotprod.o: dp.h

clean:
	rm -f dotprod *.o
