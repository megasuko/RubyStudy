def initialize_bucket
    $bucket=[0,0]
    return $bucket
end
def empty(i)
    $bucket[i]=0
    return $bucket
end
def fill(i)
    if i==0
    $bucket[i]=4
    else
    $bucket[i]=7
    end
    return $bucket
end
def transfer(i)
    a=$bucket[0]
    b=$bucket[1]
    if i==0
        if (7-b)>=a
        $bucket[1]=a+b
        $bucket[0]=0
        else
        $bucket[1]=7
        $bucket[0]=a+b-7
        end
    else if (4-a)>=b
        $bucket[0]=a+b
        $bucket[1]=0
        else
        $bucket[0]=4
        $bucket[1]=a+b-4
        end
    end
    return $bucket
end