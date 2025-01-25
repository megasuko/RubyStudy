def fizz1
    1.step(99) do |i|
    if i % 3 == 0
    puts("fizz")
    elsif i % 5 == 0
    puts("buzz")
    else
    puts(i)
    end
    end
    end    