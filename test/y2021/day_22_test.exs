defmodule AocTest.Y2021.Day22Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day22

  test "Part 1 is solved" do
    assert run_part1() == 596_598
  end

  test "Part 2 is solved" do
    assert run_part2() == 1_199_121_349_148_621
  end
end
