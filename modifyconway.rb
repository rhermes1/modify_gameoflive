#!/usr/bin/env ruby
class Field
  def initialize 
    @field = [] 
  end
  def read_data
    @f = File.new("array.txt", "r")
    @f.each do |row, x|
        row.gsub!(/\n/)
        celle = row.split('')
	celle.delete("\n")
        @field.push(celle)
      end
    @f.close
  end

  def create_data(hight, widht)
    @field = Array.new(hight){ Array.new(widht){" "}}
    @hight, @widht = hight, widht
    set_data
  end

  def set_data
    ende = 0
    while ende != 1 
      system 'clear'
      puts "Moechten sie Cellen ersetzen? (1)Ja (2)Nein (3)Feld anzeigen"
      auswahl = gets.chomp
      auswahl = auswahl.to_i
      case auswahl
        when 1
          puts "Geben sie die Reihe an und dann die Spalte an!"
          x, y = gets.chomp, gets.chomp
          x, y = x.to_i , y.to_i
          if x < @hight && x >= 0 && y < @widht && y >= 0
            celle = @field[x]
            @field.delete_at(x)
            celle.delete_at(y)
            celle.insert(y, "X")
            @field.insert(x, celle)
	  else
	    puts "Die Koordinate existiert nicht"
	    sleep 1.5
	  end
	when 2
	  ende = 1
	when 3 
	  puts self
	  sleep 3 
	else
	  puts "Wiederholen sie ihre Eingabe bitte!"
	  sleep 1.5
        end
    end
  end

  def to_s
    @field.map{ |row| row.join}.join("\n")                                                  
  end
end

class Game < Field
  def search
    @field2 = []
    @field.each_with_index do |row, x|
      zelle = []
      row.each_with_index do |cell, y| 
        alive = checkcelle(x,y)
	 case alive
	   when (2..3)
	     zelle.push("X")
	   when (0..1),(4..8)
	     zelle.push(" ")
         end
       end
       @field2.push(zelle)
    end
    @field = @field2
  end

  def checkcelle(x,y)
     umfeld=[[(-1),1],[(-1),0],[(-1),(-1)],[1,1],[1,(-1)],[1, 0],[0,1],[0,(-1)]]
     alive = 0
     umfeld.each_with_index do |row1, x1|
	 x1 = row1[0]
	 y1 = row1[1]
     end
  end
  
  def torus_feld(x, x1, y, y1)
     puts "x:#{x}x1:#{x1}y:#{y}y1:#{y1}"
     if (x+x1) < @hight && (x+u1) >= 0 && (y+u2) < @widht && (y+u2) >= 0 && @field[x+x1][y+y1] == 'X'
         alive += 1
     end
  alive
  end

  def los
    runden = 0
    while runden < 5000
      system 'clear'
      search
      puts self 
      sleep 1
      runden += 1
    end
  end
end
a = Game.new
puts "Wie soll das Feld eingelesen werden\n (1)Aus array.txt (2)Per Konsole eingeben"
wahl = gets.chomp
wahl.to_i
  if wahl == 1
    a.read_data
  else
    a.create_data(4, 4)
  end
a.los


