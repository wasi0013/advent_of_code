defmodule Aoc.Y2024.Day01  do
  @moduledoc """
  Solved https://adventofcode.com/2024/day/1
  """
  import Aoc.Helper.IO
  import Aoc.Helper.Util

  def solve_part1(data) do
    data
    |> rotate90()
    |> then (fn [list1, list2] -> [Enum.sort(list1), Enum.sort(list2)] |>  Enum.zip() |> Enum.map(&Tuple.to_list/1) |> Enum.map(fn [a, b] -> abs(a - b)  end) |> Enum.sum() end)

  end

  def solve_part2(data) do
    data
    |> rotate90()
    |> then (fn [list1, list2] -> Enum.map(list1, fn a -> a * Enum.count(list2, &(a==&1)) end) |> Enum.sum() end)
  end

  def get_input() do
    get_string_input("2024", "01")
    |> String.split("\n")
    |> Enum.map(fn string -> string |> String.split("   ") |> Enum.map(&String.to_integer/1) end)
  end

  def solved_status(), do: :solved
end
