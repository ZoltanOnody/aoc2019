require "test/unit"
require_relative './problem'

class ProblemTest < Test::Unit::TestCase
  def test_examples_for_problem1
    example1 = solve1 "R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"
    assert_equal 159, example1, "invalid answer"

    example2 = solve1 "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    assert_equal 135, example2, "invalid answer"
 end
 def test_examples_for_problem2
    example1 = solve2 "R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"
    assert_equal 610, example1, "invalid answer"

    example2 = solve2 "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    assert_equal 410, example2, "invalid answer"
 end
end
