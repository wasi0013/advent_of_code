defmodule AocTest.Y2020.Day01Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day01
  @example [1721, 979, 366, 299, 675, 1456]
  test "Part 1 Example: answer 514579" do
    assert solve_part1(@example) == 514_579
  end

  test "Part 1 is solved" do
    assert run_part1() == 539_851
  end

  test "Part 2 is solved" do
    assert run_part2() == 212_481_360
  end
end
