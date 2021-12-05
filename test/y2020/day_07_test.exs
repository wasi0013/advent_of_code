defmodule AocTest.Y2020.Day07Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2020.Day07

  test "Part 1 is solved" do
    assert run_part1() == 164
  end

  test "Part 2 is solved" do
    assert run_part2() == :unsolved
  end
end
