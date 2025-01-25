def eulerline(xa,ya,xb,yb,xc,yc)
    xo=((xa**2+ya**2)*(yb-yc)+(xb**2+yb**2)*(yc-ya)+(xc**2+yc**2)*(ya-yb))/(2*(xa*(yb-yc)+xb*(yc-ya)+xc*(ya-yb)))
    yo=((xa**2+ya**2)*(xc-xb)+(xb**2+yb**2)*(xa-xc)+(xc**2+yc**2)*(xb-xa))/(2*(xa*(yb-yc)+xb*(yc-ya)+xc*(ya-yb)))
    xg=(xa+xb+xc)/3
    yg=(ya+yb+yc)/3
    xh=((xa*xc+yb**2)*(ya-yc)+(xb*xc+ya**2)*(yc-yb)+(xa*xb+yc**2)*(yb-ya))/(xa*yb+xb*yc+xc*ya-xa*yc-xb*ya-xc*yb)
    yh=(-(ya*yc+xb**2)*(xa-xc)-(yb*yc+xa**2)*(xc-xb)-(ya*yb+xc**2)*(xb-xa))/(xa*yb+xb*yc+xc*ya-xa*yc-xb*ya-xc*yb)
    xs=(2*xo+xh)/3
    ys=(2*yo+yh)/3
    printf("%.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f",xo,yo,xg,yg,xh,yh,xs,ys)
end