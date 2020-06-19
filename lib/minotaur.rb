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

    def gets_maze
        puts "Enter the name of a text file containing a maze, and prepare to be amazed!"
        maze = gets.chomp.to_s
            if maze.include?(".txt")
                maze
            else maze + ".txt"
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

    def start_space
        location = []
        @grid.each_with_index do |row, idx|
            row.each_with_index do |col, i|
                if @grid[idx][i] == "S"
                    location << idx
                    location << i
                end
            end
            $x = location[0]
            $y = location[1]
        end
        location
    end

    def end_space
        location = []
        @grid.each_with_index do |row, idx|
            row.each_with_index do |col, i|
                if @grid[idx][i] == "E"
                    location << idx
                    location << i
                end
            end
        end
        location
    end

    def dead_end?
        over = [end_space[0] - 1, end_space[1]]
        under = [end_space[0] + 1, end_space[1]]
        left = [end_space[0], end_space[1] - 1]
        right = [end_space[0], end_space[1] + 1]
            if free_space.include?(over)
                false
            elsif free_space.include?(under)
                false
            elsif free_space.include?(left)
                false
            elsif free_space.include?(right)
                false
            else true
            end
    end


    def take_step
        if @grid[$x][$y] != "E"
            @grid[$x][$y] = "X"
        else end_reached
        end
    end

    def end_reached
        solution = @grid.each { |line| puts line.join("") }
        solution
        puts "You have escaped the Labyrinth!\n You are free, Minotaur!"
    end

    def move_up
        $x -= 1
        take_step
    end

    def up?
        free_space.include?([$x.to_i - 1, $y])
    end

    def move_down
        $x += 1
        take_step
    end

    def down?
        free_space.include?([$x.to_i + 1, $y])
    end

    def move_right
        $y += 1
        take_step
    end

    def right?
        free_space.include?([$x, $y.to_i + 1])
    end

    def move_left
        $y -= 1
        take_step
    end

    def left?
        free_space.include?([$x, $y.to_i - 1])
    end

    def path_finder
        if dead_end?
            puts "You are trapped forever in an inescapable labyrinth.\n
                    These things happen to Minotaurs sometimes."
        else
            while [$x, $y] != end_space
                if up?
                    move_up
                elsif right?
                    move_right
                elsif down?
                    move_down
                elsif left?
                    move_left
                end
            end
        end
    end

end

escape_artist = Maze.new
puts "Starting space is #{escape_artist.start_space}"
puts "Ending space is #{escape_artist.end_space}"
escape_artist.path_finder

#tests that functioned before adding gets_maze

# escape = Maze.new('maze.txt')

# puts "Starting space is #{escape.start_space}"
# puts "Ending space is #{escape.end_space}"
# escape.path_finder

# egress = Maze.new('labyrinth.txt')

# puts "Starting space is #{egress.start_space}"
# puts "Ending space is #{egress.end_space}"
# egress.path_finder


# stuck = Maze.new('trap.txt')

# puts "Starting space is #{stuck.start_space}"
# puts "Ending space is #{stuck.end_space}"
# stuck.path_finder


# tartarus = Maze.new('minos_trap.txt')

# puts "Starting space is #{tartarus.start_space}"
# puts "Ending space is #{tartarus.end_space}"
# tartarus.path_finder


            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver