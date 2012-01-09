module Piece
  class Bishop < Piece
    validate_with :check_for_piece_of_same_color
    validate_with :check_diagonal_movement
    validate_with :check_piece_in_the_way
    validate_with :check_if_king_is_in_check

    private
    
      def check_diagonal_movement
        @x_displacement.abs == @y_displacement.abs
      end

      def check_for_piece_of_same_color
        unless position_is_free?
          algebraic_pos = calculate_position_to(@x_displacement, @y_displacement)
          !(@board.at(algebraic_pos).color == @color)
        end
      end

      def check_piece_in_the_way
        negative_x = @x_displacement < 0
        negative_y = @y_displacement < 0

        (1...@x_displacement.abs).each do |pos|
          to_x = negative_x ? -(pos) : pos
          to_y = negative_y ? -(pos) : pos

          piece = @board.at(calculate_position_to(to_x, to_y))
          return false unless piece.nil?
        end
      end

  end
end
