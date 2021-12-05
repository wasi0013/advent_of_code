defmodule AocTest.Y2021.Day02Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day02

  @example [
    ["forward", 5],
    ["down", 5],
    ["forward", 8],
    ["up", 3],
    ["down", 8],
    ["forward", 2]
  ]
  test "Part 1 Example" do
    assert solve_part1(@example) == 150
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 900
  end

  test "Part 1 is solved" do
    assert run_part1() == 1_714_950
  end

  test "Part 2 is solved" do
    assert run_part2() == 1_281_977_850
  end
end
