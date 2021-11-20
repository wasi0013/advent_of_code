defmodule Aoc.Y2020.Day03 do
  @moduledoc false
  @slopes [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  @tree "#"

  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()
  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

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
    if Enum.at(row2, rem(position, length(row2)))  == @tree do
          traverse(forest, position, right, 1, result + 1)
      else
          traverse(forest, position, right, 1, result)
      end
  end
  defp traverse([row1, _ | forest], position, 1, 2, result) when forest != [] do
    row2 = hd(forest)
    position = rem(position + 1, length(row1))
    if Enum.at(row2, rem(position, length(row2)))  == @tree do
          traverse(forest, position, 1, 2, result + 1)
      else
          traverse(forest, position, 1, 2, result)
      end
  end

  @spec get_input :: no_return
  defp get_input(), do:   get_string_input("2020", "03") |> String.split("\n") |> Enum.map(&String.graphemes/1)
end
