module Piece
  class Queen < Piece
    validate_with :check_piece_of_same_color
    validate_with :check_rook_like_movement
    validate_with :check_bishop_like_movement
    validate_with :check_knight_like_movement
    validate_with :check_rook_or_bishop_movement
    validate_with :check_if_king_is_in_check

    private

      def check_rook_like_movement
        x, y = @x_displacement.abs, @y_displacement.abs

        if [x, y].sort.join =~ /0[1-8]/
          advance = [@x_displacement, @y_displacement].find { |i| i != 0 }

          (1...advance.abs).each do |i|
            i = advance < 0 ? -(i) : i
            xy_advance  = y > 0 ? [0, i] : [i, 0]

            algebraic_pos = calculate_position_to(*xy_advance)

            return false unless @board.at(algebraic_pos).nil?
          end
        end
      end

      def check_bishop_like_movement
        if @x_displacement.abs == @y_displacement.abs
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

      def check_knight_like_movement
        xy = [@x_displacement.abs, @y_displacement.abs]

        if xy.sort == [1, 2]
          return false
        end
      end

      def check_rook_or_bishop_movement
        x, y = @x_displacement.abs, @y_displacement.abs
        rook_like_movement    = !([x, y].sort.join =~ /0[1-8]/).nil?
        bishop_like_movement  = x == y
        
        return (rook_like_movement | bishop_like_movement)
      end

  end
end
