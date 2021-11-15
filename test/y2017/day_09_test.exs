defmodule AocTest.Y2017.Day09Test do
  @moduledoc false
  use ExUnit.Case
  test "Part1 Example: {} score of 1" do
    assert Aoc.Y2017.Day09.solve_part1("{}") == 1
  end
  test "Part1 Example:{{{}}}, score of 1 + 2 + 3 = 6" do
    assert Aoc.Y2017.Day09.solve_part1("{{{}}}") == 6
  end
  test "Part1 Example: {{},{}}, score of 1 + 2 + 2 = 5" do
    assert Aoc.Y2017.Day09.solve_part1("{{},{}}") == 5
  end
  test "Part1 Example: {{{},{},{{}}}}, score of 1 + 2 + 3 + 3 + 3 + 4 = 16"  do
    assert Aoc.Y2017.Day09.solve_part1("{{{},{},{{}}}}") == 16
  end
  test "Part1 Example: {<a>,<a>,<a>,<a>}, score of 1"  do
    assert Aoc.Y2017.Day09.solve_part1("{<a>,<a>,<a>,<a>}") == 1
  end
  test "Part1 Example:{{<ab>},{<ab>},{<ab>},{<ab>}}, score of 9"  do
    assert Aoc.Y2017.Day09.solve_part1("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
  end
  test "Part1 Example: {{<!!>},{<!!>},{<!!>},{<!!>}}, score of 9"  do
    assert Aoc.Y2017.Day09.solve_part1("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
  end
  test "Part1 Example: {{<a!>},{<a!>},{<a!>},{<ab>}}, score of 1 + 2 = 3."  do
    assert Aoc.Y2017.Day09.solve_part1("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end
  test "Part 2 Example: <> 0 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<>") == 0
  end
  test "Part 2 Example: <random characters>  17 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<random characters>") == 17
  end

  test "Part 2 Example: <<<<> 3 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<<<<>") == 3
  end

  test "Part 2 Example: <{!>}> 2 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<{!>}>") == 2
  end

  test "Part 2 Example: <!!> 0 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<!!>") == 0
  end

  test "Part 2 Example: <!!!>> 0 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<!!!>>") == 0
  end

  test "Part 2 Example: <{o\"i!a,<{i<a> 10 characters."  do
    assert Aoc.Y2017.Day09.solve_part2("<{o\"i!a,<{i<a>") == 10
  end


  test "Part 1 is solved" do
    assert Aoc.Y2017.Day09.run_part1() == 15_922
  end
  test "Part 2 is solved" do
    assert Aoc.Y2017.Day09.run_part2() == 7314
  end

end
