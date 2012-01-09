require "spec_helper"

describe Piece::Piece do
  let(:board) { Board::Board.new }
  let(:piece) { Piece::PieceParser.parse('wP', 'b2', board) }

  it 'can move the piece when movement is valid' do
    board.should_receive(:move_piece).with('b2', 'b4', piece)

    piece.move_to('b4')
    piece.position.should == 'b4'
  end

  it "doesn't change its position if the movement is invalid" do
    piece.move_to('b1')
    piece.position.should == 'b2'

    piece.move_to('b4')
    piece.position.should == 'b4'

    piece.move_to('b6')
    piece.position.should == 'b4'
  end

  it "calculate its displacement" do
    piece.displacement_to('b2').should == [0, 0]
    piece.displacement_to('b5').should == [0, 3]
    piece.displacement_to('d4').should == [2, 2]
    piece.displacement_to('b1').should == [0, -1]

    black_piece = Piece::PieceParser.parse('bP', 'b7', board)
    black_piece.displacement_to('b4').should == [0, 3]
    black_piece.displacement_to('c5').should == [1, 2]
    black_piece.displacement_to('c8').should == [1, -1]
  end

  it 'calculates its position based in x and y axis' do
    piece.calculate_position_to(1, 1).should   == 'c3'
    piece.calculate_position_to(1, 2).should   == 'c4'
    piece.calculate_position_to(-1, -1).should == 'a1'

    black_piece = Piece::PieceParser.parse('bP', 'c7', board)
    black_piece.calculate_position_to(1, 1).should   == 'd6'
    black_piece.calculate_position_to(-2, -1).should   == 'a8'
    black_piece.calculate_position_to(-1, 2).should   == 'b5'
  end

  it "check if the movement is valid without move the piece" do
    # Ensure that validation for check condition doesn't
    # change position
    board.add_piece('c7', 'bQ')
    board.add_piece('e2', 'wK')

    piece.is_a_valid_movement?('b3').should == true
    piece.position.should == 'b2'
    
    piece.is_a_valid_movement?('b4').should == true
    piece.position.should == 'b2'

    piece.is_a_valid_movement?('c3').should == false
    piece.position.should == 'b2'
  end
end
