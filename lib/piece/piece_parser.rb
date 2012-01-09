module Piece
  module PieceParser
    extend self

    require_relative 'pawn'
    require_relative 'rook'
    require_relative 'bishop'
    require_relative 'king'
    require_relative 'queen'
    require_relative 'knight'

    def parse(piece_string, position, board)
      piece_color, piece_type = piece_string.split(//)
      color = (piece_color == 'w') ? :white : :black

      piece = case piece_type
              when 'P'
                Pawn.new(color, position, board)
              when 'R'
                Rook.new(color, position, board)
              when 'B'
                Bishop.new(color, position, board)
              when 'K'
                King.new(color, position, board)
              when 'Q'
                Queen.new(color, position, board)
              when 'N'
                Knight.new(color, position, board)
              end

      return piece
    end
  end
end
