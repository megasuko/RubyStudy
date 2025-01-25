def arrayminrange(a,i,j)
    p=i
    min=a[p]
    i.step(j) do |k|
        if min > a[k] then p=k
        min=a[k] end
    end
    return p
end
def swap(a,i,j)
    x=a[i]
    a[i]=a[j]
    a[j]=x
end
def selectionsort(a)
    0.step(a.length-2) do|i|
        k=arrayminrange(a,i,a.length-1)
        swap(a,i,k)
    end
end
def randarray(n)
    return Array.new(n) do rand(100) end
end