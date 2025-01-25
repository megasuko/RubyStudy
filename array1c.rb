def array03
    a=Array.new(10,0)
    0.step(10,-1) do |i| a[i] = i 
    end
    return a
end