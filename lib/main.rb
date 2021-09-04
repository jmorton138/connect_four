require 'pry'

class GameBoard
    attr_accessor :board_grid, :game_over
    def initialize
        @game_over = false
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

    def render_available_moves(p1_moves, p2_moves, moves = self.board_grid.last(7))
        #locate available moves and move to array
        p_moves = p1_moves + p2_moves
        if p_moves == []
            moves
        else
            moves = moves.map do |item|
                if p_moves.include?(item)
                    until !p_moves.include?(item) do
                        item -=7
                    end
                    item
                else
                    item
                end
            end
        end
        moves
    end

    def validate_player_choice(valid_moves, player_choice)
        if valid_moves.include?(player_choice)
            true
        else
            false
        end
    end

    def update_grid(player_choice, player)
        if player == 1
            self.board_grid.map! {|space| space == player_choice ? 'X' : space}
        elsif player == 2
            self.board_grid.map! {|space| space == player_choice ? 'O' : space}
        end
    end

    def horizontal_game_over?
        grid = self.board_grid
        counter = 1
        i = 0
        winning_row = []
        while counter <= 4 || i < grid.length - 1  do
   
            if grid[i] == grid[i+1] || grid[i] == grid[i-1]
                counter += 1
                winning_row.push(i + 1)
                if counter > 4
                    self.game_over = true
                    return winning_row
                end
            else
                winning_row = []
                counter = 1
            end
            i += 1
        end
    end

    def vertical_game_over?
        grid = self.board_grid
        counter = 1
        i = 0
        winning_column = []
        while i < grid.length - 1  do
            if grid[i] == grid[i+7] || grid[i] == grid[i-7]
                counter += 1
                winning_column.push(i + 1)
                if counter > 4
                    self.game_over = true
                    return winning_column
                end
            # elsif
            #     winning_column = []
            #     counter = 1
            end
            i += 1
        end

    end

    def down_diag_game_over?
        grid = self.board_grid
        counter = 1
        i = 0
        winning_seq = []
        while i < grid.length - 1  do
            if grid[i] == grid[i+8] || grid[i] == grid[i-8]   
                counter += 1
                winning_seq.push(i + 1)
                if counter > 4
                    self.game_over = true
                    return winning_seq
                end
            # else
            #     #winning_seq = []
            #     counter = 1
            end
            i += 1
        end

    end

end

# board = GameBoard.new
# board.vertical_game_over?


# moves = [15, 22, 29, 36]
# for move in moves
#     grid.map! { |space| space == move ? space = "X" : space }
# end