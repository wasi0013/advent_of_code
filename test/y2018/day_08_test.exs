defmodule AocTest.Y2018.Day08Test do
  @moduledoc false
  @example [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

  use ExUnit.Case

  test "Part1 Example: #{@example}" do
    assert Aoc.Y2018.Day08.solve_part1(@example) == 138
  end

  test "Part2 Example: #{@example}" do
    assert Aoc.Y2018.Day08.solve_part2(@example) == 66
  end

  test "Part 1 is solved" do
    assert Aoc.Y2018.Day08.run_part1() == 46_829
  end

  test "Part 2 is solved" do
    assert Aoc.Y2018.Day08.run_part2() == 37_450
  end
end
