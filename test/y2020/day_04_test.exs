defmodule AocTest.Y2020.Day04Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day04

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 200
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 116
  end
end
