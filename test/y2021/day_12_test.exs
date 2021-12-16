defmodule AocTest.Y2021.Day12Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day12

  @example [
    {"dc", "end"},
    {"HN", "start"},
    {"start", "kj"},
    {"dc", "start"},
    {"dc", "HN"},
    {"LN", "dc"},
    {"HN", "end"},
    {"kj", "sa"},
    {"kj", "HN"},
    {"kj", "dc"}
  ]
  test "Part 1 Example" do
    assert solve_part1(@example) == 19
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 103
  end

  test "Part 1 is solved" do
    assert run_part1() == 3497
  end
  @tag :slow
  test "Part 2 is solved" do
    assert run_part2() == 93_686
  end
end
