defmodule AocTest.Y2021.Day15Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day15


  test "Part 1 is solved" do
    assert run_part1() == 403
  end
  @tag :slow
  test "Part 2 is solved" do
    assert run_part2() == 2840
  end
end
