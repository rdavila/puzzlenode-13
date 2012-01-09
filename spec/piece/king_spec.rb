require "spec_helper"

describe Piece::King, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:king) { board.add_piece('d5', 'wK') }

  it 'cam move only one position' do
    king.is_a_valid_movement?('d4').should == true
    king.is_a_valid_movement?('c5').should == true
    king.is_a_valid_movement?('c6').should == true
    king.is_a_valid_movement?('d6').should == true
    king.is_a_valid_movement?('e6').should == true
    king.is_a_valid_movement?('e5').should == true
    king.is_a_valid_movement?('e4').should == true

    king.is_a_valid_movement?('d7').should == false
    king.is_a_valid_movement?('b5').should == false
  end

  it "can't move over the piece of same color" do
    board.add_piece('d4', 'wP')

    king.is_a_valid_movement?('d4').should == false
  end
end
