defmodule AocTest.Y2021.Day05Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day05

  @example [
    [0, 9, 5, 9],
    [8, 0, 0, 8],
    [9, 4, 3, 4],
    [2, 2, 2, 1],
    [7, 0, 7, 4],
    [6, 4, 2, 0],
    [0, 9, 2, 9],
    [3, 4, 1, 4],
    [0, 0, 8, 8],
    [5, 5, 8, 2]
  ]
  test "Part 1 Example" do
    assert solve_part1(@example) == 5
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 12
  end

  @tag :slow
  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 6_005
  end

  @tag :slow
  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 23_864
  end
end
