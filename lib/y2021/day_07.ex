defmodule Aoc.Y2021.Day07 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/7
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> cheapest_alignment()
  def cheapest_alignment(positions), do: fuel_cost(positions, median(positions))
  def fuel_cost(positions, fuel), do: Enum.sum(Enum.map(positions, fn pos -> abs(pos - fuel) end))

  def solve_part2(data), do: data |> cheaper_alignment()

  def cheaper_alignment(positions),
    do: positions |> get_range() |> Enum.map(&extra_fuel_cost(positions, &1)) |> Enum.min()

  def extra_fuel_cost(positions, fuel),
    do: Enum.sum(Enum.map(positions, fn pos -> div(abs(pos - fuel) * (abs(pos - fuel) + 1), 2) end))

  defp median(positions), do: Enum.at(Enum.sort(positions), div(length(positions), 2))
  defp get_range(positions), do: Enum.min_max(positions) |> then(fn {min, max} -> min..max end)

  def get_input(), do: get_integer_input("2021", "07", ",")

  def solved_status(), do: :solved
end
