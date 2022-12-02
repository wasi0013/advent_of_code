defmodule AocTest.Y2022.Day02Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day02

  @example [
    [?A, 32, ?Y],
    [?B, 32, ?X],
    [?C, 32, ?Z]
  ]
  test "Part 1 Example" do
    assert solve_part1(@example) == 15
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 12
  end

  test "Part 1 is solved" do
    assert run_part1() == 12_458
  end

  test "Part 2 is solved" do
    assert run_part2() == 12_683
  end
end
