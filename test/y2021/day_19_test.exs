defmodule AocTest.Y2021.Day19Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day19
  @example []
  test "Part 1 Example" do
    assert solve_part1(@example) == :unsolved
  end
  test "Part 2 Example" do
    assert solve_part2(@example) == :unsolved
  end
  
  test "Part 1 is solved" do
    assert run_part1() == :unsolved
  end

  test "Part 2 is solved" do
    assert run_part2() == :unsolved
  end
end
