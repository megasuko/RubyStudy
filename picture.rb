Pixel = Struct.new(:r, :g, :b)
$img = Array.new(900) do
  Array.new(700) do Pixel.new(255,255,255) end
end
def pset(x, y, r=0, g=0, b=0, a=0.0)
  if x < 0 || x >= 700 || y < 0 || y >= 900 then return end
  $img[y][x].r = ($img[y][x].r * a + r * (1.0 - a)).to_i
  $img[y][x].g = ($img[y][x].g * a + g * (1.0 - a)).to_i
  $img[y][x].b = ($img[y][x].b * a + b * (1.0 - a)).to_i
end
def writeimage(name)
  open(name, "wb") do |f|
    f.puts("P6\n700 900\n255")
    $img.each do |a|
      a.each do |p| f.write(p.to_a.pack("ccc")) end
    end
  end
end
def fillcircle(x, y, rad, r=0, g=0, b=0, a=0.0)
  j0 = (y-rad).to_i; j1 = (y+rad).to_i
  i0 = (x-rad).to_i; i1 = (x+rad).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      if (i-x)**2+(j-y)**2<rad**2
        if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
      end
    end
  end
end
def filldonut(x, y, r1, r2, r=0, g=0, b=0, a=0.0)
  j0 = (y-r1).to_i; j1 = (y+r1).to_i
  i0 = (x-r1).to_i; i1 = (x+r1).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      d2 = (i-x)**2+(j-y)**2
      if r2**2 <= d2 && d2 <= r1**2
        if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
      end
    end
  end
end
def fillrect(x, y, w, h, r=0, g=0, b=0, a=0.0)
  j0 = (y-0.5*h).to_i; j1 = (y+0.5*h).to_i
  i0 = (x-0.5*w).to_i; i1 = (x+0.5*w).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
    end
  end
end
def fillellipse(x, y, rx, ry, r=0, g=0, b=0, a=0.0)
  j0 = (y-ry).to_i; j1 = (y+ry).to_i
  i0 = (x-rx).to_i; i1 = (x+rx).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      if ((i-x).to_f/rx)**2 + ((j-y).to_f/ry)**2 < 1.0
        if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
      end
    end
  end
end
def fillrotellipse(x, y, rx, ry, theta, r=0, g=0, b=0, a=0.0)
  d = (if rx > ry then rx else ry end)
  j0 = (y-d).to_i; j1 = (y+d).to_i
  i0 = (x-d).to_i; i1 = (x+d).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      dx = i - x; dy = j - y;
      px = dx*Math.cos(theta) - dy*Math.sin(theta)
      py = dx*Math.sin(theta) + dy*Math.cos(theta)
      if (px/rx)**2 + (py/ry)**2 < 1.0
        if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
      end
    end
  end
end
def filltriangle(x0, y0, x1, y1, x2, y2, r = 0, g = 0, b = 0, a = 0.0)
  if block_given?
    fillconvex([x0, x1, x2, x0], [y0, y1, y2, y0]) do |x,y| yield(x,y) end
    fillconvex([x0, x2, x1, x0], [y0, y2, y1, y0]) do |x,y| yield(x,y) end
  else
    fillconvex([x0, x1, x2, x0], [y0, y1, y2, y0], r, g, b, a)
    fillconvex([x0, x2, x1, x0], [y0, y2, y1, y0], r, g, b, a)
  end
end
def fillconvex(ax, ay, r=0, g=0, b=0, a=0.0)
  xmax = ax.max.to_i; xmin = ax.min.to_i
  ymax = ay.max.to_i; ymin = ay.min.to_i
  ymin.step(ymax) do |j|
    xmin.step(xmax) do |i|
     if isinside(i, j, ax, ay)
       if block_given? then yield(i,j) else pset(i,j,r,g,b,a) end
     end
    end
  end
