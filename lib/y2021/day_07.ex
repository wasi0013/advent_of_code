defmodule Aoc.Y2021.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/7
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> min_fuel_cost()
  def solve_part2(data), do: data |> min_fuel_cost(false)

  def min_fuel_cost(positions, simple \\ true), do: Enum.min(Enum.map(positions, &fuel_cost(positions, &1, simple)))
  def fuel_cost(positions, fuel, true), do: Enum.sum(Enum.map(positions, fn pos -> abs(pos - fuel) end))

  def fuel_cost(positions, fuel, false),
    do: Enum.sum(Enum.map(positions, fn pos -> div(abs(pos - fuel) * (abs(pos - fuel) + 1), 2) end))

  defp get_input(), do: get_integer_input("2021", "07", ",")

  def solved_status(), do: :unsolved
end
