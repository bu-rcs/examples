OBJECTS=dp.o dotprod.o
INCLUDE_FILES=dp.h
EXECUTABLE=dotprod

.SUFFIXES:
.SUFFIXES: .c .o
.c.o:
	gcc -c $*.c

$(EXECUTABLE): $(OBJECTS)
	gcc -o $@  $(OBJECTS)

$(OBJECTS): $(INCLUDE_FILES)

clean:
	rm -f $(EXECUTABLE) *.o
