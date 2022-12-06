defmodule AocTest.Y2022.Day03Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day03

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 8349
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 2681
  end
end
