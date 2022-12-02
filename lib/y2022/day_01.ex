defmodule Aoc.Y2022.Day01 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/1
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data) do
    data
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def solve_part2(data) do
    data
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp get_input() do
    get_string_input("2022", "01")
    |> String.split("\n\n")
    |> Enum.map(fn string -> string |> String.split("\n") |> Enum.map(&String.to_integer/1) end)
  end

  def solved_status(), do: :unsolved
end
