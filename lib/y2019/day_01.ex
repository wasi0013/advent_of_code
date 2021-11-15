defmodule Aoc.Y2019.Day01 do
  @moduledoc """
  Solved https://adventofcode.com/2019/day/1
  """
  import Aoc.Helper.IO

  @spec run_part1 :: no_return
  def run_part1(), do: get_string_input("2019", "01") |> String.split("\n") |> Enum.map(&String.to_integer/1) |> solve_part1()
  @spec run_part2 :: no_return
  def run_part2(), do: get_string_input("2019", "01") |> String.split("\n") |> Enum.map(&String.to_integer/1) |> solve_part2()
  def solve_part1(data) do
    data
    |> Enum.map(&get_fuel_req/1)
    |> Enum.sum()
  end

  def solve_part2(data) do
    data
    |> Enum.map(&get_added_fuel/1)
    |> Enum.sum()
  end

  def get_input do
    {:ok, data} = File.read("input.txt")

    String.split(data, ["\n"])
    |> Enum.filter(fn item -> item != "" end)
    |> Enum.map(&String.to_integer/1)
  end

  @spec get_fuel_req(integer) :: integer
  def get_fuel_req(mass), do: div(mass, 3) - 2

  @spec get_added_fuel(integer) :: integer
  def get_added_fuel(mass) do
    value = get_fuel_req(mass)
    if value > 0, do: value + get_added_fuel(value), else: 0
  end

end
