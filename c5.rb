def janken(n, arr1, arr2)
    a=0
    b=0
    c=0
    n.times do |i|
        x=arr1[i]
        y=arr2[i]
        if x==y
             c=c+1
        elsif x+y==1
            if x==0
                a=a+1
            else
                b=b+1
            end
        elsif x+y==2
            if x==2
                a=a+1
            else
                b=b+1
            end
        else
            if x==1
                a=a+1
            else
                b=b+1
            end
    end
end
printf("Total: %d, Win: %d, Loss: %d, Draw: %d",n,a,b,c)
end