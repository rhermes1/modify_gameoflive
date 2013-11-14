#!/usr/bin/env ruby

class Game
  def initialize(hight, widht)
    @hight, @widht = hight, widht
    @field = Array.new(@hight){ Array.new(@widht){Cell.new}}
  end
  
  def search
    @field.each_with_index do |row, x|
      row.each_with_index do |cell, y| 
        cell.anzahl = checkcelle(x, y)
	cell.set_status
      end
    end
    @field.each{|row| row.each{|cell| cell.set_status}}
  end

  def checkcelle(x, y)
    umfeld=[[(-1),1],[(-1),0],[(-1),(-1)],
            [1,1],[1,(-1)],[1, 0],[0,1],[0,(-1)]]
    check = 0
    alive = 0 
    while check < umfeld.length 
      u1,u2 = umfeld[check][0], umfeld[check][1]
        if (x+u1) < @hight && (x+u1) >= 0 && (y+u2) < @widht && (y+u2) >= 0 && @field[x+u1][y+u2].to_s == 'X'
	  alive += 1
        end
      check += 1
     end 
    alive
  end 

  def to_s
    @field.map{ |row| row.join}.join("\n")
  end

  def go
    runden = 0
    while runden < 5000 
      system 'clear'
      search 
      puts self
      puts runden
      sleep 0.1 
      runden += 1
    end
  end
end

class Cell
  attr_accessor :anzahl, :status
  def initialize
    @status = 0.3 + rand
    @status = @status.to_i
  end

  def set_status 
    @status = case @anzahl
      when (2..3)
        1
      when (0..1),(4..8) 
        0
      end
  end

  def to_s
    if @status == 1
      'X'
    else
      ' ' 
    end
  end
end
a = Game.new(20,40)
a.go
