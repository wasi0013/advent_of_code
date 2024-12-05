defmodule AocTest.Y2024.Day05Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2024.Day05

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 4569
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 6456
  end
end
