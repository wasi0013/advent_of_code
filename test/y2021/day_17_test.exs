defmodule AocTest.Y2021.Day17Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day17

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 5565
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 2118
  end
end
