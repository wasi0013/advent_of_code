defmodule AocTest.Y2021.Day17Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day17

  test "Part 1 is solved" do
    assert run_part1() == 5565
  end

  test "Part 2 is solved" do
    assert run_part2() == 2118
  end
end
