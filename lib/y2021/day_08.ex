defmodule Aoc.Y2021.Day08 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/8
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  @digits %{
    abcdefg: 8,
    acf: 7,
    abdefg: 6,
    abdfg: 5,
    bcdf: 4,
    acdfg: 3,
    acdeg: 2,
    cf: 1,
    abcefg: 0,
    abcdfg: 9
  }
  @default_segments ["a", "b", "c", "d", "e", "f", "g"]

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(&(&1 |> Enum.at(1) |> String.split(" ", trim: true)))
    |> List.flatten()
    |> Enum.filter(fn str -> String.length(str) in [2, 3, 4, 7] end)
    |> Enum.count()
  end

  def solve_part2(data) do
    data
    |> Enum.map(&fix_output(&1, permutations(@default_segments)))
    |> Enum.sum()
  end

  defp fix_output([digits, outputs], perms), do: find_value(perms, digits, outputs, nil)
  defp find_value(_perms, _digits, _outputs, output) when output != nil, do: output
  defp find_value([perm | rest], digits, outputs, _output) do
    output =
      if MapSet.subset?(MapSet.new(to_atoms(digits, perm)), MapSet.new(Map.keys(@digits))) do
        outputs
        |> to_atoms(perm)
        |> Enum.zip([1000, 100, 10, 1])
        |> Enum.map(fn {digit, p} -> p * Map.get(@digits, digit, 0) end)
        |> Enum.sum()
      end
    find_value(rest, digits, outputs, output)
  end
  defp to_atoms(digits, perm), do:
    digits
    |> String.split(" ", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&(to_atom(&1, perm)))
  defp to_atom(digit, perm) do
    Enum.map(digit, fn v -> Map.get(Map.new(Enum.zip(@default_segments, perm)), v) end)
    |> Enum.sort()
    |> Enum.join("")
    |> String.to_atom()
  end
  defp get_input(),
    do: get_string_input("2021", "08") |> String.split("\n") |> Enum.map(&String.split(&1, "|", trim: true))
  def solved_status(), do: :solved
end
