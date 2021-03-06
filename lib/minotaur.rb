            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver


class Maze

    attr_reader :grid
    # reads the maze file and creates the grid array for easy solving
    def initialize(*maze)
        unless maze[0]
            @maze = gets_maze
        else @maze = maze[0]
        end
        @grid = []
        IO.readlines(@maze).each do |line|
            @grid << line.chomp.split('')
        end
    end

    # Asks the user for the maze they want solved
    def gets_maze
        puts "Enter the name of a text file: maze, labyrinth, trap, tartarus\n 
                and prepare to be AMAZED!"
        maze = gets.chomp.to_s
            if maze.include?(".txt")
                maze
            else maze + '.txt'
            end
    end

    # Determines is a given space is empty or not
    def empty?(location)
        if @grid[location[0]][location[1]] == " "
            true
        else false
        end
    end

    # Returns an array of all the spaces that are available
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

    # Returns an array containing the location of the starting S
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

    # Returns an array containing the location of the ending E
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

    # Determines if the given maze is actually solvable
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

    # Places the X on the next chosen available space
    def take_step
        if @grid[$x][$y] != "E"
            @grid[$x][$y] = "X"
        else end_reached
        end
    end

    # Prints out the maze with whatever moves have been made
    def print
        @grid.each { |line| puts line.join("") }
    end

    # Signals the end of the maze has been found
    def end_reached
        print
        puts "You have escaped the Labyrinth!\n You are free, Minotaur!"
    end

    # Places the X above the S or the last X
    def move_up
        $x -= 1
        take_step
    end

    # Determines if the space above is a free space
    def up?
        free_space.include?([$x.to_i - 1, $y])
    end

    # Places the X below the S or the last X
    def move_down
        $x += 1
        take_step
    end

    # Determines if the space below is a free space
    def down?
        free_space.include?([$x.to_i + 1, $y])
    end

    # Places the X to the right of the S or the last X
    def move_right
        $y += 1
        take_step
    end

    # Determines if the space to the right is a free space
    def right?
        free_space.include?([$x, $y.to_i + 1])
    end

    # Places the X to the left of the S or the last X
    def move_left
        $y -= 1
        take_step
    end

    # Determines if the space to the left is a free space
    def left?
        free_space.include?([$x, $y.to_i - 1])
    end

    # Escapes the maze if it can be done.
        # remove the # blocking out the print statements below to see the path unfold
    def path_finder
        print
        puts "Starting space is #{start_space}"
        puts "Ending space is #{end_space}"
        if dead_end?
            puts "You are trapped forever in an inescapable labyrinth.\n
                    These things happen to Minotaurs sometimes."
        else
            while [$x, $y] != end_space
                if up?
                    move_up
                    # print
                elsif right?
                    move_right
                    # print
                elsif down?
                    move_down
                    # print
                elsif left?
                    move_left
                    # print
                end
            end
        end
    end

end


# Tests (comment out for less clutter in the RSPEC results)

# solvable
Maze.new('maze.txt').path_finder

Maze.new('labyrinth.txt').path_finder
# inescapable
Maze.new('trap.txt').path_finder

Maze.new('tartarus.txt').path_finder

# pick your own maze on the cmd line
Maze.new.path_finder

            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/maze_solver