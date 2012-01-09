module Board
  class Board
    attr_reader :pieces

    def initialize
      @pieces = {}
    end

    def at(position)
      @pieces[position]
    end

    def add_piece(position, piece)
      @pieces[position] = if piece.is_a?(String)
                            Piece::PieceParser.parse(piece, position, self)
                          else
                            piece
                          end
    end

    def move_piece(from, to, piece)
      @pieces[from] = nil
      @pieces[to]   = piece 
    end

    def get_king_position(color)
      piece_hash =  @pieces.select do |position, piece|
                      !piece.nil? && piece.color == color && piece.is_a?(Piece::King)
                    end

      return piece_hash.keys.first unless piece_hash.nil?
    end
  end
end
