defmodule AocTest.Y2021.Day13Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day13
  @tag :slow
  test "Part 1 is solved" do
    assert run_part1() == 671
  end
  @tag :slow
  test "Part 2 is solved" do
    assert run_part2() == [
      [true, true, true, false, false, false, true, true, false, false, true, true,
       true, false, false, true, false, false, true, false, false, true, true,
       false, false, true, true, true, false, false, true, false, false, true,
       false, true, false, false, false, false],
      [true, false, false, true, false, true, false, false, true, false, true,
       false, false, true, false, true, false, false, true, false, true, false,
       false, true, false, true, false, false, true, false, true, false, true,
       false, false, true, false, false, false, false],
      [true, false, false, true, false, true, false, false, false, false, true,
       false, false, true, false, true, true, true, true, false, true, false, false,
       true, false, true, false, false, true, false, true, true, false, false,
       false, true, false, false, false, false],
      [true, true, true, false, false, true, false, false, false, false, true, true,
       true, false, false, true, false, false, true, false, true, true, true, true,
       false, true, true, true, false, false, true, false, true, false, false, true,
       false, false, false, false],
      [true, false, false, false, false, true, false, false, true, false, true,
       false, false, false, false, true, false, false, true, false, true, false,
       false, true, false, true, false, true, false, false, true, false, true,
       false, false, true, false, false, false, false],
      [true, false, false, false, false, false, true, true, false, false, true,
       false, false, false, false, true, false, false, true, false, true, false,
       false, true, false, true, false, false, true, false, true, false, false,
       true, false, true, true, true, true, false]
    ]
  end
end
