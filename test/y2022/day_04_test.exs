defmodule AocTest.Y2022.Day04Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day04

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 573
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 867
  end
end
