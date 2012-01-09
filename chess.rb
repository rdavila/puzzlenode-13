require File.expand_path('lib/piece/validations')
require File.expand_path('lib/piece/piece')
require File.expand_path('lib/piece/bishop')
require File.expand_path('lib/piece/king')
require File.expand_path('lib/piece/knight')
require File.expand_path('lib/piece/pawn')
require File.expand_path('lib/piece/queen')
require File.expand_path('lib/piece/rook')
require File.expand_path('lib/piece/piece_parser')

require File.expand_path('lib/board/board')
require File.expand_path('lib/board/board_parser')
require File.expand_path('lib/board/board_analyzer')

Board::BoardAnalyzer.analyze(File.expand_path("complex_board.txt"), 
                             File.expand_path("complex_moves.txt"))
