defmodule AocTest.Y2021.Day08Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day08

  test "Part 1 is solved" do
    assert run_part1() == 476
  end

  test "Part 2 is solved" do
    assert run_part2() == 1_011_823
  end
end
