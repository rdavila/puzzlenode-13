require "spec_helper"

describe Board::BoardParser do
  it 'checks if the file exists at initialization' do
    lambda do
      Board::BoardParser.parse('dont_exist.txt')
    end.should raise_error(/No such file/)
  end

  it 'returns a new Board after parsing the file' do
    board = Board::BoardParser.parse(File.expand_path('simple_board.txt'))

    board.should be_an_instance_of(Board::Board)
  end
end
