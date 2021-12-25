defmodule Aoc.Y2021.Day19  do
  @moduledoc """
  Solved https://adventofcode.com/2021/day/19
  """
  import Aoc.Helper.IO
  
  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(_data) do
    :unsolved
  end
  
  def solve_part2(_data) do
    :unsolved
  end

  defp get_input() do
    get_string_input("2021", "19")
  end

  def solved_status(), do: :unsolved
end
