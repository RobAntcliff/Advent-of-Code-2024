class Day_15
  @@warehouse = []

  def self.warehouse
    @@warehouse
  end

  def part_1
    robot, moves, boxes = get_robot_and_robot_movement("day_15_input.txt")
    # @@warehouse.each do |row|
    #   puts row.join
    # end
    # puts moves

    moves.each_char do |move|
      robot.move(move)
      # puts "Move #{move} - #{robot.x_pos} #{robot.y_pos}"
      # @@warehouse.each do |row|
      #   puts row.join
      # end
      #puts "--------"
    end

    result = 0
    boxes.each do |box|
      result += box.get_coordinate_value
    end
    puts result
  end

  def part_2
    @@warehouse = []
    robot, moves, boxes = get_robot_and_robot_movement("day_15_input.txt", true)
    # @@warehouse.each do |row|
    #   puts row.join
    # end
    # puts moves

    moves.each_char.with_index do |move, i|
      robot.move(move)
      # if i >= 1255
      #   puts "Move #{move} - #{robot.x_pos} #{robot.y_pos}"
      #   @@warehouse.each do |row|
      #     puts row.join
      #   end
      #   puts "--------"
      # end
      # boxes.each do |box|
      #   if box.left_box == box
      #     if(box.right_box.y_pos != box.y_pos || box.right_box.x_pos != box.x_pos + 1)
      #       puts "Blah"
      #       puts "Move #{move} - #{robot.x_pos} #{robot.y_pos}"
      #       @@warehouse.each do |row|
      #         puts row.join
      #       end
      #       puts "--------"
      #       gets
      #     end
      #   end
      # end
      # puts "Move #{move} - #{robot.x_pos} #{robot.y_pos}"
      # @@warehouse.each do |row|
      #   puts row.join
      # end
      # puts "Iteration #{i}"
      # puts "--------"
    
      # gets
    end

    @@warehouse.each do |row|
      puts row.join
    end
    puts "--------"

    result = 0
    boxes.each do |box|
      result += box.get_coordinate_value
    end
    puts result
  end

  class Robot
    attr_accessor :x_pos, :y_pos

    def initialize(x_pos, y_pos)
      @x_pos = x_pos
      @y_pos = y_pos
    end

    def move(move)
      can_move = false
      directions = {
        ">" => [1, 0],
        "<" => [-1, 0],
        "^" => [0, -1],
        "v" => [0, 1]
      }

      if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
        can_move = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].move(move)
      elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
        can_move = false
      else
        can_move = true
      end

      if can_move
        Day_15.warehouse[y_pos][x_pos] = "."
        @x_pos += directions[move][0]
        @y_pos += directions[move][1]
        Day_15.warehouse[y_pos][x_pos] = self
      end
      return can_move
    end

    def to_s
      "@"
    end
  end

  class Box
    attr_accessor :x_pos, :y_pos, :left_box, :right_box

    def initialize(x_pos, y_pos, is_big = false, left_box = nil, right_box = nil)
      @x_pos = x_pos
      @y_pos = y_pos
      @left_box = left_box
      @right_box = right_box
      @is_big = is_big

      # Link boxes together if provided
      left_box.right_box = self if left_box
      right_box.left_box = self if right_box
    end

    def do_move(move)
      directions = {
        ">" => [1, 0],
        "<" => [-1, 0],
        "^" => [0, -1],
        "v" => [0, 1]
      }
      # check if box can move horizontally
      can_move_horizontally = false
      if move == ">"
        if @left_box == self && @right_box.big_move(move)
          can_move_horizontally = true
        else
          if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
            can_move_horizontally = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].big_move(move)
          elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
            can_move_horizontally = false
          else
            can_move_horizontally = true
          end
        end
      elsif move == "<"
        if @right_box == self && @left_box.big_move(move)
          can_move_horizontally = true
        else
          if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
            can_move_horizontally = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].big_move(move)
          elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
            can_move_horizontally = false
          else
            can_move_horizontally = true
          end
        end
      end

      # check if box can move vertically
      can_move_vertically = false
      if(move == "^" || move == "v")
        if Day_15.warehouse[@left_box.y_pos + directions[move][1]][@left_box.x_pos + directions[move][0]] == "#" || Day_15.warehouse[@right_box.y_pos + directions[move][1]][@right_box.x_pos + directions[move][0]] == "#"
          can_move_vertically = false
        elsif Day_15.warehouse[@left_box.y_pos + directions[move][1]][@left_box.x_pos + directions[move][0]] == "." && Day_15.warehouse[@right_box.y_pos + directions[move][1]][@right_box.x_pos + directions[move][0]] == "."
          can_move_vertically = true
        elsif Day_15.warehouse[left_box.y_pos + directions[move][1]][left_box.x_pos + directions[move][0]].is_a?(Box) || Day_15.warehouse[right_box.y_pos + directions[move][1]][right_box.x_pos + directions[move][0]].is_a?(Box)
          box_left = Day_15.warehouse[left_box.y_pos + directions[move][1]][left_box.x_pos + directions[move][0]]
          box_right = Day_15.warehouse[right_box.y_pos + directions[move][1]][right_box.x_pos + directions[move][0]]
          
          if(box_left.is_a?(Box) && box_right.is_a?(Box))
            if(box_left.left_box == box_right.left_box && box_left.right_box == box_right.right_box)
              can_move_vertically = box_left.big_move(move)
            else
              can_move_vertically = box_left.big_move(move) && box_right.big_move(move)
            end
          elsif box_left.is_a?(Box)
            can_move_vertically = box_left.big_move(move)
          elsif box_right.is_a?(Box)
            can_move_vertically = box_right.big_move(move)
          end
        end
      end

      if can_move_vertically
        Day_15.warehouse[left_box.y_pos][left_box.x_pos] = "."
        Day_15.warehouse[right_box.y_pos][right_box.x_pos] = "."
        left_box.x_pos += directions[move][0]
        left_box.y_pos += directions[move][1]
        right_box.x_pos += directions[move][0]
        right_box.y_pos += directions[move][1]
        Day_15.warehouse[left_box.y_pos][left_box.x_pos] = left_box
        Day_15.warehouse[right_box.y_pos][right_box.x_pos] = right_box
      elsif can_move_horizontally
        Day_15.warehouse[y_pos][x_pos] = "."
        @x_pos += directions[move][0]
        @y_pos += directions[move][1]
        Day_15.warehouse[y_pos][x_pos] = self
      end
      
      return can_move_horizontally || can_move_vertically
    end

    def big_move(move)
      if can_move(move)
        do_move(move)
      end
    end

    def can_move(move)
      directions = {
        ">" => [1, 0],
        "<" => [-1, 0],
        "^" => [0, -1],
        "v" => [0, 1]
      }
      # check if box can move horizontally
      can_move_horizontally = false
      if move == ">"
        if @left_box == self && @right_box.can_move(move)
          can_move_horizontally = true
        else
          if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
            can_move_horizontally = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].can_move(move)
          elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
            can_move_horizontally = false
          else
            can_move_horizontally = true
          end
        end
      elsif move == "<"
        if @right_box == self && @left_box.can_move(move)
          can_move_horizontally = true
        else
          if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
            can_move_horizontally = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].can_move(move)
          elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
            can_move_horizontally = false
          else
            can_move_horizontally = true
          end
        end
      end

      # check if box can move vertically
      can_move_vertically = false
      if(move == "^" || move == "v")
        if Day_15.warehouse[@left_box.y_pos + directions[move][1]][@left_box.x_pos + directions[move][0]] == "#" || Day_15.warehouse[@right_box.y_pos + directions[move][1]][@right_box.x_pos + directions[move][0]] == "#"
          can_move_vertically = false
        elsif Day_15.warehouse[@left_box.y_pos + directions[move][1]][@left_box.x_pos + directions[move][0]] == "." && Day_15.warehouse[@right_box.y_pos + directions[move][1]][@right_box.x_pos + directions[move][0]] == "."
          can_move_vertically = true
        elsif Day_15.warehouse[left_box.y_pos + directions[move][1]][left_box.x_pos + directions[move][0]].is_a?(Box) || Day_15.warehouse[right_box.y_pos + directions[move][1]][right_box.x_pos + directions[move][0]].is_a?(Box)
          box_left = Day_15.warehouse[left_box.y_pos + directions[move][1]][left_box.x_pos + directions[move][0]]
          box_right = Day_15.warehouse[right_box.y_pos + directions[move][1]][right_box.x_pos + directions[move][0]]
          
          if(box_left.is_a?(Box) && box_right.is_a?(Box))
            if(box_left.left_box == box_right.left_box && box_left.right_box == box_right.right_box)
              can_move_vertically = box_left.can_move(move)
            else
              can_move_vertically = box_left.can_move(move) && box_right.can_move(move)
            end
          elsif box_left.is_a?(Box)
            can_move_vertically = box_left.can_move(move)
          elsif box_right.is_a?(Box)
            can_move_vertically = box_right.can_move(move)
          end
        end
      end

      return can_move_horizontally || can_move_vertically
    end

    def move(move)
      if(@is_big)
        return big_move(move)
      end

      can_move = false
      directions = {
        ">" => [1, 0],
        "<" => [-1, 0],
        "^" => [0, -1],
        "v" => [0, 1]
      }

      # if the box is big, we need to check if we can move both the left and right side of the box
      

      if Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].is_a?(Box)
        can_move = Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]].move(move)
      elsif Day_15.warehouse[y_pos + directions[move][1]][x_pos + directions[move][0]] == "#"
        can_move = false
      else
        can_move = true
      end

      if can_move
        Day_15.warehouse[y_pos][x_pos] = "."
        @x_pos += directions[move][0]
        @y_pos += directions[move][1]
        Day_15.warehouse[y_pos][x_pos] = self
      end
      return can_move
    end

    def get_coordinate_value
      if @is_big && @left_box == self
        return (y_pos * 100) + x_pos
      elsif !@is_big
        return (y_pos * 100) + x_pos
      else
        return 0
      end
    end

    def to_s
      if left_box.nil? && right_box.nil?
        return "0"
      elsif left_box == self
        return "["
      elsif right_box == self
        return "]"
      else
        return "0"
      end
    end
  end

  def get_robot_and_robot_movement(file_path, big_warehouse = false)
    movement_input = false
    movement = ""
    robot = nil
    boxes = []
    File.read(File.join(__dir__, file_path)).split("\n").each_with_index do |line, index|
      if line.empty?
        movement_input = true
      elsif !movement_input
        @@warehouse << []
        if big_warehouse
          line.split("").each_with_index do |char, char_index|
            if char == "@"
              robot = Robot.new(char_index * 2, index)
              @@warehouse[index] << robot
              @@warehouse[index] << '.'
            elsif char == "O"
              left_box = Box.new(char_index * 2, index, true)
              right_box = Box.new((char_index * 2) + 1, index, true)
              @@warehouse[index] << left_box
              @@warehouse[index] << right_box
              left_box.right_box = right_box
              left_box.left_box = left_box
              right_box.left_box = left_box
              right_box.right_box = right_box
              boxes << left_box
              boxes << right_box
            else
              @@warehouse[index] << char
              @@warehouse[index] << char
            end
          end
        else
          line.split("").each_with_index do |char, char_index|
            if char == "@"
              @@warehouse[index] << Robot.new(char_index, index)
              robot = @@warehouse[index][char_index]
            elsif char == "O"
              @@warehouse[index] << Box.new(char_index, index)
              boxes << @@warehouse[index][char_index]
            else
              @@warehouse[index] << char
            end
          end
        end
      else
        movement += line
      end
    end
    [robot, movement, boxes]
  end
end

day_15 = Day_15.new
# day_15.part_1
day_15.part_2
