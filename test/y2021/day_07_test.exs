defmodule AocTest.Y2021.Day07Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day07
  @example [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

  test "Part 1 Example" do
    assert solve_part1(@example) == 37
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 168
  end

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 359_648
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 100_727_924
  end
end
