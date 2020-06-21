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

