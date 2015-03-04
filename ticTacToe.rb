class Game
  def initialize
    print "Player1 Name: "
    name1 = gets.chomp
    print "Player2 Name: "
    name2 = gets.chomp

    @player1 = Player.new(name1, 0, "X")
    @player2 = Player.new(name2, 1, "O")

  end
  def start
    game = true

    while game
      @b = GameBoard.new()
      if @b.checkCats(@player1, @player2)
        game = false
        puts "\nCats Game!"
      end
      @b.getBoard(@player1,@player2)
      @player1.getPlayerMove(@player2) unless @b.checkCats(@player1, @player2)
      @b.getBoard(@player1,@player2) unless @b.checkCats(@player1, @player2)
      break if @player1.win
      @player2.getPlayerMove(@player1) unless @b.checkCats(@player1, @player2)
      break if @player2.win


    end


  end


end

class GameBoard
  def initialize
    @Board = [1,2,3,4,5,6,7,8,9]
  end

  def getBoard(play1, play2)
    count = 0
    @Board.map {|i|
      if count == 3
        count = 0
        puts
      end
      if play1.getMoves.include?(i)
        print play1.getPiece
      elsif play2.getMoves.include?(i)
        print play2.getPiece
      else
        print i
      end
      count+=1
    }

  end
  def checkCats(play1, play2)
    if play1.getMoves.count + play2.getMoves.count == 9
      return true
    end
  end
  false


end

class Player
  def initialize(name, turn, piece)
    @name = name
    @turn = turn
    @piece = piece
    @playerMoves = []

  end

  def win()
    wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[7,5,3],[1,5,9]]

    wins.map {|l|
      count = 0
      @playerMoves. map {|p|
        if l.include?(p)
          count+=1
        end
      }
      if count == 3
        puts "\n #{@name} wins!"
        return true
      end
    }
    false

  end

  def getName
    return @name
  end
  def getMoves
    return @playerMoves
  end
  def getTurn
    return @turn
  end
  def getPiece
    return @piece
  end


  def getPlayerMove(player)
    antiMoves = player.getMoves.sort!
    moved = false
    until moved
      print "\n\nChose a valid move: "
      choice = gets.to_i
      if antiMoves.include?(choice) || @playerMoves.include?(choice) || choice < 1 || choice > 9 then moved = false else moved = true end
    end
    puts
    @playerMoves << choice

  end

end


r = Game.new()
r.start()
