def coban(x,a1,a2,b1,b2,c1,c2)
    suspect='D'
    if ((x<a1 || a2<x) && b1<=x && x<=b2 && c1<=x && x<=c2)
        suspect='A'
    elsif ((x<b1 || b2<x) && a1<=x && x<=a2 && c1<=x && x<=c2)
        suspect='B'
    elsif ((x<c1 || c2<x) && a1<=x && x<=a2 && b1<=x && x<=b2)
        suspect='C'
    end
    puts(suspect)
end