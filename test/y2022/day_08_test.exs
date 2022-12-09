defmodule AocTest.Y2022.Day08Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day08

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 1814
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 330_786
  end
end
