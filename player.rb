class Player
    attr_reader :health, :name, :alive

    def initialize(name)
        @name = name
        @health = 5
        @alive = @health > 0 ? true : false
    end

    def guess
        p 'Enter a letter.'
        p_guess = gets.chomp.downcase
        if valid_guess(p_guess)
            return p_guess
        end
        p 'Valid input. Make guess again'
        print "=>"
        guess
    end

    def valid_guess(guess)
        return true if guess.length == 1 && ("a".."z").include?(guess)
        false
    end

    def ghost
        var = "GHOST"
        x = 5 - @health
        return "" if x == 0
        var[0...x]
    end

    def drop_hp
        @health -= 1
    end
end