defmodule AocTest.Y2020.Day07Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day07

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 164
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == :unsolved
  end
end
