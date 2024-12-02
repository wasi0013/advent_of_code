defmodule Aoc.Y2024.Day02 do
  @moduledoc """
  Solved https://adventofcode.com/2024/day/2
  """
  import Aoc.Helper.IO

  def solve_part1(data), do: data |> Enum.map(&process/1) |> Enum.sum()
  def solve_part2(data), do: data |> Enum.map(&dampen/1) |> Enum.sum()

  def process([], _prev, _flag, result), do: result

  def process([h | list], prev, true, result) when h + 1 == prev or h + 2 == prev or h + 3 == prev,
    do: process(list, h, true, result)

  def process([h | list], prev, false, result) when h - 1 == prev or h - 2 == prev or h - 3 == prev,
    do: process(list, h, false, result)

  def process(_list, _prev, _flag, _result), do: 0
  def process([h | list]), do: process(list, h, h > hd(list), 1)

  def dampen(list),
    do:
      0..length(list)
      |> Enum.map(fn x -> list |> List.delete_at(x) |> process() end)
      |> Enum.sum()
      |> then(fn x -> if x > 0, do: 1, else: 0 end)

  def get_input(),
    do:
      get_string_input("2024", "02")
      |> String.split("\n")
      |> Enum.map(fn s -> String.split(s, " ") |> Enum.map(&String.to_integer/1) end)

  def solved_status(), do: :solved
end
