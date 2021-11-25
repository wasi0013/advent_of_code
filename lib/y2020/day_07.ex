defmodule Aoc.Y2020.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2020/day/7
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_input() |> solve_part1()

  @spec run_part2 :: no_return
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(_data) do
        :unsolved
  end
  def solve_part2(_data) do
    :unsolved
  end

  @spec get_input :: no_return
  defp get_input() do
    get_string_input("2020", "07")
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.split("contain", trim: true)))
    |> Enum.map(fn [bag | bags] -> {String.replace(bag, "bags", "") |> String.trim(), clean_bags(bags)} end)
    |> Enum.map(fn {bag, bags} -> {bag, Enum.map(bags, &split_bags(&1))} end)
    |> Enum.sort_by(fn {_, bags} -> Enum.count(bags) end)
  end

  @spec clean_bags(any) :: [binary]
  defp clean_bags(bags), do: bags |> Enum.at(0) |> String.trim(".") |> String.split(",")
  @spec split_bags(binary) :: [binary]
  defp split_bags(bags), do:
    bags |> String.replace("bags", "") |> String.replace("bag", "") |> String.trim() |> String.split(" ", parts: 2)

  @spec solved_status :: atom()
  def solved_status(), do: :unsolved
end
