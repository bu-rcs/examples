.SUFFIXES:
.SUFFIXES: .c .o
.c.o:
	gcc -c $*.c

dotprod: dotprod.o dp.o
	gcc -o dotprod dotprod.o dp.o

dotprod.o dp.o: dp.h

clean:
	rm *.o dotprod
