require_relative 'board'

module Board
  module BoardParser
    extend self

    def parse(board_file_path)
        board = Board.new
        board_file = File.new(board_file_path)

        rows = 8
        cols = 'a'

        board_file.readlines.each do |line|
          line.split(/\s/).each do |piece|
            board.add_piece("#{cols}#{rows}", piece)
            cols.succ!
          end
          rows -= 1
          cols = 'a'
        end

        board
    end
  end
end
