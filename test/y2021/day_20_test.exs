defmodule AocTest.Y2021.Day20Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day20

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 5437
  end

  @tag :slow
  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 19_340
  end
end
