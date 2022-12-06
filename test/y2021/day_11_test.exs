defmodule AocTest.Y2021.Day11Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day11

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 1644
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 229
  end
end
