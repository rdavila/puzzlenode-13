require "spec_helper"

describe Piece::Rook, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:rook) { board.add_piece('d4', 'wR') }

  it "can't leave the king in check" do
    king = board.add_piece('d3', 'wK')
    board.add_piece('d7', 'bR')
    
    rook.is_a_valid_movement?('a4').should == false
    
    king.move_to('d2')
    board.add_piece('d3', 'wP')

    rook.is_a_valid_movement?('c4').should == true
  end

  it "can move only in straight line" do
    rook.move_to('d8').should == true
    rook.move_to('d4').should == true

    rook.move_to('e7').should == false
    rook.move_to('b5').should == false
  end

  it "can't go over other piece" do
    white_piece = board.add_piece('d6', 'wP')
    black_piece = board.add_piece('b4', 'bP')

    rook.move_to('d8').should == false
    rook.move_to('a4').should == false
  end

  it "can't move if there is a piece of same color in the place" do
    white_piece = board.add_piece('d8', 'wP')

    rook.move_to('d8').should == false
  end

  it "can attack the enemy" do
    black_piece = board.add_piece('d8', 'bP')

    rook.move_to('d8').should == true
  end

  it "can move 1 position around" do
    rook.move_to('d5').should == true

    rook.move_to('d4')
    rook.move_to('d3').should == true

    rook.move_to('d4')
    rook.move_to('c4').should == true

    rook.move_to('d4')
    rook.move_to('e4').should == true
  end
end
