def initialize_balance
    $balance=0
end
def get_balance
    return $balance
end
def deposit(x)
    $balance=$balance+x
end
def withdraw(x)
    if $balance<=x
        $balance=0
    else
        $balance=$balance-x
    end
end