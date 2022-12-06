defmodule AocTest.Y2020.Day03Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day03

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 211
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 3_584_591_857
  end
end