end
def isinside(x, y, ax, ay)
  (ax.length-1).times do |i|
    if oprod(ax[i+1]-ax[i],ay[i+1]-ay[i],x-ax[i],y-ay[i])<0
      return false
    end
  end
  return true
end
def oprod(a, b, c, d)
  return a*d - b*c;
end
def fillline(x0, y0, x1, y1, w, r=0, g=0, b=0, a=0.0)
  dx = y1-y0; dy = x0-x1; n = 0.5*w / Math.sqrt(dx**2 + dy**2)
  dx = dx * n; dy = dy * n
  if block_given?
    fillconvex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
               [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy]) do |x,y| yield(x,y) end
  else
    fillconvex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
               [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy], r, g, b, a)
  end
end

def mypicture
  pset(100, 80, 255, 0, 0)
  writeimage("t.ppm")
end
def yourpicture
    80.step(120) do |x| pset(x,80,0,0,255) end
    writeimage("u.ppm")
end
def mypicture2
    fillcircle(150, 100, 60, 255, 0, 0)
    fillcircle(150, 100, 40, 0, 255, 0)
    fillcircle(150, 100, 20, 0, 0, 255)
    writeimage("s.ppm")
end
def circle(x0, y0, rad, r, g, b)
  900.times do |y|
  700.times do |x|
  if (x-x0)**2 + (y-y0)**2 <= rad**2 && (x-x0)**2 + (y-y0)**2 >= (rad-2)**2
  pset(x, y, r, g, b)
  end
  end
  end
  end
def ellipse(x, y, rx, ry, r=0, g=0, b=0, a=0.0)
    j0 = (y-ry).to_i; j1 = (y+ry).to_i
    i0 = (x-rx).to_i; i1 = (x+rx).to_i
    j0.step(j1) do |j|
      i0.step(i1) do |i|
        if ((i-x).to_f/rx)**2 + ((j-y).to_f/ry)**2 < 1.0 && ((i-x).to_f/(rx-2))**2 + ((j-y).to_f/(ry-2))**2 >= 1.0
          if block_given? then yield(i,j) else pset(j,i,r,g,b,a) end
        end
      end
    end
end
def miku
fillcircle(350,450,360,4,255,0,0.85)
fillellipse(350,820,50,20,0,0,0,0.7)
filltriangle(100,110,160,110,160,740,48,221,207)
filltriangle(100,110,40,760,160,740,48,221,207)
filltriangle(600,110,540,110,540,740,48,221,207)
filltriangle(600,110,660,760,540,740,48,221,207)
filltriangle(120,760,40,760,160,740,48,221,207)
filltriangle(120,760,40,760,140,820,48,221,207)
filltriangle(120,760,180,800,160,740,48,221,207)
filltriangle(580,760,660,760,540,740,48,221,207)
filltriangle(580,760,660,760,560,820,48,221,207)
filltriangle(580,760,520,800,540,740,48,221,207)
filltriangle(278,488,422,488,480,640,79,100,100)
filltriangle(278,488,480,640,220,640,79,100,100)
filltriangle(278,488,295,488,280,480,79,100,100)
filltriangle(422,488,420,480,405,488,79,100,100)
filltriangle(220,640,260,660,267,640,79,100,100)
filltriangle(480,640,440,660,433,640,79,100,100)
fillellipse(250,440,9,4,79,100,100)
filltriangle(303,710,320,820,340,710,79,100,100)
filltriangle(340,820,320,820,340,710,79,100,100)
filltriangle(397,710,380,820,360,710,79,100,100)
filltriangle(360,820,380,820,360,710,79,100,100)
filltriangle(140,100,200,80,140,250,79,100,100)
filltriangle(200,250,200,80,140,250,79,100,100)
filltriangle(560,100,500,80,560,250,79,100,100)
filltriangle(500,250,500,80,560,250,79,100,100)
filltriangle(160,338,180,413,220,413,79,100,100)
filltriangle(540,338,520,413,480,413,79,100,100)
filltriangle(160,94,160,164,180,87,251,32,156)
filltriangle(180,164,160,164,180,87,251,32,156)
filltriangle(540,94,540,164,520,87,251,32,156)
filltriangle(520,164,540,164,520,87,251,32,156)
fillrect(350,520,100,160,218,229,235)
filltriangle(300,452,280,600,300,600,218,229,235)
filltriangle(400,452,420,600,400,600,218,229,235)
filltriangle(280,600,320,620,350,600,218,229,235)
filltriangle(420,600,380,620,350,600,218,229,235)
fillcircle(350,250,209,255,235,224)
fillellipse(350,250,209,209,48,221,207) do |x,y|
  theta=Math.atan2(y-250,x-350)*180/Math::PI
  if (theta<-39 && theta>-180)|| (theta<=180 && theta>141) then pset(x,y,48,221,207) end end
