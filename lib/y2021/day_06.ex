defmodule Aoc.Y2021.Day06 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/6
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: solve(data, 80)
  def solve_part2(data), do: solve(data, 256)

  def solve(data, days), do: data |> fish_count() |> simulate(days) |> Enum.sum()
  def fish_count(data), do: Enum.map(0..8, fn n -> Map.get(Enum.frequencies(data), n, 0) end)

  def simulate(fish_count, 0), do: fish_count

  def simulate([zeroth, first, second, third, fourth, fifth, sixth, seventh, eighth], days) do
    simulate([first, second, third, fourth, fifth, sixth, seventh + zeroth, eighth, zeroth], days - 1)
  end

  def get_input(), do: get_integer_input("2021", "06", ",")
  def solved_status(), do: :solved
end
