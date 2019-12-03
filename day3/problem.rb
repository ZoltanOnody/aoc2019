def step? (direction)
  case direction
  when "U"
    return 0, -1
  when "D"
    return 0, 1
  when "R"
    return 1, 0
  when "L"
    return -1, 0
  end
end

def paint (traits, directions, run)
  x, y, steps_taken = 0, 0, 0

  directions.each {|direction|
    stepX, stepY = step? direction[0]
    steps = direction[1..-1].to_i
    (1..steps).each {
      x += stepX
      y += stepY
      steps_taken += 1

      row = traits[[x, y]] || [Float::INFINITY, Float::INFINITY]
      row[run] = [row[run], steps_taken].min
      traits[[x, y]] = row
    }
  }
end

def solve (line1, line2, func)
  traits = {}

  paint traits, line1.split(","), 0
  paint traits, line2.split(","), 1

  min = Float::INFINITY
  traits.each { |key, val|
    next if val[0] + val[1] == Float::INFINITY
    current = func.call key, val
    min = [min, current].min
  }
  return min
end

def solve1 (line1, line2)
  solver1 = ->(key, val) {key[0].abs() + key[1].abs()}
  return solve line1, line2, solver1
end

def solve2 (line1, line2)
  solver2 = ->(key, val) {val[0] + val[1]}
  return solve line1, line2, solver2
end

if __FILE__ == $0
  Lines = ARGF.read.split("\n")
  puts solve1 Lines[0], Lines[1]
  puts solve2 Lines[0], Lines[1]
end
