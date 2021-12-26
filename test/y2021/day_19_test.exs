defmodule AocTest.Y2021.Day19Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day19

  @tag :slow
  test "Part 1 is solved" do
    assert run_part1() == 467
  end

  @tag :slow
  test "Part 2 is solved" do
    assert run_part2() == 12_226
  end
end
