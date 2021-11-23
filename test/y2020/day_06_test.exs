defmodule AocTest.Y2020.Day06Test do
  @moduledoc false
  use ExUnit.Case
  import Aoc.Y2020.Day06

  test "Part 1 is solved" do
    assert run_part1() == 6_878
  end

  test "Part 2 is solved" do
    assert run_part2() == 3464
  end
end
