module Piece
  class King < Piece
    validate_with :check_1_position_only
    validate_with :check_piece_of_same_color
    validate_with :check_if_king_is_in_check

    private

    def check_1_position_only
      displacement = [@x_displacement.abs, @y_displacement.abs].sort
      displacement == [0, 1] || displacement == [1, 1]
    end
  end
end
