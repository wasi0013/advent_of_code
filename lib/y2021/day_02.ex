defmodule Aoc.Y2021.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/2
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> plan_course(0, 0)
  def plan_course([], width, depth), do: width * depth
  def plan_course([["forward", value] | rest], width, depth), do: plan_course(rest, width + value, depth)
  def plan_course([["down", value] | rest], width, depth), do: plan_course(rest, width, depth + value)
  def plan_course([["up", value] | rest], width, depth), do: plan_course(rest, width, depth - value)

  def solve_part2(data), do: data |> process_aim(0, 0, 0)

  def process_aim([], width, depth, _aim), do: width * depth

  def process_aim([["forward", value] | rest], width, depth, aim),
    do: process_aim(rest, width + value, depth + aim * value, aim)

  def process_aim([["down", value] | rest], width, depth, aim), do: process_aim(rest, width, depth, aim + value)
  def process_aim([["up", value] | rest], width, depth, aim), do: process_aim(rest, width, depth, aim - value)

  defp get_input(),
    do:
      get_string_input("2021", "02")
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [ins, value] -> [ins, String.to_integer(value)] end)

  def solved_status(), do: :solved
end
