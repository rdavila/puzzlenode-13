require "spec_helper"

describe Board::Board do
  let(:board) { Board::BoardParser.parse(File.expand_path('complex_board.txt')) }

  it 'returns the piece for a determined position' do
    piece = board.at('a5')
    piece.should_not be_nil
    piece.kind_of?(Piece::Piece).should be_true
  end

  it 'returns nothing when there is not piece on that position' do
    piece = board.at('a2')
    piece.should be_nil
  end

  it "move the piece of position" do
    piece = board.at('f2')

    piece.should_not == nil

    piece.move_to('f3')
    board.at('f3').should == piece
    board.at('f2').should == nil
  end

  it 'can return the position of the white king' do
    board.get_king_position(:white).should == 'e4'
    king = board.at('e4')
    king.move_to('f3')

    board.get_king_position(:white).should == 'f3'
  end

  it 'can return the position of the black king' do
    board.get_king_position(:black).should == 'a8'

    king = board.at('a8')
    king.move_to('a7')

    board.get_king_position(:black).should == 'a7'
  end
end
