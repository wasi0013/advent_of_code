defmodule AocTest.Y2020.Day03Test do
  @moduledoc false
  use ExUnit.Case

  test "Part 1 is solved" do
    assert Aoc.Y2020.Day03.run_part1() == 211
  end

  test "Part 2 is solved" do
    assert Aoc.Y2020.Day03.run_part2() == 3_584_591_857
  end
end
