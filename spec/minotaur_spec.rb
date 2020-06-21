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

