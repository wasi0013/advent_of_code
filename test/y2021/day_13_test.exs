defmodule AocTest.Y2021.Day13Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day13
  @tag :slow
  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 671
  end

  @tag :slow
  test "Part 2 is solved" do
    assert solve_part2(get_input()) == :ok
  end
end
