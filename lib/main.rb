require 'pry'

class GameBoard
    attr_accessor :board_grid, :game_over, :p1_moves, :p2_moves, :og_board_grid
    def initialize
        @game_over = false
        @board_grid = build_board
        @og_board_grid = build_board
        p1_moves = []
        p2_moves = []
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
    def game_over?
        @game_over
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

    def render_available_moves(p1_moves, p2_moves, moves = self.og_board_grid.last(7))
        #locate available moves and move to array
        if p1_moves == nil && p2_moves == nil
            return moves
        elsif p1_moves != nil && p2_moves == nil
            p_moves = p1_moves
        elsif p1_moves == nil && p2_moves != nil
            p_moves = p2_moves
        elsif p1_moves != nil && p2_moves != nil
            p_moves = p1_moves + p2_moves
        end
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
            if self.p1_moves == nil
                self.p1_moves = [player_choice]
            else
               self.p1_moves << player_choice
            end
        elsif player == 2
            self.board_grid.map! {|space| space == player_choice ? 'O' : space}
            if self.p2_moves == nil
                self.p2_moves = [player_choice]
            else
                self.p2_moves << player_choice
            end
        end
    end

    def horizontal_game_over?
        grid = self.board_grid
        i = 0
        winning_seqs = []
        while i < grid.length - 1  do
            if grid[i] == grid[i+1] || grid[i] == grid[i-1]
                flattened = winning_seqs.flatten
                if flattened == [] || flattened.none? { |item| item == (i) } 
                    winning_seqs.push([i+1])
                end
                winning_seqs.map! do |arr|
                    if arr != nil
                        if arr.include?(i)
                            arr.push(i+1)
                            if arr.length == 4
                                self.game_over = true
                                puts "Connect four! #{arr}"
                                return arr
                            end
                        end
                    end
                    arr
                end  
            end
            i += 1
        end
    end

    def vertical_game_over?
        grid = self.board_grid
        i = 0
        winning_seqs = []
        while i < grid.length - 1  do
            if grid[i] == grid[i+7] || grid[i] == grid[i-7]
                flattened = winning_seqs.flatten
                if flattened == [] || flattened.none? { |item| item == (i) } 
                    winning_seqs.push([i+1])
                end
                winning_seqs.map! do |arr|
                    if arr != nil
                        if arr.include?(i-6)
                            arr.push(i+1)
                            if arr.length == 4
                                self.game_over = true
                                puts "Connect four! #{arr}"
                                return arr
                            end
                        end
                    end
                    arr
                end  
            end
            i += 1
        end

    end

    def down_diag_game_over?
        grid = self.board_grid
        i = 0
        winning_seqs = []
        while i < grid.length - 1  do
        if grid[i] == grid[i+8] || grid[i] == grid[i-8]
            flattened = winning_seqs.flatten
            if flattened == [] || flattened.none? { |item| item == (i-7) } 
                winning_seqs.push([i+1])
            end
            winning_seqs.map! do |arr|
                if arr != nil
                    if arr.include?(i-7)
                        arr.push(i+1)
                        if arr.length == 4
                            self.game_over = true
                            puts "Connect four! #{arr}"
                            return arr
                        end
                    end
                end
                arr
            end  
        end
        i += 1
        end
    end

    def up_diag_game_over?
        grid = self.board_grid
        i = 0
        winning_seqs = []
        while i < grid.length - 1  do
        if grid[i] == grid[i+6] || grid[i] == grid[i-6]
            flattened = winning_seqs.flatten
            if flattened == [] || flattened.none? { |item| item == (i-5) } 
                winning_seqs.push([i+1])
            end
            winning_seqs.map! do |arr|
                if arr != nil
                    if arr.include?(i-5)
                        arr.push(i+1)
                        if arr.length == 4
                            self.game_over = true
                            puts "Connect four! #{arr.reverse}"
                            return arr.reverse
                        end
                    end
                end
                arr
            end  
        end
        i += 1
        end
        
    end
    
    def player_move(player)
        puts "Player #{player}, choose your move"
        player_choice = gets.chomp.to_i
    end
    
    def game_loop
        i = 1
        while self.game_over? != true
            if i.odd?
                player = 1
            else
                player = 2
            end
            render_grid(board_grid)
            valid_moves = render_available_moves(self.p1_moves, self.p2_moves)
            puts "Your available moves are: #{valid_moves}"
            until validate_player_choice(valid_moves, player_choice = player_move(player))
                puts "Invalid option."
                player_choice
            end
            update_grid(player_choice, player)
            horizontal_game_over?
            vertical_game_over?
            down_diag_game_over?
            up_diag_game_over?
            i += 1
        end
        puts "Game completed. Player #{player} wins"
        puts ""
        render_grid(board_grid)
        puts ""
    end
end

# board = GameBoard.new
# board.game_loop



