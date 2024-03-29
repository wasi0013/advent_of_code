defmodule AocTest.Y2020.Day05Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day05
  @example [["F", "B", "F", "B", "B", "F", "F", "L", "R", "L"]]
  test "Part 1 Example" do
    assert solve_part1(@example) == 354
  end

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 864
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 739
  end
end
