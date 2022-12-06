defmodule Aoc.Y2022.Day04 do
  @moduledoc """
  Solved https://adventofcode.com/2022/day/4
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> Enum.count(&fits?/1)
  def solve_part2(data), do: data |> Enum.count(&overlaps?/1)

  def fits?([x1, y1, x2, y2]) when x1 < x2, do: y1 >= y2
  def fits?([x1, _, x1, _]), do: true
  def fits?([_, y1, _, y2]), do: y2 >= y1

  def overlaps?([x1, y1, x2, y2]), do: Range.disjoint?(x1..y1, x2..y2) == false

  def get_input(),
    do:
      get_string_input("2022", "04")
      |> String.split(["\n", ",", "-"], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(4, 4, :discard)

  def solved_status(), do: :solved
end
