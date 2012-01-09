module Piece
  module Validations
    module ClassMethods
      attr_accessor :validators

      def validators
        @validators ||= []
      end

      def validate_with(validator_method)
        validators << validator_method
      end
    end

    def valid_movement?(options = {})
      validators = self.class.validators

      if ignored_validators = options[:ignore_validations]
        validators -= ignored_validators
      end

      return !validators.any? { |m| __send__(m) == false }
    end

    def is_a_valid_movement?(to, options = {})
      @x_displacement, @y_displacement = displacement_to(to)

      return self.valid_movement?(options)
    end

    def check_piece_of_same_color
      algebraic_pos = calculate_position_to(@x_displacement, @y_displacement)
      piece = @board.at(algebraic_pos)

      if !piece.nil? && piece.color == @color
        return false
      end
    end

    def check_if_king_is_in_check
      king_position = @board.get_king_position(@color)

      unless king_position.nil?
        enemy_pieces =  @board.pieces.select do |position, piece|
                          !piece.nil? && piece.color != @color
                        end
        
        unless enemy_pieces.nil?
          self.move_piece_temporaly

          # Recalculate King position if the actual piece is a King
          # because it has changed its position temporaly
          king_position = @board.get_king_position(@color) if self.is_a?(King)

          enemy_pieces.each do |position, piece|
            if piece.is_a_valid_movement?(king_position, 
                                          :ignore_validations => [:check_if_king_is_in_check])
              self.move_to_original_position
              return false
            end
          end

          self.move_to_original_position
        end
      end
    end
  end
end