filltriangle(140,250,140,360,160,338,48,221,207)
filltriangle(560,250,560,360,540,338,48,221,207)
filltriangle(280,200,380,360,400,200,48,221,207)
filltriangle(240,400,186,380,223,328,48,221,207)
filltriangle(460,400,514,380,477,328,48,221,207)
filltriangle(230,645,220,660,260,660,255,235,224)
filltriangle(470,645,480,660,440,660,255,235,224)
filltriangle(284,481,295,486,299,456,255,235,224)
filltriangle(416,481,405,486,401,456,255,235,224)
filltriangle(303,710,340,710,340,700,255,235,224)
filltriangle(303,710,340,700,300,691,255,235,224)
filltriangle(397,710,360,710,360,700,255,235,224)
filltriangle(397,710,360,700,400,691,255,235,224)
filltriangle(380,360,280,200,220,320,255,235,224)
filltriangle(380,360,240,400,220,320,255,235,224)
filltriangle(400,200,380,360,480,320,255,235,224)
filltriangle(460,400,380,360,480,320,255,235,224)
fillrect(350,650,180,20,79,100,100)
fillrect(350,660,140,40,79,100,100)
fillrect(350,670,60,60,79,100,100)
filltriangle(280,660,260,660,280,680,79,100,100)
filltriangle(280,680,320,680,320,700,79,100,100)
filltriangle(420,660,440,660,420,680,79,100,100)
filltriangle(420,680,380,680,380,700,79,100,100)
filltriangle(320,580,380,580,350,620,48,221,207)
filltriangle(320,580,380,580,350,460,48,221,207)
filltriangle(325,476,340,500,350,460,48,221,207)
filltriangle(375,476,360,500,350,460,48,221,207)
filltriangle(340,500,360,500,350,460,48,221,207)
fillline(261,655,282,675,10,48,221,207)
fillline(282,675,321,695,10,48,221,207)
fillline(321,695,379,695,10,48,221,207)
fillline(381,695,418,675,10,48,221,207)
fillline(418,675,439,655,10,48,221,207)
fillline(323,570,340,570,5,79,100,100)
fillline(324,563,340,563,5,79,100,100)
fillcircle(230,210,10,255,255,255,0.3)
fillcircle(470,210,10,255,255,255,0.3)
fillcircle(350,230,10,255,255,255,0.3)
fillcircle(130,450,10,255,255,255,0.3)
fillcircle(570,450,10,255,255,255,0.3)
fillrotellipse(190,200,10,20,15,255,255,255,0.3)
fillrotellipse(510,200,10,20,-15,255,255,255,0.3)
fillrotellipse(90,440,10,20,30,255,255,255,0.3)
fillrotellipse(610,440,10,20,-30,255,255,255,0.3)
pset(259,658,79,100,100)
pset(260,659,79,100,100)
pset(441,658,79,100,100)
pset(440,659,79,100,100)
fillcircle(350,370,10,251,32,156,0.8)
fillcircle(260,340,39,0,194,194)
fillellipse(260,340,39,39,0,0,0,0.6) do |x,y|
theta=Math.atan2(y-340,x-260)*180/Math::PI
if theta<0 && theta>-180 then pset(x,y,0,0,0,0.6) end end
fillcircle(440,340,39,0,194,194)
fillellipse(440,340,39,39,0,0,0,0.6) do |x,y|
theta=Math.atan2(y-340,x-440)*180/Math::PI
if theta<0 && theta>-180 then pset(x,y,0,0,0,0.6) end end
fillellipse(250,300,49,9,0,194,194)
fillellipse(250,300,49,9,0,0,0,0.6)
fillellipse(450,300,49,9,0,194,194)
fillellipse(450,300,49,9,0,0,0,0.6)
fillcircle(260,340,10,255,255,255)
fillcircle(440,340,10,255,255,255)
fillellipse(350,400,29,19,255,137,128) do |x,y|
  theta=Math.atan2(y-400,x-350)*180/Math::PI
    if theta>0 || theta<-180 then pset(x,y,255,137,128) end end
