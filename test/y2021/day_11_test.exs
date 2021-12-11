defmodule AocTest.Y2021.Day11Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day11

  test "Part 1 is solved" do
    assert run_part1() == 1644
  end

  test "Part 2 is solved" do
    assert run_part2() == 229
  end
end
