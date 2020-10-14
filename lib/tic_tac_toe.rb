require 'pry'
class TicTacToe
  attr_accessor :board 
  attr_reader :winner_name

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]
  def initialize
    @board = [
      " "," "," ",
      " "," "," ",
      " "," "," "
    ]

  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move (index, token="X")
    @board[index] = token
  end

  def position_taken? (index)
    @board[index] == " " ? false : true
  end

  def valid_move?(index)
    if (0..8).include? (index)
      if position_taken?(index) == false
        return true
      else
        return false
      end
    end
  end

  def turn
    puts "What position would you like to play? Enter a number 1-9"
    user_input = gets.chomp
    user_index = input_to_index(user_input)
    if valid_move?(user_index)
      move(user_index, current_player)
      display_board
    else
      puts "That is not a valid number"
      user_input = gets.chomp
    end
  end

  def turn_count
    @board.select {|space| space != " "}.count
  end

  def current_player
    if turn_count.even?
      return "X"
    else
      return "O"
    end
  end

  def won?
    player_X = []
    player_O = []
    winner = []
    @board.each_with_index do |position, index|
      
      if position == "X"
        player_X << index
      elsif position == "O"
        player_O << index
      end
    end
    WIN_COMBINATIONS.each do |winning_combo|
      #binding.pry
      if winning_combo & player_O == winning_combo
        winner = winning_combo & player_O 
        @winner_name = "O"
      elsif winning_combo & player_X == winning_combo
        winner = winning_combo & player_X
        @winner_name = "X"
      end
    end
    
    if winner == []
      return false
    else
      return winner
    end
  end

  def full?
    turn_count == 9 ? true : false
  end

  def draw?
    if full?
      if won? == false
        return true
      else
        return false
      end
    else
      return false
    end

  end

  def over?
    won? != false || full? ? true : false
  end

  def winner
    self.won?
    winner_name
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congrats player #{winner}!"
    elsif draw?
      puts "The game has ended in a draw"
    end

  end
end

# ruby tic_tac_toe.rb