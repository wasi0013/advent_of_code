defmodule AocTest.Y2021.Day16Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day16

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 947
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 660_797_830_937
  end
end
