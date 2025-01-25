def each(arr,brr)
ab=0
arr.each_index do |i|
brr.each_index do |i|
ab=ab+arr[i]*brr[i]
puts ab
end
end
return ab
end