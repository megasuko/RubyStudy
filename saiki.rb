 def calc(n) 
   if n < 1 
     s = ''
     return s
   end 
   s = calc(n-1)
   s = s + 'c'
   return s
 end 