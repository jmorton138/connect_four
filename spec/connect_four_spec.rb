#game start
#create a grid for my board
#render board to terminal using puts
#game_loop :
## player 1 chooses avaliable space(X)
## validate space (error loop for this case)
## game updates available spaces by incrementing chosen space by -7 and substituting space with player symbol
##game checks if 4 in a row, if so game loop ends
## loop resumes for alternate player (O)

describe GameBoard do
    describe "#render_available_moves" do
        context "when no moves have been played at start of the game" do
            subject(:board_at_start) { instance_double(described_class.new) }

            it "returns spaces 36-42" do
                first_row = [36, 37, 38, 39, 40, 41, 42]
                p1_moves = []
                p2_moves = []
                expect(board_at_start.render_available_moves([], [])).and_return(first_row)
                board_at_start.render_available_moves(p1_moves, p2_moves)
            end
        end
    end
end
