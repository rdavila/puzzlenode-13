require "spec_helper"

describe Piece::Pawn, 'valid movements' do
  let(:board) { Board::Board.new }
  let(:piece) { board.add_piece('a2', 'wP') }

  context 'white piece' do
    it "can move 2 positions from its initial position" do
      piece.move_to('a4').should == true
    end

    it "can't move more than 2 positions in its initial positions" do
      piece.move_to('a5').should == false
    end

    it "can move 1 position forward" do
      piece.move_to('a3').should == true
      piece.move_to('a4').should == true
      piece.move_to('a6').should == false
    end

    it "can move diagonal only if there is a black piece in place" do
      black_piece = board.add_piece('b3', 'bP')
      piece.move_to('b3').should == true
    end

    it "can't move diagonal if there is not piece present" do
      piece.move_to('b3').should == false
    end

    it "can't move diagonal if there is a piece of the same color" do
      whxite_piece = board.add_piece('b3', 'wP')

      piece.move_to('b3').should == false
    end

    it "can't move forward if there is another piece" do
      white_piece = board.add_piece('a3', 'wP')

      piece.move_to('a3').should == false
    end

    it "can't leave the king in check" do
      black_bishop  = board.add_piece('h4', 'bB')
      white_pawn1   = board.add_piece('e2', 'wP')
      white_pawn2   = board.add_piece('f2', 'wP')
      white_king    = board.add_piece('e1', 'wK')

      white_pawn2.move_to('f4').should == false
      white_pawn2.position.should == 'f2'
    end

    it "can't do any other movements" do
      piece.is_a_valid_movement?('c3').should == false
      piece.is_a_valid_movement?('b1').should == false
      piece.is_a_valid_movement?('b2').should == false
      piece.is_a_valid_movement?('b4').should == false
    end
  end

  context 'black piece' do
    let(:piece) { board.add_piece('c7', 'bP') }

    it "can move 2 positions from its initial position" do
      piece.move_to('c5').should == true
    end

    it "can't move more than 2 positions in its initial positions" do
      piece.move_to('c4').should == false
    end

    it "can move 1 position forward" do
      piece.move_to('c5')
      piece.move_to('c4').should == true
      piece.move_to('c4')
      piece.move_to('c3').should == true
    end

    it "can move diagonal only if there is a white piece in place" do
      white_piece = board.add_piece('b4', 'wP')
      piece.move_to('c5')
      piece.move_to('b4').should == true
    end

    it "can't move diagonal if there is not piece present" do
      piece.move_to('b6').should == false
      piece.move_to('d6').should == false
    end

    it "can't move diagonal if there is a piece of the same color" do
      black_piece = board.add_piece('b6', 'bP')

      piece.move_to('b6').should == false
    end
  end
end