ellipse(350,250,210,210,0,0,0) do |x,y|
  theta=Math.atan2(y-250,x-350)*180/Math::PI
    if (theta<150 && theta>30) || theta<0 then pset(x,y,0,0,0) end end
ellipse(260,340,40,40,0,0,0) do |x,y|
  theta=Math.atan2(y-340,x-260)*180/Math::PI
    if theta>-61 || theta<-128 then pset(x,y,0,0,0) end end
ellipse(440,340,40,40,0,0,0) do |x,y|
  theta=Math.atan2(y-340,x-440)*180/Math::PI
    if theta>-52 || theta<-119 then pset(x,y,0,0,0) end end
ellipse(250,300,50,10,0,0,0) do |x,y|
  theta=Math.atan2(y-300,x-250)*180/Math::PI
    if theta>142 || theta<13 then pset(x,y,0,0,0) end end
ellipse(450,300,50,10,0,0,0) do |x,y|
  theta=Math.atan2(y-300,x-450)*180/Math::PI
    if theta>167 || theta<38 then pset(x,y,0,0,0) end end
fillline(320,480,350,460,2,0,0,0)
fillline(350,460,380,480,2,0,0,0)
fillline(320,480,300,452,2,0,0,0)
fillline(400,452,380,480,2,0,0,0)
fillline(340,500,360,500,2,0,0,0)
fillline(340,500,320,580,2,0,0,0)
fillline(360,500,380,580,2,0,0,0)
fillline(320,580,350,620,2,0,0,0)
fillline(380,580,350,620,2,0,0,0)
fillline(300,452,280,600,2,0,0,0)
fillline(400,452,420,600,2,0,0,0)
fillline(340,500,325,476,2,0,0,0)
fillline(360,500,375,476,2,0,0,0)
fillline(280,600,320,620,2,0,0,0)
fillline(320,620,340,606,2,0,0,0)
fillline(420,600,380,620,2,0,0,0)
fillline(380,620,360,606,2,0,0,0)
fillline(140,100,140,360,2,0,0,0)
fillline(560,100,560,360,2,0,0,0)
fillline(140,100,200,80,2,0,0,0)
fillline(560,100,500,80,2,0,0,0)
fillline(200,80,200,104,2,0,0,0)
fillline(500,80,500,104,2,0,0,0)
fillline(100,110,140,110,2,0,0,0)
fillline(600,110,560,110,2,0,0,0)
fillline(160,338,160,740,2,0,0,0)
fillline(540,338,540,740,2,0,0,0)
fillline(140,360,160,338,2,0,0,0)
fillline(560,360,540,338,2,0,0,0)
fillline(100,110,40,760,2,0,0,0)
fillline(600,110,660,760,2,0,0,0)
fillline(40,760,140,820,2,0,0,0)
fillline(140,820,120,760,2,0,0,0)
fillline(120,760,180,800,2,0,0,0)
fillline(180,800,160,740,2,0,0,0)
fillline(540,740,520,800,2,0,0,0)
fillline(520,800,580,760,2,0,0,0)
fillline(580,760,560,820,2,0,0,0)
fillline(560,820,660,760,2,0,0,0)
fillline(220,320,226,308,2,0,0,0)
fillline(234,292,280,200,2,0,0,0)
fillline(280,200,380,360,2,0,0,0)
fillline(380,360,400,200,2,0,0,0)
fillline(400,200,460,292,2,0,0,0)
fillline(472,308,480,320,2,0,0,0)
fillline(280,480,220,640,2,0,0,0)
fillline(220,640,260,660,2,0,0,0)
fillline(282,601,260,660,2,0,0,0)
fillline(260,660,280,680,2,0,0,0)
fillline(280,680,320,700,2,0,0,0)
fillline(320,700,380,700,2,0,0,0)
fillline(380,700,420,680,2,0,0,0)
fillline(420,680,440,660,2,0,0,0)
fillline(440,660,480,640,2,0,0,0)
fillline(480,640,420,480,2,0,0,0)
fillline(440,660,418,601,2,0,0,0)
fillline(300,691,320,820,2,0,0,0)
fillline(320,820,340,820,2,0,0,0)
fillline(340,820,340,700,2,0,0,0)
fillline(360,700,360,820,2,0,0,0)
fillline(360,820,380,820,2,0,0,0)
fillline(380,820,400,691,2,0,0,0)
fillline(303,710,340,710,2,0,0,0)
fillline(360,710,397,710,2,0,0,0)
fillline(295,487,280,480,2,0,0,0)
fillline(405,487,420,480,2,0,0,0)
fillline(283,482,300,452,2,0,0,0)
fillline(417,482,400,452,2,0,0,0)
fillline(440,660,480,660,2,0,0,0)
fillline(480,660,470,645,2,0,0,0)
fillline(260,660,220,660,2,0,0,0)
fillline(220,660,230,645,2,0,0,0)
fillline(305,613,280,680,2,0,0,0)
fillline(395,613,420,680,2,0,0,0)
fillline(320,700,335,610,2,0,0,0)
fillline(380,700,365,610,2,0,0,0)
fillline(186,380,240,400,2,0,0,0)
fillline(240,400,232,367,2,0,0,0)
fillline(223,328,220,320,2,0,0,0)
fillline(514,380,460,400,2,0,0,0)
fillline(460,400,468,367,2,0,0,0)
fillline(477,328,480,320,2,0,0,0)
fillline(160,338,180,413,2,0,0,0)
fillline(180,413,220,413,2,0,0,0)
fillline(540,338,520,413,2,0,0,0)
fillline(520,413,480,413,2,0,0,0)
fillline(220,413,240,440,2,0,0,0)
fillline(320,400,380,400,2,0,0,0)
ellipse(250,440,10,5,0,0,0)
ellipse(350,400,30,20,0,0,0) do |x,y|
  theta=Math.atan2(y-400,x-350)*180/Math::PI
  if theta>0 || theta<-180 then pset(x,y,0,0,0) end end
ellipse(250,260,30,20,0,0,0) do |x,y|
  theta=Math.atan2(y-260,x-250)*180/Math::PI
  if theta>180 || theta<0 then pset(x,y,0,0,0) end end
ellipse(450,260,30,20,0,0,0) do |x,y|
  theta=Math.atan2(y-260,x-450)*180/Math::PI
  if theta>180 || theta<0 then pset(x,y,0,0,0) end end
fillellipse(210,390,50,10,255,137,128,0.5)
fillellipse(490,390,50,10,255,137,128,0.5)
fillellipse(300,330,15,5,255,255,255)
fillellipse(480,330,15,5,255,255,255)
writeimage("miku.ppm")
end