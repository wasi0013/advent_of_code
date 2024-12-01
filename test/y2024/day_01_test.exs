defmodule AocTest.Y2024.Day01Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2024.Day01

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 1_388_114
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 235_298_53
  end
end
