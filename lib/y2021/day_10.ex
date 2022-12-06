defmodule Aoc.Y2021.Day10 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/10
  """
  import Aoc.Helper.IO

  @score %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25_137
  }

  def solve_part1(data), do: data |> Enum.map(&parse/1) |> Enum.filter(&is_integer/1) |> Enum.sum()

  def solve_part2(data),
    do: data |> Enum.map(&parse/1) |> Enum.reject(&is_integer/1) |> Enum.map(&get_score/1) |> median()

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
  defp parse(<<brace::binary-size(1)>> <> _str, [pop | _stack]) when brace != pop, do: get_score(brace)
  defp parse("", stack), do: stack

  defp get_score(brace) when is_bitstring(brace), do: Map.get(@score, brace, 0)
  defp get_score(graphemes) when is_list(graphemes), do: Enum.reduce(graphemes, 0, &calc_score/2)

  defp calc_score(")", score), do: score * 5 + 1
  defp calc_score("]", score), do: score * 5 + 2
  defp calc_score("}", score), do: score * 5 + 3
  defp calc_score(">", score), do: score * 5 + 4

  defp median(list), do: Enum.at(Enum.sort(list), div(length(list), 2))
  def get_input(), do: get_string_input("2021", "10") |> String.split("\n", trim: true)

  def solved_status(), do: :solved
end
