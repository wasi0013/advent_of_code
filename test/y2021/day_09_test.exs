defmodule AocTest.Y2021.Day09Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day09

  test "Part 1 is solved" do
    assert run_part1() == 631
  end

  test "Part 2 is solved" do
    assert run_part2() == 821_560
  end
end
