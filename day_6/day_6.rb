class Day6
  class Guard
    attr_accessor :x_pos, :y_pos, :no_of_positions, :direction, :out_of_bounds, :room, :possible_cyclical_options, :coords_to_check

    def initialize(x_pos, y_pos, direction, room)
      @x_pos = x_pos
      @y_pos = y_pos
      @no_of_positions = 1
      @direction = direction
      @out_of_bounds = false
      @room = room
      @possible_cyclical_options = 0
      @coords_to_check = []
    end

    

    def move
      case @direction
      when 'N'
        if room[@y_pos - 1] == nil || room[@y_pos - 1][@x_pos] == nil
          @out_of_bounds = true
        elsif room[@y_pos - 1][@x_pos] == '#'
          @direction = 'E'
          if(@coords_to_check != nil && @coords_to_check.length == 3)
            @coords_to_check.shift
          end
          @coords_to_check << [x_pos, y_pos]
        else
          if is_cyclical_spot(@coords_to_check, x_pos, y_pos)
            puts "" + coords_to_check.join(', ') + ", " + x_pos.to_s + ", " + y_pos.to_s
            @possible_cyclical_options += 1
          end
          unless room[@y_pos - 1][@x_pos] == 'X'
            room[@y_pos - 1][@x_pos] = 'X'
            @no_of_positions += 1
          end
          @y_pos -= 1
        end
      when 'E'
        if room[@y_pos][@x_pos + 1] == nil
          @out_of_bounds = true
        elsif room[@y_pos][@x_pos + 1] == '#'
          @direction = 'S'
          if(@coords_to_check != nil && @coords_to_check.length == 3)
            @coords_to_check.shift
          end
          @coords_to_check << [x_pos, y_pos]
        else
          if is_cyclical_spot(@coords_to_check, x_pos, y_pos)
            puts "" + coords_to_check.join(', ') + ", " + x_pos.to_s + ", " + y_pos.to_s
            @possible_cyclical_options += 1
          end
          unless room[@y_pos][@x_pos + 1] == 'X'
            room[@y_pos][@x_pos + 1] = 'X'
            @no_of_positions += 1
          end
          @x_pos += 1
        end
      when 'S'
        if room[@y_pos + 1] == nil
          @out_of_bounds = true
        elsif room[@y_pos + 1][@x_pos] == '#'
          @direction = 'W'
          if(@coords_to_check != nil && @coords_to_check.length == 3)
            @coords_to_check.shift
          end
          @coords_to_check << [x_pos, y_pos]
        else
          if is_cyclical_spot(@coords_to_check, x_pos, y_pos)
            puts "" + coords_to_check.join(', ') + ", " + x_pos.to_s + ", " + y_pos.to_s
            @possible_cyclical_options += 1
          end
          unless room[@y_pos + 1][@x_pos] == 'X'
            room[@y_pos + 1][@x_pos] = 'X'
            @no_of_positions += 1
          end
          @y_pos += 1
        end
      when 'W'
        if room[@y_pos][@x_pos - 1] == nil
          @out_of_bounds = true
        elsif room[@y_pos][@x_pos - 1] == '#'
          @direction = 'N'
          if(@coords_to_check != nil && @coords_to_check.length == 3)
            @coords_to_check.shift
          end
          @coords_to_check << [x_pos, y_pos]
        else
          if is_cyclical_spot(@coords_to_check, x_pos, y_pos)
            puts "" + coords_to_check.join(', ') + ", " + x_pos.to_s + ", " + y_pos.to_s
            @possible_cyclical_options += 1
          end
          unless room[@y_pos][@x_pos - 1] == 'X'
            room[@y_pos][@x_pos - 1] = 'X'
            @no_of_positions += 1
          end
          @x_pos -= 1
        end
      else
        puts "Bro is lost"
      end
    end

    def is_cyclical_spot(coords_to_check, curr_x, curr_y)
      if coords_to_check != nil && coords_to_check.length == 3 && !coords_to_check.include?([curr_x, curr_y])
        return is_rectangle(coords_to_check[0][0], coords_to_check[0][1], coords_to_check[1][0], coords_to_check[1][1], coords_to_check[2][0], coords_to_check[2][1], curr_x, curr_y)
      end
      false
    end

    def is_rectangle(x1, y1, x2, y2, x3, y3, x4, y4)
      return is_orthogonal(x1, y1, x2, y2, x3, y3) && is_orthogonal(x2, y2, x3, y3, x4, y4) && is_orthogonal(x3, y3, x4, y4, x1, y1)
    end
  
    def is_orthogonal(x1, y1, x2, y2, x3, y3)
      return (x2 - x1) * (x2 - x3) + (y2 - y1) * (y2 - y3) == 0;
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
    @guard_room = []
    File.open("test_input.txt").each do |line|
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

    return @guard.possible_cyclical_options

    # Make a next obstacle function that tells you the next obstacle that would be hit and the direction you would move
    # Then have a hashmap of the obstacles you've already hit and what direction you moved
    # If the set contains the same obstacle and movement, you've found a loop
  end
end

day6 = Day6.new
# puts day6.part_1
puts day6.part_2