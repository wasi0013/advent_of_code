defmodule AocTest.Y2021.Day03Test do
  @moduledoc false
  use ExUnit.Case
  import Aoc.Y2021.Day03

  @example_transposed [
    ["0", "1", "1", "1", "1", "0", "0", "1", "1", "1", "0", "0"],
    ["0", "1", "0", "0", "0", "1", "0", "1", "0", "1", "0", "1"],
    ["1", "1", "1", "1", "1", "1", "1", "1", "0", "0", "0", "0"],
    ["0", "1", "1", "1", "0", "1", "1", "0", "0", "0", "1", "1"],
    ["0", "0", "0", "1", "1", "1", "1", "0", "0", "1", "0", "0"]
  ]
  @example [
    ["0", "0", "1", "0", "0"],
    ["1", "1", "1", "1", "0"],
    ["1", "0", "1", "1", "0"],
    ["1", "0", "1", "1", "1"],
    ["1", "0", "1", "0", "1"],
    ["0", "1", "1", "1", "1"],
    ["0", "0", "1", "1", "1"],
    ["1", "1", "1", "0", "0"],
    ["1", "0", "0", "0", "0"],
    ["1", "1", "0", "0", "1"],
    ["0", "0", "0", "1", "0"],
    ["0", "1", "0", "1", "0"]
  ]
  test "Part 1 Example" do
    assert solve_part1(@example_transposed) == 198
  end

  test "Part 2 Example" do
    assert solve_part2(@example) == 230
  end

  test "Part 1 is solved" do
    assert run_part1() == 2_648_450
  end

  test "Part 2 is solved" do
    assert run_part2() == 2_845_944
  end
end
