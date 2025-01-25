def regression(n, xarr, yarr)
    xy=0
    sx=0
    sy=0
    ssx=0
    n.times do |i|
    x=xarr[i]
    y=yarr[i]
    xy=xy+x*y
    sx=sx+x
    sy=sy+y
    ssx=ssx+x*x
    end
    a=(n*xy-sx*sy)/(n*ssx-sx*sx)
    b=(ssx*sy-xy*sx)/(n*ssx-sx*sx)
printf("%.3f %.3f\r\n", a,b)
end