defmodule AocTest.Y2021.Day10Test do
  @moduledoc false
  use ExUnit.Case, async: true
  import Aoc.Y2021.Day10
  @example ["[({(<(())[]>[[{[]{<()<>>", "[(()[<>])]({[<{<<[]>>(",
  "{([(<{}[<>[]}>{[]{[(<()>", "(((({<>}<{<{<>}{[]{[]{}",
  "[[<[([]))<([[{}[[()]]]", "[{[{({}]{}}([{[{{{}}([]", "{<[[]]>}<{[{[{[]{()[[[]",
  "[<(<(<(<{}))><([]([]()", "<{([([[(<>()){}]>(<<{{", "<{([{{}}[<[[[<>{}]]]>[]]"]
  test "Part 1 Example" do
    assert solve_part1(@example) == 26_397
  end
  test "Part 2 Example" do
    assert solve_part2(@example) == 288_957
  end

  test "Part 1 is solved" do
    assert run_part1() == 392_421
  end

  test "Part 2 is solved" do
    assert run_part2() == 2_769_449_099
  end
end
