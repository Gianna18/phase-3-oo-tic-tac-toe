class TicTacToe
    WIN_COMBINATIONS = [
      [0,1,2], # Top row
      [3,4,5], # Middle row
      [6,7,8], # Bottom row
      [0,3,6], # First column
      [1,4,7], # Second column
      [2,5,8], # Third column
      [0,4,8], # Left diagonal
      [2,4,6]  # Right diagonal
    ]
    def initialize(board = Array.new(9, " "))
      @board = board
    end

    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
      input.to_i - 1
    end

    def move(index, token = "X")
      @board[index] = token
    end

    def position_taken?(index)
      !(@board[index].nil? || @board[index] == " ")
    end

    def valid_move?(index)
      index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end

    def won?
      WIN_COMBINATIONS.detect do |combo|
        @board[combo[0]] == @board[combo[1]] &&
        @board[combo[1]] == @board[combo[2]] &&
        position_taken?(combo[0])
      end
    end

    def full?
      @board.all?{|token| token == "X" || token == "O"}
    end

    def draw?
      !won? && full?
    end

    def over?
      won? || draw?
    end

    def winner
      if winning_combo = won?
        @board[winning_combo.first]
      end
    end

    def turn
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index)
        token = current_player
        move(index, token)
        display_board
      else
        turn
      end
    end

    def play
      turn until over?
      if won?
        puts "Congratulations #{winner}!"
      else
        puts "Cat's Game!"
      end
    end
  end