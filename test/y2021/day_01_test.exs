defmodule AocTest.Y2021.Day01Test do
  @moduledoc false
  use ExUnit.Case
  import Aoc.Y2021.Day01
  @example [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
  test "Part 1 Example" do
    assert solve_part1(@example) == 7
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 5
  end

  test "Part 1 is solved" do
    assert run_part1() == 1502
  end

  test "Part 2 is solved" do
    assert run_part2() == 1538
  end
end
