module Piece
  class Rook < Piece
    validate_with :check_straight_line_movement
    validate_with :check_piece_in_the_way
    validate_with :check_for_piece_of_same_color
    validate_with :check_if_king_is_in_check

    private

      def check_straight_line_movement
        xy = [@x_displacement.abs, @y_displacement.abs]
        return !(xy.sort.join =~ /0[1-8]/).nil?
      end

      def check_piece_in_the_way
        x, y    = @x_displacement.abs, @y_displacement.abs
        advance = [@x_displacement, @y_displacement].find { |i| i != 0 }

        (1...advance.abs).each do |i|
          i = advance < 0 ? -(i) : i
          xy_advance  = y > 0 ? [0, i] : [i, 0]

          algebraic_pos = calculate_position_to(*xy_advance)

          return false unless @board.at(algebraic_pos).nil?
        end
      end

      def check_for_piece_of_same_color
        algebraic_pos = calculate_position_to(@x_displacement, @y_displacement)

        unless self.position_is_free?
          return false if @board.at(algebraic_pos).color == @color
        end
        
      end
  end
end
