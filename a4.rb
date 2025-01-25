def digits(n)
    a=n/100
    b=(n-a*100)/10
    c=n-a*100-b*10
    printf("%d %d %d",a,b,c)
end