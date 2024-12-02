defmodule AocTest.Y2024.Day02Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2024.Day02

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 463
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 514
  end
end
