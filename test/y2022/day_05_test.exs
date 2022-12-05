defmodule AocTest.Y2022.Day05Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2022.Day05

  test "Part 1 is solved" do
    assert run_part1() == "SPFMVDTZT"
  end

  test "Part 2 is solved" do
    assert run_part2() == "ZFSJBPRFP"
  end
end
