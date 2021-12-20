defmodule AocTest.Y2021.Day20Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day20

  test "Part 1 is solved" do
    assert run_part1() == 5437
  end

  @tag :slow
  test "Part 2 is solved" do
    assert run_part2() == 19_340
  end
end
