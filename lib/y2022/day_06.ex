defmodule Aoc.Y2022.Day06 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/6
  """
  import Aoc.Helper.IO

  def run_part1(), do: get_input() |> solve_part1()
  def run_part2(), do: get_input() |> solve_part2()

  def solve_part1(data), do: data |> detect(4)
  def solve_part2(data), do: data |> detect(13)

  def detect(data, num),
    do:
      data
      |> Enum.reduce({[], 0}, fn
        _elem, {cache, count} when length(cache) == num -> {cache, count}
        elem, {cache, count} -> if elem in cache, do: {[elem], count + 1}, else: {[elem | cache], count + 1}
      end)
      |> elem(1)

  defp get_input(), do: get_string_input("2022", "06") |> String.to_charlist()

  def solved_status(), do: :solved
end
