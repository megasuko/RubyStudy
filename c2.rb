def prefix_sum(a)
n=a.size
t=0
b=Array.new(n,0)
n.times do |i|
    s=a[i]
    t=t+s
    b[i]=t
end
return b
end