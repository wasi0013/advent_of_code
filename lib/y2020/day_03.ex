defmodule Aoc.Y2020.Day03 do
  @moduledoc false
  @slopes [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(),
    do:
      get_string_input("2020", "03")
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(),
    do:
      get_string_input("2020", "03")
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> solve_part2()

  def solve_part1(data) do
    traverse(data, 0, 3, 1, 0)
  end
  def solve_part2(data) do
  @slopes
  |> Enum.map(fn [y, z] -> traverse(data, 0, y, z, 0) end)
  |> Enum.reduce(1, fn e, a -> a * e end)
  end

  def traverse([], _x, _y, _z, result), do: result
  def traverse([_row1 | []], _x, _y, _z, result), do: result
  def traverse([row1 | forest], x, y, 1, result) when forest != [] do
    row2 = hd(forest)
    x = rem(x + y, length(row1))
    if Enum.at(row2, rem(x, length(row2)))  == "#" do
          traverse(forest, x, y, 1, result + 1)
      else
          traverse(forest, x, y, 1, result)
      end
  end
  def traverse([row1, _ | forest], x, 1, 2, result) when forest != [] do
    row2 = hd(forest)
    x = rem(x + 1, length(row1))
    if Enum.at(row2, rem(x, length(row2)))  == "#" do
          traverse(forest, x, 1, 2, result + 1)
      else
          traverse(forest, x, 1, 2, result)
      end
  end
end
