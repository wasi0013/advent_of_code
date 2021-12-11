defmodule Aoc.Y2021.Day08 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/8
  """
  import Aoc.Helper.IO

  @digits %{abcdefg: 8, acf: 7, abdefg: 6, abdfg: 5, bcdf: 4, acdfg: 3, acdeg: 2, cf: 1, abcefg: 0, abcdfg: 9}
  @default_segment "abcdefg acf abdefg abdfg bcdf acdfg acdeg cf abcefg abcdfg"

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(&(&1 |> Enum.at(1) |> String.split(" ", trim: true)))
    |> List.flatten()
    |> Enum.filter(fn str -> String.length(str) in [2, 3, 4, 7] end)
    |> Enum.count()
  end

  def solve_part2(data), do: data |> Enum.map(&fix_output(&1, get_map())) |> Enum.sum()

  defp get_map(),
    do:
      @default_segment
      |> String.split(" ")
      |> Enum.map(&{&1, get_fingerprint(get_frequencies(@default_segment), &1)})
      |> Map.new(fn {k, v} -> {v, Map.get(@digits, String.to_atom(k))} end)

  defp fix_output([digits, outputs], digit_map) do
    outputs
    |> String.split(" ", trim: true)
    |> Enum.zip([1000, 100, 10, 1])
    |> Enum.map(&to_number(&1, digit_map, digits))
    |> Enum.sum()
  end

  defp to_number({k, c}, digit_map, digits), do: Map.get(digit_map, get_fingerprint(get_frequencies(digits), k)) * c
  defp get_frequencies(digits), do: Enum.frequencies(String.graphemes(String.replace(digits, " ", "")))
  defp get_fingerprint(map, digit), do: digit |> String.graphemes() |> Enum.map(&Map.get(map, &1, 0)) |> Enum.sum()

  defp get_input(),
    do: get_string_input("2021", "08") |> String.split("\n") |> Enum.map(&String.split(&1, "|", trim: true))

  def solved_status(), do: :solved
end
