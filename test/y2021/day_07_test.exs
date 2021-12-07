defmodule AocTest.Y2021.Day07Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day07

  test "Part 1 is solved" do
    assert run_part1() == 359_648
  end

  test "Part 2 is solved" do
    assert run_part2() == 100_727_924
  end
end
