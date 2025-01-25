def initialize_board(n)
    $board=Array.new(2*n+1,1)
    n.times do |i|
    $board[n+1+i]=2
    end
    $board[n]=0
    $a=n
    return $board
end
def move(i)
    x=$board[i]
    a=$board[i+1]
    b=$board[i+2]
    c=$board[i-1]
    d=$board[i-2]
    if x==1 && (a==0 || (a==2 && b==0)) 
    $board[i]=0
    $board[$a]=1
    $a=i
    elsif x==2 && (c==0 || (c==1 && d==0))
    $board[i]=0
    $board[$a]=2
    $a=i
    end
    return $board
end