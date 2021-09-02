class GameBoard
    attr_reader :board_grid
    def initialize
        @victory = false
        @board_grid = build_board
    end

    def build_board
        array = []
        i = 1
        while i <= 42 do
            array.push(i)
            i += 1
        end
        array
    end

    def render_grid(board_grid)
        for i in board_grid
            if i % 7 == 0 && i != board_grid.last
                if i.to_s.length == 2
                    puts " #{i} "
                else
                    puts " #{i}  "
                end
                puts "---------------------------"
            else
                if i.to_s.length == 2
                    print " #{i} "
                else
                    print " #{i}  "
                end
            end
        end
        puts ""
    end
end

# board = GameBoard.new
# board.render_grid(board.board_grid)