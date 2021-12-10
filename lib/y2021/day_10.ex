defmodule Aoc.Y2021.Day10 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/10
  """
  import Aoc.Helper.IO

  @symbols %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.filter(&is_integer/1)
    |> Enum.sum()
  end

  def solve_part2(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.reject(&is_integer/1)
    |> Enum.map(&get_score/1)
    |> Enum.sort()
    |> median()
  end

  defp parse(str), do: parse(str, [])
  defp parse("()" <> str, stack), do: parse(str, stack)
  defp parse("<>" <> str, stack), do: parse(str, stack)
  defp parse("{}" <> str, stack), do: parse(str, stack)
  defp parse("[]" <> str, stack), do: parse(str, stack)
  defp parse("[" <> str, stack), do: parse(str, ["]" | stack])
  defp parse("{" <> str, stack), do: parse(str, ["}" | stack])
  defp parse("<" <> str, stack), do: parse(str, [">" | stack])
  defp parse("(" <> str, stack), do: parse(str, [")" | stack])
  defp parse(">" <> str, [">" | stack]), do: parse(str, stack)
  defp parse("]" <> str, ["]" | stack]), do: parse(str, stack)
  defp parse("}" <> str, ["}" | stack]), do: parse(str, stack)
  defp parse(")" <> str, [")" | stack]), do: parse(str, stack)
  defp parse(<<x::binary-size(1)>> <> _str, [y | _stack]) when x != y, do: get_score(x)
  defp parse("", stack), do: stack

  defp get_score(symbol) when is_bitstring(symbol), do: Map.get(@symbols, symbol, 0)

  defp get_score(graphemes) when is_list(graphemes),
    do: Enum.reduce(graphemes, 0, fn v, acc -> acc * 5 + get_value(v) end)

  defp get_value(")"), do: 1
  defp get_value("]"), do: 2
  defp get_value("}"), do: 3
  defp get_value(">"), do: 4

  defp median(positions), do: Enum.at(Enum.sort(positions), div(length(positions), 2))
  defp get_input(), do: get_string_input("2021", "10") |> String.split("\n", trim: true)

  def solved_status(), do: :solved
end
