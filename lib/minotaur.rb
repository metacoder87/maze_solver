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

    def empty?(location)
        if @grid[location[0]][location[1]] == " "
            true
        else false
        end
    end

    def free_space
        spaces = []
        @grid.each_with_index do |row, idx|
            row.each_with_index do |col, i|
                location = [idx, i]
                if empty?(location) || @grid[location[0]][location[1]] == "E"
                    spaces << location
                end
            end
        end
        spaces
    end

