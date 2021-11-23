defmodule Aoc.Y2020.Day06 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/6
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def solve_part2(data) do
    data
    |> Enum.map(fn item -> {Enum.count(String.split(item, "\n")), String.split(item, "\n")} end)
    |> Enum.map(fn {count, strings} ->
      {count, List.flatten(Enum.map(strings, fn string -> Enum.to_list(MapSet.new(String.graphemes(string))) end))}
    end)
    |> Enum.map(fn {c, items} ->
      length(Enum.to_list(MapSet.new(Enum.filter(items, fn char -> Enum.count(items, &(&1 == char)) == c end))))
    end)
    |> Enum.sum()
  end

  @spec get_input() :: no_return
  defp get_input() do
    get_string_input("2020", "06")
    |> String.split("\n\n")
  end
end
