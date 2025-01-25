def fizzb
    1.step(99) do |i|
    if i % 15 ==0
    puts("fizzbuzz")
    elsif i % 5 == 0
    puts("buzz") 
    elsif i % 3 == 0
    puts("fizz")
    else
    puts(i)
    end
    end
    end