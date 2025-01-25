def initialize_array
    $arr=Array.new
    $a=-1
    return $arr
end
def get_array
    return $arr
end
def append(x)
    $a=$a+1
    $arr[$a]=x
    return $arr
end
def swap(i, j)
    if $a>=j
        b=$arr[i]
        $arr[i]=$arr[j]
        $arr[j]=b
    end
    return $arr
end