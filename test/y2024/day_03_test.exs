defmodule AocTest.Y2024.Day03Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2024.Day03

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 179_571_322
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 103_811_193
  end
end
