def array01(n)
    a=Array.new(n,0)
    1.step(n,2) do |i| a[i] = 1 
    end
    return a
end