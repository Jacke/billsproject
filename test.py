def fib():
    a, b = 0, 1
    while 1:
        yield a
        a, b = b, a + b

a = fib()

for i in range(10000):
    print a.next(),

