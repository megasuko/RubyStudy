def fizzcb
    1.step(99) do |i|
    unless i % 2 ==0 || i % 3 ==0
    puts(i)
    end
    end
end