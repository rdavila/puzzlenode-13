require "spec_helper"

describe Piece::Queen, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:queen) { board.add_piece('d4', 'wQ') }

  it "can't leave the king in check" do
    king = board.add_piece('d3', 'wK')
    board.add_piece('d7', 'bR')
    
    queen.is_a_valid_movement?('a4').should == false
    
    king.move_to('d2')
    board.add_piece('d3', 'wP')

    queen.is_a_valid_movement?('c4').should == true
  end

  it "can't move over piece of same color" do
    board.add_piece('d3', 'wP')

    queen.is_a_valid_movement?('d3').should == false
  end

  it "can't pass over any piece" do
    board.add_piece('d6', 'wP')
    board.add_piece('b2', 'wP')

    queen.is_a_valid_movement?('d8').should == false
    queen.is_a_valid_movement?('a1').should == false

  end

  it "can move like a Rook" do
    queen.is_a_valid_movement?('d8').should == true
    queen.is_a_valid_movement?('h4').should == true
  end

  it "can move like a Bishop" do
    queen.is_a_valid_movement?('a7').should == true
    queen.is_a_valid_movement?('h8').should == true
  end

  it "can't move like a Knight" do
    queen.is_a_valid_movement?('e6').should == false
    queen.is_a_valid_movement?('b5').should == false
    queen.is_a_valid_movement?('c2').should == false
  end

  it "can move only like a Rook or Bishop" do
    queen.is_a_valid_movement?('e8').should == false
    queen.is_a_valid_movement?('e2').should == false
    queen.is_a_valid_movement?('c7').should == false
  end
end
