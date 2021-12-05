defmodule AocTest.Y2019.Day02Test do
  @moduledoc false
  use ExUnit.Case, async: true

  test "Part 1 is solved" do
    assert Aoc.Y2019.Day02.run_part1() == 3_516_593
  end

  test "Part 2 is solved" do
    assert Aoc.Y2019.Day02.run_part2() == 7749
  end
end
