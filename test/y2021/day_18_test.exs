defmodule AocTest.Y2021.Day18Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day18

  test "Part 1 is solved" do
    assert run_part1() == 4017
  end

  test "Part 2 is solved" do
    assert run_part2() == 4583
  end
end
