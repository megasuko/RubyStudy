def initialize_vending_machine
    $num_cans=5
    $payment=0
    return $num_cans,$payment
end
def show_vending_machine
    return $num_cans,$payment
end
def pay(x)
    $payment=$payment+x
    return $num_cans,$payment
end
def pay_back
    $payment=0
    return $num_cans,$payment
end
def buy
    if $payment>=200 && $num_cans>=1
        $payment=$payment-200
        $num_cans=$num_cans-1
    end
    return $num_cans,$payment
end