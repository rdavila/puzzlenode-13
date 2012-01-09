require "spec_helper"

describe Piece::Knight, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:knight) { board.add_piece('e5', 'wN') }

  it "can't leave the king in check" do
    king = board.add_piece('e4', 'wK')
    board.add_piece('e7', 'bR')
    
    knight.is_a_valid_movement?('c4').should == false
    
    king.move_to('e3')
    board.add_piece('e4', 'wP')

    knight.is_a_valid_movement?('c4').should == true
  end

  it 'can move only in L' do
    knight.move_to('c6').should == true
    knight.move_to('d4').should == true

    knight.move_to('c5').should == false
    knight.move_to('d1').should == false
  end

  it "can't go over piece of same color" do
    board.add_piece('f3', 'wP')
    knight.move_to('f3').should == false
  end
end
