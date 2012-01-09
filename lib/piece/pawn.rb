module Piece
  class Pawn < Piece
    validate_with :check_diagonal_movement
    validate_with :check_one_position
    validate_with :check_two_position
    validate_with :check_forward_movement
    validate_with :check_if_king_is_in_check
    validate_with :check_invalid_movements

    private

      def check_invalid_movements
        x, y = @x_displacement, @y_displacement

        return false if y < 0
        return false unless [-1, 0, 1].include?(x)
        return false unless [1, 2].include?(y)
      end

      def check_forward_movement
        return false if @y_displacement < 0
      end

      def check_diagonal_movement
        if @x_displacement.abs == 1 && @y_displacement == 1
          algebraic_pos = calculate_position_to(@x_displacement, @y_displacement)

          if @board.at(algebraic_pos).nil? || @board.at(algebraic_pos).color == @color
            return false
          end
        end
      end

      def check_one_position
        if @x_displacement == 0 && @y_displacement == 1
          return position_is_free?
        end
      end

      def check_two_position
        required_y_position = @color == :white ? 2 : 7

        if @y_displacement == 2
          if (@position[1].to_i != required_y_position) || @x_displacement != 0
            return false
          end
        elsif @y_displacement > 2
          return false
        end
      end
  end
end
