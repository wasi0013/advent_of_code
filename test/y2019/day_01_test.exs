defmodule AocTest.Y2019.Day01Test do
  @moduledoc false

  use ExUnit.Case, async: true

  test "Part1 Example: mass 12" do
    assert Aoc.Y2019.Day01.solve_part1([12]) == 2
  end

  test "Part1 Example: 14" do
    assert Aoc.Y2019.Day01.solve_part1([14]) == 2
  end

  test "Part1 Example: mass 1969" do
    assert Aoc.Y2019.Day01.solve_part1([1969]) == 654
  end

  test "Part1 Example: mass 100756" do
    assert Aoc.Y2019.Day01.solve_part1([100_756]) == 33_583
  end

  test "Part2 Example: mass 14" do
    assert Aoc.Y2019.Day01.solve_part2([14]) == 2
  end

  test "Part2 Example: mass 1969" do
    assert Aoc.Y2019.Day01.solve_part2([1969]) == 966
  end

  test "Part2 Example: mass 100756" do
    assert Aoc.Y2019.Day01.solve_part2([100_756]) == 50_346
  end

  test "Part 1 is solved" do
    assert Aoc.Y2019.Day01.run_part1() == 3_325_342
  end

  test "Part 2 is solved" do
    assert Aoc.Y2019.Day01.run_part2() == 4_985_158
  end
end
