defmodule AocTest.Y2022.Day07Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day07

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 1_501_149
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 10_096_985
  end
end
