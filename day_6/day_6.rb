class Day6
  class Guard
    attr_accessor :x_pos, :y_pos, :no_of_positions, :direction, :out_of_bounds, :room, :possible_cyclical_options, :obstacle_spots, :loop_found

    def initialize(x_pos, y_pos, direction, room)
      @x_pos = x_pos
      @y_pos = y_pos
      @no_of_positions = 0
      @direction = direction
      @out_of_bounds = false
      @room = room
      @possible_cyclical_options = 0
      @obstacle_spots = {'N' => [], 'S' => [], 'E' => [], 'W' => []}
      @loop_found = false
    end

    def move
      # Define movement deltas for each direction
      deltas = {
        'N' => [0, -1],
        'E' => [1, 0],
        'S' => [0, 1],
        'W' => [-1, 0]
      }
      
      # Define next direction when hitting obstacle
      next_direction = {
        'N' => 'E',
        'E' => 'S',
        'S' => 'W',
        'W' => 'N'
      }

      dx, dy = deltas[@direction]
      new_x = @x_pos + dx
      new_y = @y_pos + dy

      if new_y < 0 || new_y >= room.length || new_x < 0 || new_x >= room[new_y].length
        @out_of_bounds = true
      elsif room[new_y][new_x] == '#'
        @direction = next_direction[@direction]
        if @obstacle_spots[@direction].include?([new_x, new_y])
          @loop_found = true
        end
        @obstacle_spots[@direction] << [new_x, new_y]
      else
        unless room[new_y][new_x] == 'X'
          room[new_y][new_x] = 'X'
          @no_of_positions += 1
        end
        @x_pos = new_x
        @y_pos = new_y
      end
    end
  end

  def part_1
    @guard_room = []
    File.open("day_6_input.txt").each do |line|
      @guard_room << line.chomp.chars
    end

    @guard_room.each_with_index do |line, y|
      line.each_with_index do |loc, x|
        if loc != '#' && loc != '.'
          case loc
          when '^'
            @guard = Guard.new(x, y, 'N', @guard_room)
          when '>'
            @guard = Guard.new(x, y, 'E', @guard_room)
          when 'v'
            @guard = Guard.new(x, y, 'S', @guard_room)
          when '<'
            @guard = Guard.new(x, y, 'W', @guard_room)
          else
            puts "Wtf is this bro? " + loc
          end
        end
      end
    end

    while(!@guard.out_of_bounds)
      @guard.move
    end
    return @guard.no_of_positions
  end

  def part_2
    temp_guard_room = []
    File.open("day_6_input.txt").each do |line|
      temp_guard_room << line.chomp.chars
    end

    guard_x = -1
    guard_y = -1
    guard_direction = ''

    # Find guard starting position
    temp_guard_room.each_with_index do |line, y|
      line.each_with_index do |loc, x|
        if loc != '#' && loc != '.' && loc != 'X'
          guard_x = x
          guard_y = y
          case loc
          when '^'
            guard_direction = 'N'
          when '>'
            guard_direction = 'E'
          when 'v'
            guard_direction = 'S'
          when '<'
            guard_direction = 'W'
          end
        end
      end
    end
    
    cyclical_options = 0
    tested_positions = 0

    @guard_room.each_with_index do |line, y|
      line.each_with_index do |val, x|
        
        tested_positions += 1
        modified_guard_room = @guard_room.map(&:dup)
        modified_guard_room[y][x] = '#'
        
        guard = Guard.new(guard_x, guard_y, guard_direction, modified_guard_room)
        
        while(!guard.out_of_bounds)
          if guard.loop_found
            cyclical_options += 1
            break
          end
          guard.move
        end
      end
    end

    return cyclical_options
  end
end

day6 = Day6.new
puts day6.part_1
puts day6.part_2