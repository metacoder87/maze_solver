            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver


class Maze

    attr_reader :grid

    def initialize
        @maze = gets_maze
        @grid = []
        IO.readlines(@maze).each do |line|
            @grid << line.chomp.split('')
            puts line
        end
    end
