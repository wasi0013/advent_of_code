defmodule AocTest.Y2024.Day04Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2024.Day04

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 2447
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 1868
  end
end
