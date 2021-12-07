defmodule Aoc.Y2021.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/7
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> min_fuel_cost()
  def solve_part2(data), do: data |> min_fuel_cost(false)

  def min_fuel_cost(data, simple \\ true), do: Enum.min(Enum.map(data, &fuel_cost(data, &1, simple)))
  def fuel_cost(data, fuel, true), do: Enum.sum(Enum.map(data, fn item -> abs(item - fuel) end))

  def fuel_cost(data, fuel, false),
    do: Enum.sum(Enum.map(data, fn item -> div(abs(item - fuel) * (abs(item - fuel) + 1), 2) end))

  defp get_input(), do: get_integer_input("2021", "07", ",")

  def solved_status(), do: :unsolved
end
