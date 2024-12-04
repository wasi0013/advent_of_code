defmodule Aoc.Y2024.Day03 do
  @moduledoc """
  Solved https://adventofcode.com/2024/day/3
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> calc()
  def solve_part2(data), do: data |> String.replace(~r/don't\(\)[\s\S]+?(do\(\)|$)/, "") |> calc()

  def calc(str),
    do:
      Regex.scan(~r/mul\((\d{0,3}),(\d{0,3})\)/, str)
      |> Enum.map(fn [_ | string] -> string |> Enum.map(&String.to_integer/1) |> Enum.product() end)
      |> Enum.sum()

  def get_input(), do: get_string_input("2024", "03")

  def solved_status(), do: :solved
end
