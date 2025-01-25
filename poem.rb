def poemanai(n)
a=["私は", "僕は", "俺は", "我は", "朕は"]; al = a.length
b= ["寝", "進捗をうみ", "ごはんを食べ", "学校に行き", "ゲームをやり", "勉強し", "漫画を読み", "アニメを観"]; bl = b.length
c= ["ます", "ません"]; cl = c.length
n.times do puts(a[rand(al)] + b[rand(bl)] + c[rand(cl)]) end
end
