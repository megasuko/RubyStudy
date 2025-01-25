Cell=Struct.new(:date,:next)
def listlen(p)
    len=0
    while p !=nil 
        len=len+1 
        p=p.next
    end
    return len
end