defmodule Aoc.Y2020.Day03 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/3
  """
  @slopes [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  @tree "#"

  import Aoc.Helper.IO

  def solve_part1(data) do
    traverse(data, 0, 3, 1, 0)
  end

  def solve_part2(data) do
    @slopes
    |> Enum.map(fn [right, down] -> traverse(data, 0, right, down, 0) end)
    |> Enum.reduce(1, fn element, acc -> acc * element end)
  end

  defp traverse([], _position, _right, _down, result), do: result
  defp traverse([_row1 | []], _position, _right, _down, result), do: result

  defp traverse([row1 | forest], position, right, 1, result) when forest != [] do
    row2 = hd(forest)
    position = rem(position + right, length(row1))
    traverse(forest, position, right, 1, result + found_tree?(row2, position))
  end

  defp traverse([row1, _ | forest], position, 1, 2, result) when forest != [] do
    row2 = hd(forest)
    position = rem(position + 1, length(row1))
    traverse(forest, position, 1, 2, result + found_tree?(row2, position))
  end

  defp found_tree?(row, position), do: if(Enum.at(row, rem(position, length(row))) == @tree, do: 1, else: 0)

  def get_input(), do: get_string_input("2020", "03") |> String.split("\n") |> Enum.map(&String.graphemes/1)

  def solved_status(), do: :solved
end
