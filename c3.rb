def has_duplicates?(arr)
    n=arr.size
    if n==1 && arr[0]==0
        return false
    end
n.times do |i|
    a=arr[i]
    (n-i).times do |j|
        b=arr[-j]
        if a+b==0
            return true
        end
    end
end
return false
end