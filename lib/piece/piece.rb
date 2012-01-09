module Piece
  class Piece
    extend  Validations::ClassMethods
    include Validations

    attr_reader :color, :position, :x_displacement, :y_displacement, :previous_position

    def initialize(color, position, board)
      @board    = board
      @color    = color
      @position = position
    end

    def move_to(to)
      @x_displacement, @y_displacement = displacement_to(to)

      if valid_movement = self.valid_movement?
        @board.move_piece(@position, to, self)

        @previous_position = @position
        @position          = to
      end

      return valid_movement
    end

    def move_to_original_position
      @board.move_piece(@position, @previous_position, self)
      @position          = @previous_position

      unless @previous_piece.nil?
        @board.add_piece(@previous_piece.position, @previous_piece)
      end
    end

    def move_piece_temporaly
      algebraic_pos = calculate_position_to(@x_displacement, @y_displacement)

      @previous_piece = @board.at(algebraic_pos)

      @board.move_piece(@position, algebraic_pos, self)

      @previous_position = @position
      @position          = algebraic_pos
    end

    def displacement_to(to)
      @from_x, @from_y = @position.split(//)
      @to_x, @to_y     = to.split(//)

      x = @to_x.ord - @from_x.ord
      y = if @color == :white
            @to_y.to_i - @from_y.to_i
          else
            @from_y.to_i - @to_y.to_i
          end

      [x, y]
    end

    def calculate_position_to(x, y)
      row, column = @position.split(//)

      column = @color == :white ? column.to_i + y : column.to_i - y
      "#{(row.ord + x).chr}#{column}"
    end

    def position_is_free?
      @board.at(calculate_position_to(@x_displacement, @y_displacement)).nil?
    end
  end
end
