defmodule AocTest.Y2021.Day25Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day25

  @tag :slow
  test "Part 1 is solved" do
    assert run_part1() == 435
  end

end
