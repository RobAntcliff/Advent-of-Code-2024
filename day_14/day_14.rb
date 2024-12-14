require 'chunky_png'

def move_robots(space_width = 0, space_height = 0, moves = 0, save_images = false, get_safety_rating = false)

  array_of_positions = []

  File.read(File.join(__dir__, "day_14_input.txt")).split("\n").each do |line|

    match_data = line.match(/p=(\d+),(\d+)\s+v=(-?\d+),(-?\d+)/)
    
    pos = [match_data[1].to_i, match_data[2].to_i]
    velocity = [match_data[3].to_i, match_data[4].to_i]

    array_of_positions << [pos, velocity]
  end

  moves.times do |i|
    array_of_positions.each do |pos, velocity|
      pos[0] = (pos[0] + velocity[0]) % space_width
      pos[1] = (pos[1] + velocity[1]) % space_height
    end

    # Create a new image
    png = ChunkyPNG::Image.new(space_width, space_height, ChunkyPNG::Color::WHITE)

    array_of_positions.each do |pos, velocity|
      png[pos[0], pos[1]] = ChunkyPNG::Color::BLACK
    end

    if(save_images)
      png.save("images/day_14_#{i + 1}.png")
    end
  end

  if(get_safety_rating)
    quadrant1 = 0
    quadrant2 = 0
    quadrant3 = 0
    quadrant4 = 0

    array_of_positions.each do |pos, velocity|  
      if(pos[0] < space_width / 2 && pos[1] < space_height / 2)
        quadrant1 += 1
      elsif(pos[0] > space_width / 2 && pos[1] < space_height / 2)
        quadrant2 += 1
      elsif(pos[0] < space_width / 2 && pos[1] > space_height / 2)
        quadrant3 += 1
      elsif(pos[0] > space_width / 2 && pos[1] > space_height / 2)
        quadrant4 += 1
      end
    end

    return quadrant1 * quadrant2 * quadrant3 * quadrant4
  end
end

puts "Part 1: #{move_robots(101, 103, 100, false, true)}"
# If anyone ever runs this, set the space_width and space_height to the correct values and set the save images to true to see the images
puts "Part 2: #{move_robots(101, 103, 10000,false, false)}" 