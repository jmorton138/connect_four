# 1. Arrange -> set up the test (examples: initializing objects, let
#               variables, updating values of instance variables).
# 2. Act ->     execute the logic to test (example: calling a method to run).
# 3. Assert ->  expect the results of arrange & act.


# In general, you probably have 4 different types of methods:
# 1. Command - Changes the observable state, but does not return a value.
# 2. Query - Returns a result, but does not change the observable state.
# 3. Script - Only calls other methods, usually without returning anything.
# 4. Looping Script - Only calls other methods, usually without returning
#    anything, and stops when certain conditions are met.


#game start
#create a grid for my board
#render board to terminal using puts
#game_loop :
## player 1 chooses avaliable space(X)
## validate space (error loop for this case)
## game updates available spaces by incrementing chosen space by -7 and substituting space with player symbol
##game checks if 4 in a row, if so game loop ends
## loop resumes for alternate player (O)
require_relative '../lib/main.rb'

describe GameBoard do
    describe "#render_available_moves" do
        context "when no moves have been played at start of the game" do
            subject(:board_at_start) { described_class.new }

            it "returns spaces: [36, 37, 38, 39, 40, 41, 42]" do
                first_row = [36, 37, 38, 39, 40, 41, 42]
                p1_moves = []
                p2_moves = []
                expect(board_at_start.render_available_moves([], [])).to eq(first_row)
                board_at_start.render_available_moves(p1_moves, p2_moves)
            end
        end

        context "when one move has been played at space #36 on first row" do
            subject(:board_after_move) { described_class.new }

            it "returns spaces: [29, 37, 38, 39, 40, 41, 42]" do
                moves = [29, 37, 38, 39, 40, 41, 42]
                p1_moves = [36]
                p2_moves = []
                expect(board_after_move.render_available_moves(p1_moves, p2_moves)).to eq(moves)
                board_after_move.render_available_moves(p1_moves, p2_moves)
            end
        end

        context "when moves have been played at spaces #36 and #40 on first row" do
            subject(:after_two_moves) { described_class.new }

            it "returns spaces: [29, 37, 38, 39, 33, 41, 42]" do
                moves = [29, 37, 38, 39, 33, 41, 42]
                p1_moves = [36]
                p2_moves = [40]
                expect(after_two_moves.render_available_moves(p1_moves, p2_moves)).to eq(moves)
                after_two_moves.render_available_moves(p1_moves, p2_moves)
            end
        end

        context "when there are two moves on the same column(#36 and #29)" do
            subject(:mult_moves_same_col) { described_class.new }

            it "returns spaces: [22, 37, 38, 39, 40, 41, 42]" do
                moves = [22, 37, 38, 39, 40, 41, 42]
                p1_moves = [36]
                p2_moves = [29]
                expect(mult_moves_same_col.render_available_moves(p1_moves, p2_moves)).to eq(moves)
                mult_moves_same_col.render_available_moves(p1_moves, p2_moves)
            end
        end

        context "when there are many moves on the same column(#36, #29, & #22)" do
            subject(:mult_moves_same_col) { described_class.new }

            it "returns spaces: [15, 37, 38, 39, 40, 41, 42]" do
                moves = [15, 37, 38, 39, 40, 41, 42]
                p1_moves = [36, 22]
                p2_moves = [29]
                expect(mult_moves_same_col.render_available_moves(p1_moves, p2_moves)).to eq(moves)
                mult_moves_same_col.render_available_moves(p1_moves, p2_moves)
            end
        end

        context "when there are many moves on the same column(column A: #36, #29, #22, column B: #40, #33) across multiple rows (" do
            subject(:mult_moves_across_col) { described_class.new }

            it "returns spaces: [15, 37, 38, 39, 26, 41, 42]" do
                moves = [15, 37, 38, 39, 26, 41, 42]
                p1_moves = [36, 22, 33]
                p2_moves = [29, 40]
                expect(mult_moves_across_col.render_available_moves(p1_moves, p2_moves)).to eq(moves)
                mult_moves_across_col.render_available_moves(p1_moves, p2_moves)
            end
        end
    end

    describe "#validate_player_choice" do
        context "when player chooses valid move" do
            subject(:valid_move) { described_class.new }

            it "returns true" do
                valid_moves = [15, 37, 38, 39, 26, 41, 42]
                player_choice = 37
                expect(valid_move.validate_player_choice(valid_moves, player_choice)).to eq(true)
                valid_move.validate_player_choice(valid_moves, player_choice)
            end
        end

        context "when player chooses invalid move" do
            subject(:invalid_move) { described_class.new }

            it "returns false" do
                valid_moves = [15, 37, 38, 39, 26, 41, 42]
                player_choice = 55
                expect(invalid_move.validate_player_choice(valid_moves, player_choice)).to eq(false)
                invalid_move.validate_player_choice(valid_moves, player_choice)
            end
        end
    end

    describe "#update_grid" do
        context "when player 1 moves to space #41" do
            subject(:update_game_p1) { described_class.new }
            
            it "changes value from 41 to X" do
                player_choice = 41
                grid = update_game_p1.board_grid
                expect{ update_game_p1.update_grid(player_choice, 1) }.to change { grid[40] }.from(41).to('X')
                update_game_p1.update_grid(player_choice, 1)
            end
        end

        context "when player 2 moves to space #39" do
            subject(:update_game_p2) { described_class.new }

            it "changes value from 39 to O" do
                player_choice = 39
                grid = update_game_p2.board_grid
                expect{ update_game_p2.update_grid(player_choice, 2) }.to change { grid[38] }.from(39).to('O')
                update_game_p2.update_grid(player_choice, 2)
            end
        end
    end

    describe "#horizontal_game_over?" do
        context "when horizontal 4 in row at 36, 37, 38, 39" do
            subject(:win_row) { described_class.new }

            before do
                moves = [36, 37, 38, 39]
                for move in moves
                    win_row.board_grid.map! { |space| space == move ? space = "X" : space }
                end
            end

            it "changes @game_over to true" do
                expect{ win_row.horizontal_game_over? }.to change { win_row.game_over }.from(false).to(true)
                win_row.horizontal_game_over?
            end

            it "returns winning sequence" do
                winning_row = [36, 37, 38, 39]
                expect(win_row.horizontal_game_over?).to eq(winning_row)
                win_row.horizontal_game_over?
            end
        end

        context "when horizontal 4 in a row with other moves on the board before winning row" do
            subject(:win_row_complex) { described_class.new }

            before do
                p1_moves = [36, 37, 38, 39]
                for move in p1_moves
                    win_row_complex.board_grid.map! { |space| space == move ? space = "X" : space }
                end
                p2_moves = [29, 30, 31]
                for move in p2_moves
                    win_row_complex.board_grid.map! { |space| space == move ? space = "O" : space }
                end
            end

            it "changes @game_over to true" do
                expect{ win_row_complex.horizontal_game_over? }.to change { win_row_complex.game_over }.from(false).to(true)
                win_row_complex.horizontal_game_over?
            end

            it "returns winning sequence" do
                winning_row = [36, 37, 38, 39]
                expect(win_row_complex.horizontal_game_over?).to eq(winning_row)
                win_row_complex.horizontal_game_over?
            end
        end

    end

    describe "#vertical_game_over?" do
        context "when vertical 4 in a column at 15, 22, 29, 36" do
            subject(:win_column) { described_class.new }
            before do
                moves = [15, 22, 29, 36]
                for move in moves
                    win_column.board_grid.map! { |space| space == move ? space = "X" : space }
                end
            end

            it "changes @game_over to true" do
                expect{ win_column.vertical_game_over? }.to change { win_column.game_over }.from(false).to(true)
                win_column.vertical_game_over?
            end

            it "returns winning sequence" do
                winning_column = [15, 22, 29, 36]
                expect(win_column.vertical_game_over?).to eq(winning_column)
                win_column.vertical_game_over?
            end

        end

        context "when vertical 4 in a column with other moves after winning column" do
            subject(:win_col_complex) { described_class.new }

            before do
                p1_moves = [37, 38, 39, 40]
                for move in p1_moves
                    win_col_complex.board_grid.map! { |space| space == move ? space = "X" : space }
                end
                p2_moves = [9, 16, 23, 30]
                for move in p2_moves
                    win_col_complex.board_grid.map! { |space| space == move ? space = "O" : space }
                end
            end

            it "changes @game_over to true" do
                expect{ win_col_complex.vertical_game_over? }.to change { win_col_complex.game_over }.from(false).to(true)
                win_col_complex.vertical_game_over?
            end

            it "returns winning sequence" do
                winning_column = [9, 16, 23, 30]
                expect(win_col_complex.vertical_game_over?).to eq(winning_column)
                win_col_complex.vertical_game_over?
            end
        end
    end

    describe "#down_diag_game_over?" do
        context "when 4 in a down slope diagonal" do
            subject(:win_down_diag) { described_class.new }
            before do
                moves = [16, 24, 32, 40]
                for move in moves
                    win_down_diag.board_grid.map! { |space| space == move ? space = 'X' : space}
                end
            end

            it "changes @game_over to true" do
                expect{ win_down_diag.down_diag_game_over? }.to change { win_down_diag.game_over }.from(false).to(true)
                win_down_diag.down_diag_game_over?
            end

            it "returns winning sequence" do
                winning_seq = [16, 24, 32, 40]
                expect(win_down_diag.down_diag_game_over?).to eq(winning_seq)
                win_down_diag.down_diag_game_over?
            end
        end

        context "when 4 in a down slope diagonal with partial down diagonals above winning line" do
            subject(:win_down_diag_complex) { described_class.new }

            before do
                p1_moves = [9, 17, 25, 23]
                for move in p1_moves
                    win_down_diag_complex.board_grid.map! { |space| space == move ? space = "X" : space }
                end
                p2_moves = [16, 24, 32, 40]
                for move in p2_moves
                    win_down_diag_complex.board_grid.map! { |space| space == move ? space = "O" : space }
                end
            end

            it "change @game_over to true" do
                expect{ win_down_diag_complex.down_diag_game_over? }.to change { win_down_diag_complex.game_over }.from(false).to(true)
                win_down_diag_complex.down_diag_game_over?
            end

            it "returns winning sequence" do
                winning_seq = [16, 24, 32, 40]
                expect(win_down_diag_complex.down_diag_game_over?).to eq(winning_seq)
                win_down_diag_complex.down_diag_game_over?
            end

        end
    end

    describe "#up_diag_game_over?" do
        context "when up diagonal 4 in a row" do
            subject(:win_up_diag) { described_class.new }
            before do
                moves = [36, 30, 24, 18]
                for move in moves
                    win_up_diag.board_grid.map! { |space| space == move ? space = 'X' : space}
                end
            end
            it "changes @game_over to true" do
                expect{ win_up_diag.up_diag_game_over? }.to change { win_up_diag.game_over }.from(false).to(true)
                win_up_diag.up_diag_game_over?
            end

            it "returns winning sequence" do
                winning_seq = [36, 30, 24, 18]
                expect(win_up_diag.up_diag_game_over?).to eq(winning_seq)
                win_up_diag.up_diag_game_over?
            end
        end

        context "when up diagonal 4 in a row with partial up diagonals above" do
            subject(:win_up_diag_complex) { described_class.new }
            before do
                p1_moves = [36, 30, 24, 18]
                for move in p1_moves
                    win_up_diag_complex.board_grid.map! { |space| space == move ? space = "X" : space }
                end
                p2_moves = [29, 23, 17]
                for move in p2_moves
                    win_up_diag_complex.board_grid.map! { |space| space == move ? space = "O" : space }
                end
            end

            it "changes @game_over to true" do
                expect{ win_up_diag_complex.up_diag_game_over? }.to change { win_up_diag_complex.game_over }.from(false).to(true)
                win_up_diag_complex.up_diag_game_over?
            end

            it "returns winning sequence" do
                winning_seq = [36, 30, 24, 18]
                expect(win_up_diag_complex.up_diag_game_over?).to eq(winning_seq)
                win_up_diag_complex.up_diag_game_over?
            end
            
        end
    end

    describe "#game_loop" do
        context "when @game_over is true" do
            subject(:loop) { described_class.new }
            
            it "stops loop" do
                loop.game_over = true
                game_over_message = "Game completed"
                expect(loop).to receive(:puts).with(game_over_message)
                loop.game_loop
            end
        end

        # context "when @game_over is false for 4 turns and true 1 turn" do
        #     subject(:loop_4_times) { described_class.new }
        #     before do
        #         allow(loop_4_times).to receive(:@game_over).and_return(false, false, false, false, false, true)
        #     end
        #     it "renders gameboard 4 times" do
        #         expect(loop_4_times).to receive(:render_grid).exactly(4).times
        #         expect(loop_4_times).to receive(:render_available_moves).exactly(4).times
        #         loop_4_times.game_loop
        #     end

        #     # it "validates players move once" do
        #     # end

        #     # it "updates player 1's mover array once" do
        #     # end

        #     # it "checks for 4 in a row once" do
        #     # end

        #     # it "doesn't receive player 2's prompt" do
        #     # end

        #     # it "stops loop" do
        #     #     game_over_message = "Game Over"
        #     #     expect(loop_once).not_to receive(:puts).with(game_over_message)
        #     #     loop_once.game_loop
        #     # end
        # end
    end

end

# 1   2   3   4   5   6   7  
# ---------------------------
#  8   9   10  11  12  13  14 
# ---------------------------
#  15  16  17  18  19  20  21 
# ---------------------------
#  22  23  24  25  26  27  28 
# ---------------------------
#  29  30  31  32  33  34  35 
# ---------------------------
#  36  37  38  39  40  41  42 

# rspec spec/connect_four_spec.rb 


# when player enters invalid then valid move 
# when p1 wins
# when p2 wins