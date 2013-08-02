def fib(n)
  n < 2 ? n : fib(n-1) + fib(n-2)
end

(1..7000).each do |i|
  puts fib(i)
end
