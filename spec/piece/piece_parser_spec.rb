require "spec_helper"

describe Piece::PieceParser, '.parse' do

  it 'creates the correct piece' do
    piece = Piece::PieceParser.parse('wP', 'a1', Board::Board.new)
    
    piece.color.should == :white
    piece.position.should == 'a1'
    piece.should be_an_instance_of(Piece::Pawn)
  end

end
