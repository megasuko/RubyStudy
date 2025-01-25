def harmonic(n)
    a=0.0
    b=1.0
    n.times do |i|
        a=(1.0/b)+a
        b=b+1.0
    end
    puts(a)
end