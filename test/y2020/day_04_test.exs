defmodule AocTest.Y2020.Day04Test do
  @moduledoc false
  use ExUnit.Case

  test "Part 1 is solved" do
    assert Aoc.Y2020.Day04.run_part1() == 200
  end

  test "Part 2 is solved" do
    assert Aoc.Y2020.Day04.run_part2() == 116
  end
end
