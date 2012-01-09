module Piece
  class Knight < Piece
    validate_with :check_l_movement
    validate_with :check_piece_of_same_color
    validate_with :check_if_king_is_in_check

    private

      def check_l_movement
        [@x_displacement.abs, @y_displacement.abs].sort == [1, 2]
      end
  end
end
