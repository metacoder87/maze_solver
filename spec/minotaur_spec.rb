            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver

require 'minotaur'

describe "Maze" do
    let(:maze) { Maze.new('maze.txt') }

        describe "#initialize" do
            it "should accept a maze file if given and display the maze" do
                maze
            end
        end

        describe "#gets_maze" do
            it "should print, Enter the name of a text file" do
                input = 'maze.txt'
                allow(maze).to receive(:gets).and_return(input)
                expect { maze.gets_maze }.to output(/Enter the name of a text file/).to_stdout
            end
        end

        describe "#empty?" do
            it "should return true if the given location is empty" do
                expect(maze.empty?([5,1])).to be(true)
                expect(maze.empty?([6,2])).to be(true)
                expect(maze.empty?([4,9])).to be(true)
            end

            it "should return false if the location is not empty" do
                expect(maze.empty?([6,1])).to be(false)
                expect(maze.empty?([4,10])).to be(false)
                expect(maze.empty?([0,7])).to be(false)
            end
        end

        describe "#free_space" do
            it "should not return an empty array" do
                expect(maze.free_space).not_to eq([])
            end

            it "should return an array of all the available free spaces" do
                expect(maze.free_space).to eq([[1, 1], [1, 2], [1, 3], [1, 4], [1, 5], 
                    [1, 6], [1, 7], [1, 8], [1, 9], [1, 11], [1, 12], [1, 13], [1, 14], 
                    [2, 1], [2, 2], [2, 3], [2, 4], [2, 6], [2, 7], [2, 8], [2, 9], [2, 11], 
                    [2, 12], [3, 1], [3, 2], [3, 3], [3, 4], [3, 6], [3, 7], [3, 8], [3, 9], 
                    [3, 11], [3, 12], [3, 13], [3, 14], [4, 1], [4, 2], [4, 3], [4, 4], [4, 6], 
                    [4, 7], [4, 8], [4, 9], [4, 11], [4, 12], [4, 13], [4, 14], [5, 1], [5, 2], 
                    [5, 3], [5, 4], [5, 6], [5, 7], [5, 8], [5, 9], [5, 11], [5, 12], [5, 13], 
                    [5, 14], [6, 2], [6, 3], [6, 4], [6, 6], [6, 7], [6, 8], [6, 9], [6, 10], 
                    [6, 11], [6, 12], [6, 13], [6, 14]])
            end
        end

        describe "#start_space" do
            it "should return the location of the starting 'S'" do
                expect(maze.start_space).to eq([6,1])
            end
        end

        describe "#end_space" do
            it "should return the location of the exit 'E'" do
                expect(maze.end_space).to eq([1,14])
            end
        end

        describe "#dead_end?" do
            it "should return false if the maze has an exit" do
                expect(maze.dead_end?).to be(false)
            end

            it "should return true if the maze has no exit" do
                trap = Maze.new('trap.txt')
                expect(trap.dead_end?).to be(true)
            end
        end

        describe "#take_step" do
            it "should place an X on each chosen step" do
                expect(maze.take_step).to eq("X")
            end
        end

        describe "#end_reached" do
            it "should print the maze solution and exit message" do
                maze.end_space
                expect { maze.end_reached }.to output(/You have escaped the Labyrinth!/).to_stdout
            end
        end

        describe "#move_up" do
            it "should place an X on the space above the S or last X" do
                grid = maze.instance_variable_get(:@grid)
                maze.start_space
                maze.move_up
                expect(grid[5][1]).to eq("X")
                maze.move_up
                expect(grid[4][1]).to eq("X")
                maze.move_up
                expect(grid[3][1]).to eq("X")
                # grid.each { |line| puts line.join('') }
            end
        end

        describe "#move_right" do
            it "should place an X on the space to the right of the S or last X" do
                grid = maze.instance_variable_get(:@grid)
                maze.move_right
                expect(grid[3][2]).to eq("X")
                maze.move_right
                expect(grid[3][3]).to eq("X")
                maze.move_right
                expect(grid[3][4]).to eq("X")
                # grid.each { |line| puts line.join('') }
            end
        end

        describe "#move_down" do
            it "should place an X on the space below the S or last X" do
                grid = maze.instance_variable_get(:@grid)
                maze.move_down
                expect(grid[4][4]).to eq("X")
                maze.move_down
                expect(grid[5][4]).to eq("X")
                # grid.each { |line| puts line.join('') }
            end
        end

        describe "#move_left" do
            it "should place an X on the space to the left of the S or last X" do
                grid = maze.instance_variable_get(:@grid)
                maze.move_left
                expect(grid[5][3]).to eq("X")
                maze.move_left
                expect(grid[5][2]).to eq("X")
                # grid.each { |line| puts line.join('') }
            end
        end

        describe "#up?" do
            it "should return true if the space above is free" do
                expect(maze.up?).to be(true)
            end

            it "should return false if the space above is not free" do
                grid = maze.instance_variable_get(:@grid)
                grid[5][1] = "X"
                maze.start_space
                expect(maze.up?).to be(false)
            end
        end

        describe "#down?" do
            it "should return true if the space below is free" do
                maze.move_up
                maze.move_right
                expect(maze.down?).to be(true)
            end

            it "should return false if the space below is not free" do
                maze.move_down
                expect(maze.down?).to be(false)
            end
        end

        describe "#left?" do
            it "should return true if the space to the left is free" do
                maze.move_right
                maze.move_up
                expect(maze.left?).to be(true)
            end

            it "should return false if the space to the left is not free" do
                maze.start_space
                expect(maze.left?).to be(false)
            end
        end

        describe "#right?" do
            it "should return true if the space to the right is free" do
                expect(maze.right?).to be(true)
            end

            it "should return false if the space to the right is not free" do
                maze.move_right
                maze.move_right
                maze.move_right
                expect(maze.right?).to be(false)
            end
        end

        describe "#path_finder" do
            it "should find a path through the maze if there is one" do
                expect { maze.path_finder }.to output(/You have escaped the Labyrinth!/).to_stdout
            end

            it "should tell you if there is no path to the maze exit" do
                trap = Maze.new('trap.txt')
                expect { trap.path_finder }.to output(/These things happen to Minotaurs sometimes./).to_stdout
            end
        end

end


            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver