def newton(a,e)
    s=Math.sqrt(2)
    u=(a-s).abs
    n=1
    until u<=e do
    a=(a/2.0)+(1.0/a)
    u=(a-s).abs
    n=n+1
    end
    return n
end
