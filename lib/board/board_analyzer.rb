module Board
  class BoardAnalyzer
    def self.analyze(board_file_path, movements_file_path)
      board = BoardParser.parse(board_file_path)
      file  = File.new(movements_file_path)

      File.open(File.expand_path("complex_results.txt"), "w") do |f|
        file.readlines.each do |line|
          match = line.match(/(\w+)\s(\w+)/)
          from, to = match[1], match[2]
          piece = board.at(from)

          if !piece.nil? && piece.is_a_valid_movement?(to)
            f.puts "LEGAL"
          else
            f.puts "ILLEGAL"
          end
        end
      end
    end
  end
end

