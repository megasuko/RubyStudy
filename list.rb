Cell=Struct.new(:data,:next)
def listlen(p)
    len=0
    while p !=nil 
        len=len+1 
        p=p.next
    end
    return len
end
def listsum(p)
    sum=0
    while p !=nil
        sum=sum+p.data
        p=p.next
    end
    return sum
end
def listcat(p)
    cat=""
    while p !=nil
        cat=cat+p.data.to_s
        p=p.next
    end
    return cat
end
def listcatrev(p)
    catrev=""
    while p !=nil
        catrev=p.data.to_s+catrev
        p=p.next
    end
    return catrev
end
def printmany(p)
    i=1
    while p !=nil
        i.times do puts p.data end
        i=i*2
        p=p.next
    end
end