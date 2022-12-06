defmodule AocTest.Y2022.Day06Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day06

  test "Part 1 is solved" do
    assert run_part1() == 1235
  end

  test "Part 2 is solved" do
    assert run_part2() == 3051
  end
end
