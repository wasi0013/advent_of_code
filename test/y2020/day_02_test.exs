defmodule AocTest.Y2020.Day02Test do
  @moduledoc false
  use ExUnit.Case
  @sample [["1", "3", "a", "abcde"], ["1", "3", "b", "cdefg"], ["2", "9", "c", "ccccccccc"]]

  test "Part 1 Example: " do
    assert Aoc.Y2020.Day02.solve_part1(@sample) == 2
  end

  test "Part2 Example: " do
    assert Aoc.Y2020.Day02.solve_part2(@sample) == 1
  end

  test "Part 1 is solved" do
    assert Aoc.Y2020.Day02.run_part1() == 556
  end

  test "Part 2 is solved" do
    assert Aoc.Y2020.Day02.run_part2() == 605
  end
end
