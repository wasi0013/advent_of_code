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
    |> Enum.map(fn {n, strs} -> {n, List.flatten(Enum.map(strs, fn str -> Enum.uniq(String.graphemes(str)) end))} end)
    |> Enum.map(fn {n, arr} -> length(Enum.uniq(Enum.filter(arr, fn c -> Enum.count(arr, &(&1 == c)) == n end))) end)
    |> Enum.sum()
  end

  @spec get_input() :: no_return
  defp get_input(), do: get_string_input("2020", "06") |> String.split("\n\n")

  @spec solved_status :: atom()
  def solved_status(), do: :solved
end
