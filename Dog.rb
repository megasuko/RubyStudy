class Dog
    def initialize(name)
        @name=name
        @speed=0.0
        @barkcount=3
    end
    def talk
        puts("my name is "+@name)
    end
    def addspeed(d)
        @speed=@speed+d
        puts("speed="+@speed.to_s)
    end
    def setcount(b)
        @barkcount=b
        puts("setcount="+@barkcount.to_s)
    end
    def bark
        @barkcount.times do puts("bowwow") end
    end
end