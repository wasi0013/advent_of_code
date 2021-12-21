defmodule AocTest.Y2021.Day21Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day21

  test "Part 1 is solved" do
    assert run_part1() == 995_904
  end

  test "Part 2 is solved" do
    assert run_part2() == 193_753_136_998_081
  end
end
