defmodule AocTest.Y2021.Day14Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day14

  test "Part 1 is solved" do
    assert run_part1() == 2587
  end

  test "Part 2 is solved" do
    assert run_part2() == 3_318_837_563_123
  end
end
