defmodule Aoc.Y2021.Day14 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/14
  """
  import Aoc.Helper.IO

  def solve_part1({polymar, pairs}), do: step(polymar, count(polymar), pairs, 10)
  def solve_part2({polymar, pairs}), do: step(polymar, count(polymar), pairs, 40)

  defp step(polymar, pairs_count, _, 0), do: count_chars(pairs_count, polymar) |> subtract_quantity()
  defp step(polymar, pairs_count, pairs, n), do: step(polymar, update_count(pairs_count, pairs), pairs, n - 1)

  defp subtract_quantity(char_counts),
    do: char_counts |> Map.values() |> Enum.min_max() |> then(fn {min, max} -> max - min end)

  defp update_count(pairs_count, pairs) do
    pairs_count
    |> Enum.reduce(%{}, fn {pair, count}, acc ->
      [first, last] = String.graphemes(pair)

      Map.update(acc, first <> Map.get(pairs, pair), count, fn value -> value + count end)
      |> Map.update(Map.get(pairs, pair) <> last, count, fn value -> value + count end)
    end)
  end

  defp count(polymar),
    do:
      polymar
      |> String.graphemes()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(&Enum.join/1)
      |> Enum.frequencies()

  defp count_chars(pairs_count, polymar),
    do:
      Enum.reduce(pairs_count, %{(String.graphemes(polymar) |> Enum.at(-1)) => 1}, fn {pair, count}, acc ->
        Map.update(acc, String.graphemes(pair) |> Enum.at(0), count, fn v -> v + count end)
      end)

  def get_input(), do: get_string_input("2021", "14") |> String.split("\n\n", trim: true) |> parse()

  defp parse([template, pairs]),
    do: {
      template,
      pairs
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, " -> ", trim: true) |> List.to_tuple()))
      |> Map.new()
    }

  def solved_status(), do: :solved
end
