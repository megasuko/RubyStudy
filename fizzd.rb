def fizzd
    s=0
    1.step(99) do |i|
    if i % 3 ==0 || i % 10 ==3 || i / 10 == 3
    puts("aho")
    else
    puts(i)
    end
end
end