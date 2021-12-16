defmodule AocTest.Y2019.Day04Test do
  @moduledoc false

  use ExUnit.Case, async: true
  @tag :slow
  test "Part 1 is solved" do
    assert Aoc.Y2019.Day04.run_part1() == 1169
  end
  @tag :slow
  test "Part 2 is solved" do
    assert Aoc.Y2019.Day04.run_part2() == 757
  end
end
