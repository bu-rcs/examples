

# Load the shared library
dyn.load("c_lib.so")

result <- .Call("cfunction", a=21.7, b=3.14)
print(result)
