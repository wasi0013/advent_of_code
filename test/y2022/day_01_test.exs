defmodule AocTest.Y2022.Day01Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day01

  @example [
    [1000, 2000, 3000],
    [
      4000
    ],
    [
      5000,
      6000
    ],
    [
      7000,
      8000,
      9000
    ],
    [10_000]
  ]

  test "Part 1 Example" do
    assert solve_part1(@example) == 24_000
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 45_000
  end

  test "Part 1 is solved" do
    assert run_part1() == 70_374
  end

  test "Part 2 is solved" do
    assert run_part2() == 2_04_610
  end
end
