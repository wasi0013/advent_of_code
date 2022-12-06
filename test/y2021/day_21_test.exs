defmodule AocTest.Y2021.Day21Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day21

  test "Part 1 is solved" do
    assert solve_part1(get_input()) == 995_904
  end

  test "Part 2 is solved" do
    assert solve_part2(get_input()) == 193_753_136_998_081
  end
end
