defmodule AocTest.Y2022.Day06Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day06

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 1235
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 3051
  end
end
