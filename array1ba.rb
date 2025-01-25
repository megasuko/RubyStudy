def array02a(n)
    m=n/2
    a=Array.new(n,0)
    m.step(n-1,1) do |i| a[i] = 1 
    end
    return a
end