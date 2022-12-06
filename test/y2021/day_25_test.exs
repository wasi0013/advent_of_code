defmodule AocTest.Y2021.Day25Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day25

  @tag :slow
  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 435
  end
end
