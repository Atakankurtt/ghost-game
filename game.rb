require_relative 'player'
require 'set'
class Ghost
    attr_reader :players, :fragment
    def initialize(players, filename)
        @players = players.map { |player| Player.new(player) }
        @dictionary = Set.new(File.open(filename).readlines.map{ |ele| ele.chomp })
        @fragment = ""
    end

    def play_turn
        current_player = @players.shift
        
        if current_player.alive
            p "#{current_player.name}'s turn"
            input = current_player.guess
            @fragment += input
            
            if @dictionary.include?(@fragment)
                current_player.drop_hp
                p "Word was #{@fragment}"
                sleep(2)
                @fragment = ""
            end
        end
        @players << current_player
    end

    def win?
        @players.one? { |ele| ele.alive == true }
    end

    def render
        system('clear')
        @players.each do |player|
            puts "#{player.name} => #{player.ghost}"
        end
        p "#{lost_players} lost."
        p @fragment
    end

    def lost_players
        count = 0
        @players.each do |ele|
            count += 1 if ele.alive == false
        end
        count
    end

    def play
        until win?
            render
            play_turn
        end
        p "CONTGRATS #{@players[-1].name} WON"
    end

    private
    attr_reader :dictionary
end

if $PROGRAM_NAME == __FILE__
    Ghost.new(["Atakan", "Resul", "Çağatay", "Hasan", "Eren"], "dictionary.txt").play
end