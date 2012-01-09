require "spec_helper"

describe Piece::Bishop, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:bishop) { board.add_piece('e3', 'wB') }

  it "can't leave the king in check" do
    king = board.add_piece('e2', 'wK')
    board.add_piece('e7', 'bR')
    
    bishop.is_a_valid_movement?('c5').should == false
    
    king.move_to('e1')
    board.add_piece('e2', 'wP')

    bishop.is_a_valid_movement?('c1').should == true
  end

  it "can move only in diagonal" do
    bishop.move_to('h6').should == true
    bishop.move_to('f5').should == false
  end

  it "can't go over other piece" do
    whxite_piece = board.add_piece('g5', 'wP')
    bishop.move_to('h6').should == false
    
    black_piece = board.add_piece('d2', 'bP')
    bishop.move_to('c1').should == false
  end

  it "can't move if there is a piece of same color in the place" do
    whxite_piece = board.add_piece('h6', 'wP')
    bishop.move_to('h6').should == false
  end

  it "can attack the enemy" do
    black_piece = board.add_piece('h6', 'bP')
    bishop.move_to('h6').should == true
  end
end
